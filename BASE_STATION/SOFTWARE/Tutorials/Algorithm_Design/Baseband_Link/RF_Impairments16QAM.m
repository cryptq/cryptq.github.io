% Setup signal generation related variables
SampleRate = 2.0e6;
FCarrier = 100.0e6;

M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
numBits = 10000;            % Number of bits to process
numSamplesPerSymbol = 8;    % Oversampling factor

NumSamples = numSamplesPerSymbol * numBits / k;

% Setup raised cosine filter
span = 12;        % Filter span in symbols
rolloff = 0.5;    % Roloff factor of filter
rrcFilter = rcosdesign( rolloff, span, numSamplesPerSymbol );

% Generate signal
dataIn = randi([0 1], numBits, 1);  % Generate vector of binary data

dataInMatrix = reshape(dataIn, length(dataIn)/k, k); % Reshape data into binary 4-tuples
dataSymbolsIn = bi2de(dataInMatrix);                 % Convert to integers

dataMod = qammod(dataSymbolsIn, M);
x = upfirdn(dataMod, rrcFilter, numSamplesPerSymbol, 1);

% Setup block size of data to be sent to (received from) SVE
BlockSize = 10;      % MAKE SURE THIS DIVIDES NumSamples EXACTLY
NumBlocks = round( NumSamples / BlockSize );

if ( BlockSize * NumBlocks ~= NumSamples )
    error( ['BlockSize (' num2str(BlockSize) ') must divide NumSamples (' num2str(NumSamples) ') exactly.'] );
end

% Open SystemVue workspace and select the analysis to be run
% Assumes workspace is in the same directory as the script.
workspace = SystemVue.openWorkspace('RFAmp.wsv');

analysis = workspace.analysis('DF2');
analysis.param('FCarrier').value = FCarrier;
analysis.param('SampleRate').value = SampleRate;
analysis.param('BackOff_dB').value = 10;
analysis.param('BlockSize').value = BlockSize;
analysis.param('RunFromMATLAB').value = 1;  % Set this to 1 to configure the design to be run from MATLAB

y = zeros( NumSamples, 1 );

% Pass blocks of BlockSize samples to SVE and get a block of BlockSize samples back
for n = 1:NumBlocks
     StartIdx = (n-1)*BlockSize + 1;
     StopIdx = n*BlockSize;
     y(StartIdx:StopIdx) = analysis.calculate( x(StartIdx:StopIdx) );
end

workspace.close();

% Compute spectra of input and output signals
DeltaF = SampleRate/NumSamples;
F = (-NumSamples/2:NumSamples/2-1)*DeltaF + FCarrier;
F = F / 1.0e6;  % Convert to MHz
close all;
figure;
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( y(1:NumSamples) ) / NumSamples ) ) );
plot( F, OutVoltSpectrum_dBV );
hold on;
InVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( x(1:NumSamples) ) / NumSamples ) ) );
plot( F, InVoltSpectrum_dBV );
grid on;
title('Input and Output Voltage Spectra');
xlabel('Frequency (MHz)');
ylabel('Voltage Spectrum (dBV)');
legend('Output', 'Input');
legend('Location', 'NorthWest');

% EVM measurement
z = upfirdn(y, rrcFilter, 1, 1);    % filter with receiver RRC filter

NumSymbolsEVM = 300;
FilterSymbolDelay = span; % each filter introduced span/2 delay so total delay is span.


% Manual EVM measurement
StartIdx = FilterSymbolDelay*numSamplesPerSymbol+1;
zDN = z(StartIdx:numSamplesPerSymbol:end);    % exclude transient and downsample
zDNrms = sqrt( mean( abs(zDN).^2 ) );         % compute rx rms
dataModrms = sqrt( mean( abs(dataMod).^2 ) ); % compute reference rms

% scale received signal to match level of reference
scale = dataModrms / zDNrms;
z = scale * z;
zDN = scale *zDN;

errVector = ( zDN(1:NumSymbolsEVM) - dataMod(1:NumSymbolsEVM) );
EVMrmsManual = sqrt( mean( abs(errVector).^2) ) / sqrt( mean( abs( dataMod(1:NumSymbolsEVM) ).^2 ) ) * 100;

% EVM measurement using the communications toolbox EVM object
evm = comm.EVM( );
EVMrms = evm( dataMod(1:NumSymbolsEVM), zDN(1:NumSymbolsEVM) );

% Setup signal generation related variables
SampleRate = 20.0e6;
FCarrier = 100.0e6;

ToneFreg = 1.0e6;
ToneAmp = 0.2;

NumSamples = 2000;

% Generate signal
t = (0:NumSamples-1) / SampleRate;
x = ToneAmp * cos( 2 * pi * ToneFreg * t );

% Setup block size of data to be sent to (received from) SVE
BlockSize = 10;      % MAKE SURE THIS DIVIDES NumSamples EXACTLY
NumBlocks = round( NumSamples / BlockSize );

if ( BlockSize * NumBlocks ~= NumSamples )
    error( ['BlockSize (' num2str(BlockSize) ') must divide NumSamples (' num2str(NumSamples) ') exactly.'] );
end

% Open SystemVue workspace and select the analysis to be run
% Assumes workspace is in the same directory as the script.
workspace = SystemVue.openWorkspace('RFAmp.wsv');

analysis = workspace.analysis('DF1');
analysis.param('FCarrier').value = FCarrier;
analysis.param('SampleRate').value = SampleRate;
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
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( y ) / NumSamples ) ) );
plot( F, OutVoltSpectrum_dBV );
hold on;
InVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( x ) / NumSamples ) ) );
plot( F, InVoltSpectrum_dBV );
grid on;
title('Input and Output Voltage Spectra');
xlabel('Frequency (MHz)');
ylabel('Voltage Spectrum (dBV)');
legend('Output', 'Input');
legend('Location', 'NorthWest');

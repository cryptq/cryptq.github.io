close all
clc
clear

%% Setup SystemVue workspace parameters
c = 3.0e8;
SampleRate = 20.0e6;
PRI = 100.0e-6; %The interval of pulse repeation
Pulsewidth = 10e-6; %The width of pulse
Bandwidth = 5e6; %LFM waveform bandwidth
CPIPulseNum = 32; %The pulse number of 1 CPI

BlockSize = floor(PRI * SampleRate * CPIPulseNum); % The sample number of the input data BlockSize 

FilterBandwidth = 6e6;
BBFreq = 60e6; %
IFFreq = 2.1e9; %
RFFreq = 10e9; %
IFOSPN = [1e3, -60, 16e3, -60, 64e3, -90, 256e3, -90];
IFMixerNF = 0;
IFAmplifierGain = 20;
RFOSPN = [1e3, -60, 16e3, -60, 64e3, -90, 256e3, -90];
RFMixerNF = 0;
RFAmplifierGain = 20;
LNAGain = 30;
LNANF = 1;

NameOfTxAnalysis = 'TxChannelAnalysis'; % Behavior modeling
%NameOfTxAnalysis = 'TxChannelRFLinkAnalysis'; % RFLink modeling
NameOfRxAnalysis = 'RxChannelAnalysis'; % Behavior modeling
%NameOfRxAnalysis = 'RxChannelRFLinkAnalysis'; % RFLink modeling
%NameOfRxAnalysis = 'RxChannelSignalProcessingAnalysis'; % use SV Radar
%library Pulse compression and PD(MTD) processong
%% Generate LFM signal
PulseSampleNum = floor(Pulsewidth * SampleRate + 0.5);
t = (0:PulseSampleNum-1)/SampleRate - Pulsewidth/2;
PRISampleNum = floor(PRI * SampleRate + 0.5);
miu = Bandwidth/Pulsewidth;
LFMWaveform = exp(1i*2*pi*0.5*miu*t.^2);
LFMPRI = [LFMWaveform zeros(1,PRISampleNum - PulseSampleNum)];
x = repmat(LFMPRI,1,CPIPulseNum).';

%% Open SystemVue workspace and select the analysis to be run
% Assumes workspace is in the same directory as the script.
workspace = SystemVue.openWorkspace('RF_Radar.wsv');

analysis = workspace.analysis(NameOfTxAnalysis);

analysis.param('SampleRate').value = SampleRate; % The sample rate of the simulation
analysis.param('PRI').value = PRI; % The interval of pulse repeation
analysis.param('Pulsewidth').value = Pulsewidth; % The width if pulse
analysis.param('Bandwidth').value = Bandwidth; % The bandwidth of LFM waveform
analysis.param('CPIPulseNum').value = CPIPulseNum; % The pulse number of coherent processing interval
analysis.param('FilterBandwidth').value = FilterBandwidth; % The filter pass bandwidth
analysis.param('BBFreq').value = BBFreq; % The frequency of base band signal
analysis.param('IFFreq').value = IFFreq; % The frequency of IF 
analysis.param('IFOSPN').value = IFOSPN; % The phase niose of IF oscillator
analysis.param('IFMixerNF').value = IFMixerNF; % The noise factor of IF mixer
analysis.param('IFAmplifierGain').value = IFAmplifierGain; % The gain of IF amplifier(dB)
analysis.param('RFFreq').value = RFFreq; % The frequency of RF
analysis.param('RFOSPN').value = RFOSPN; % The phase niose of RF oscillator
analysis.param('RFMixerNF').value = RFMixerNF; % The noise factor of RF mixer
analysis.param('RFAmplifierGain').value = RFAmplifierGain; % The gain of RF amplifier(dB)
analysis.param('RunFromMATLAB').value = 1;  % Set this to 1 to configure the design to be run from MATLAB

y = zeros(BlockSize,1);

analysis.start();

analysis.link('LFMSource').setData(x);

RFData = analysis.link('Data').port('RFData').getData();
IFData = analysis.link('Data').port('IFData').getData();
BBData = analysis.link('Data').port('BBData').getData();

analysis.stop();
%% Plot the Tx Baseband, IF and RF signal waveform and spectrum

%Plot Baseband signal spectrum
%FFTSize = 2 ^ (floor(log2(PRISampleNum)) + 1);
FFTSize = PRISampleNum;
DeltaF = SampleRate/FFTSize;
F = (-FFTSize/2:FFTSize/2-1)*DeltaF + BBFreq;
F = F / 1.0e6;  % Convert to MHz

figure('Name','Base Band waveform and spectrum (Tx)','NumberTitle','off');
subplot(3,1,1);
plot((0:PRISampleNum-1)/SampleRate,real(BBData(1:PRISampleNum)))
xlabel('time-s')
hold on
plot((0:PRISampleNum-1)/SampleRate,imag(BBData(1:PRISampleNum)))
grid on
title('Baseband waveform (TX)')
legend('Real','Imag')

subplot(3,1,2)
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( BBData(1:PRISampleNum),FFTSize ) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('Baseband 1 Pulse Spectrum (TX)')

subplot(3,1,3)
BBData = reshape(BBData,PRISampleNum,CPIPulseNum);
DataCoherent = sum(BBData,2);
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( DataCoherent, FFTSize) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('Baseband 32 Pulses Coherent Processing Spectrum (TX)')

%Plot IF signal spectrum
F = (-FFTSize/2:FFTSize/2-1)*DeltaF + IFFreq;
F = F / 1.0e6;  % Convert to MHz

figure('Name','IF waveform and spectrum (Tx)','NumberTitle','off');

subplot(3,1,1);
plot((0:PRISampleNum-1)/SampleRate,real(IFData(1:PRISampleNum)))
grid on
xlabel('time-s')
hold on
plot((0:PRISampleNum-1)/SampleRate,imag(IFData(1:PRISampleNum)))

title('IF waveform (TX)')
legend('Real','Imag')

subplot(3,1,2)
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( IFData(1:PRISampleNum),FFTSize ) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('IF 1 Pulse Spectrum(TX)')

subplot(3,1,3)
IFData = reshape(IFData,PRISampleNum,CPIPulseNum);
DataCoherent = sum(IFData,2);
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( DataCoherent, FFTSize) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('IF 32 Pulses Coherent Processing Spectrum(TX)')

%Plot RF signal spectrum
F = (-FFTSize/2:FFTSize/2-1)*DeltaF + RFFreq;
F = F / 1.0e6;  % Convert to MHz

figure('Name','RF waveform and spectrum (Tx)','NumberTitle','off');

subplot(3,1,1);
plot((0:PRISampleNum-1)/SampleRate,real(RFData(1:PRISampleNum)))
xlabel('time-s')
hold on
plot((0:PRISampleNum-1)/SampleRate,imag(RFData(1:PRISampleNum)))
grid on
title('RF waveform(TX)')
legend('Real','Imag')

subplot(3,1,2)
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( RFData(1:PRISampleNum),FFTSize ) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('RF 1 Pulse Spectrum(TX)')

subplot(3,1,3)
DataCoherent = sum(reshape(RFData,PRISampleNum,CPIPulseNum),2);
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( DataCoherent, FFTSize) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('RF 32 Pulses Coherent Processing Spectrum(TX)')
clear BBData IFData x y

%% Echo generator
Target.Range = 3.0e3;
Target.Velocity = 0;
Target.Doppler = 2 * Target.Velocity/c * RFFreq;
Delay.time = 2*Target.Range/c;

if Delay.time > PRI - Pulsewidth
    disp('The range is ambiguous')
end

Delay.IntegerSample = floor(Delay.time* SampleRate);
Delay.FractionalSample = 2 * Target.Range/c * SampleRate - Delay.IntegerSample;
EchoSampleNum = Delay.IntegerSample + size(RFData,1) + 1;
EchoSampleIndex = 0:EchoSampleNum-1;
t = EchoSampleIndex.'/SampleRate;
InterpEchoSampleIndex = EchoSampleIndex - Delay.FractionalSample;
clear EchoSampleIndex
PropagationLoss = c/RFFreq/(4*pi)^1.5/(Target.Range)^2;
Echo = [zeros(Delay.IntegerSample,1); RFData; 0];
if Delay.FractionalSample < 1e-2
    Echo = PropagationLoss*Echo.* exp(1i*2*pi*(Target.Doppler*t - RFFreq * Delay.time));
else
    Echo = interp1(Echo,InterpEchoSampleIndex,'spline');
    Echo = PropagationLoss*Echo.* exp(1i*2*pi*(Target.Doppler*t - RFFreq * Delay.time));
    
end
clear RFData InterpEchoSampleIndex t

%% Open SystemVue workspace and select the analysis to be run
% Assumes workspace is in the same directory as the script.
workspace = SystemVue.openWorkspace('RF_Radar.wsv');

analysis = workspace.analysis(NameOfRxAnalysis);

analysis.param('SampleRate').value = SampleRate; % The sample rate of the simulation
analysis.param('PRI').value = PRI; % The interval of pulse repeation
analysis.param('Pulsewidth').value = Pulsewidth; % The width if pulse
analysis.param('Bandwidth').value = Bandwidth; % The bandwidth of LFM waveform
analysis.param('CPIPulseNum').value = CPIPulseNum; % The pulse number of coherent processing interval
analysis.param('FilterBandwidth').value = FilterBandwidth; % The filter pass bandwidth
analysis.param('LNAGain').value = LNAGain; % The gain of LNA
analysis.param('LNANF').value = LNANF; % The gain of LNA
analysis.param('BBFreq').value = BBFreq; % The frequency of base band signal
analysis.param('IFFreq').value = IFFreq; % The frequency of IF 
analysis.param('IFOSPN').value = IFOSPN; % The phase niose of IF oscillator
analysis.param('IFMixerNF').value = IFMixerNF; % The noise factor of IF mixer
analysis.param('IFAmplifierGain').value = IFAmplifierGain; % The gain of IF amplifier(dB)
analysis.param('RFFreq').value = RFFreq; % The frequency of RF
analysis.param('RFOSPN').value = RFOSPN; % The phase niose of RF oscillator
analysis.param('RFMixerNF').value = RFMixerNF; % The noise factor of RF mixer
analysis.param('RFAmplifierGain').value = RFAmplifierGain; % The gain of RF amplifier(dB)
analysis.param('RunFromMATLAB').value = 1;  % Set this to 1 to configure the design to be run from MATLAB

analysis.start();

analysis.link('LFMSource').setData(Echo(1:BlockSize));

RFData = analysis.link('Data').port('RFData').getData();
IFData = analysis.link('Data').port('IFData').getData();
BBData = analysis.link('Data').port('BBData').getData();

DataCube = analysis.link('DataCube').port('DataCube').getData();
analysis.stop();

%% Plot the Rx Baseband, IF and RF signal waveform and spectrum

%Plot Baseband signal spectrum

FFTSize = PRISampleNum;
DeltaF = SampleRate/FFTSize;
F = (-FFTSize/2:FFTSize/2-1)*DeltaF + BBFreq;
F = F / 1.0e6;  % Convert to MHz

figure('Name','Baseband waveform and spectrum (Rx)','NumberTitle','off');
subplot(3,1,1);
plot((0:PRISampleNum-1)/SampleRate,real(BBData(1:PRISampleNum)))
xlabel('time-s')
hold on
plot((0:PRISampleNum-1)/SampleRate,imag(BBData(1:PRISampleNum)))
grid on
title('Baseband waveform (RX)')
legend('Real','Imag')

subplot(3,1,2)
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( BBData(1:PRISampleNum),FFTSize ) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('Baseband 1 Pulse Spectrum (RX)')

subplot(3,1,3)
BBData = reshape(BBData,PRISampleNum,CPIPulseNum);
DataCoherent = sum(BBData,2);
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( DataCoherent, FFTSize) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('Baseband 32 Pulses Coherent Processing Spectrum (RX)')

%Plot IF signal spectrum
F = (-FFTSize/2:FFTSize/2-1)*DeltaF + IFFreq;
F = F / 1.0e6;  % Convert to MHz

figure('Name','IF waveform and spectrum (Rx)','NumberTitle','off');

subplot(3,1,1);
plot((0:PRISampleNum-1)/SampleRate,real(IFData(1:PRISampleNum)))
xlabel('time-s')
hold on
plot((0:PRISampleNum-1)/SampleRate,imag(IFData(1:PRISampleNum)))
grid on
title('IF waveform (RX)')
legend('Real','Imag')

subplot(3,1,2)
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( IFData(1:PRISampleNum),FFTSize ) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('IF 1 Pulse Spectrum(RX)')

subplot(3,1,3)
IFData = reshape(IFData,PRISampleNum,CPIPulseNum);
DataCoherent = sum(IFData,2);
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( DataCoherent, FFTSize) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('IF 32 Pulses Coherent Processing Spectrum(RX)')

%Plot RF signal spectrum
F = (-FFTSize/2:FFTSize/2-1)*DeltaF + RFFreq;
F = F / 1.0e6;  % Convert to MHz

figure('Name','RF waveform and spectrum (Rx)','NumberTitle','off');

subplot(3,1,1);
plot((0:PRISampleNum-1)/SampleRate,real(IFData(1:PRISampleNum)))
xlabel('time-s')
hold on
plot((0:PRISampleNum-1)/SampleRate,imag(IFData(1:PRISampleNum)))
grid on
title('RF waveform(RX)')
legend('Real','Imag')

subplot(3,1,2)
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( RFData(1:PRISampleNum),FFTSize ) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('RF 1 Pulse Spectrum(RX)')

subplot(3,1,3)
DataCoherent = sum(reshape(RFData,PRISampleNum,CPIPulseNum),2);
OutVoltSpectrum_dBV = 20*log10( abs( fftshift( fft( DataCoherent, FFTSize) / FFTSize ) ) );
plot(F,OutVoltSpectrum_dBV)
grid on
xlabel('Frequency-MHz')
title('RF 32 Pulses Coherent Processing Spectrum(RX)')
clear BBData IFData RFData DataCoherent 

%% Pulse compression and pulse doppler
if strcmp(NameOfRxAnalysis, 'RxChannelAnalysis') || strcmp(NameOfRxAnalysis, 'RxChannelRFLinkAnalysis')
    DataCube = reshape(DataCube, PRISampleNum, CPIPulseNum);
    FFTSize = 2.^(floor(log2(PRISampleNum+PulseSampleNum-1))+1);
    LFMRefFFT = conj(fft(LFMWaveform,FFTSize)).';

    for pulseIndex = 1:CPIPulseNum
        pulsePCTemp = fft(DataCube(:,pulseIndex),FFTSize).*LFMRefFFT; 
        pulsePCTemp = ifft(pulsePCTemp,FFTSize);
        DataCube(:,pulseIndex) = pulsePCTemp(1:PRISampleNum);
    end

    for rangBin = 1:PRISampleNum
        DataCube(rangBin,:) = fft(DataCube(rangBin,:),CPIPulseNum);    
    end

else
    DataCube = reshape(DataCube, PRISampleNum, CPIPulseNum);
    
end

RangeBin = (0:PRISampleNum-1)/SampleRate*c/2/1e3;
VelocityBin = [-CPIPulseNum/2:-1 0:CPIPulseNum/2-1]/CPIPulseNum / PRI * c/RFFreq /2;
[Range,Velocity] = meshgrid(VelocityBin,RangeBin);
DataCube = abs(DataCube);
MaxValue = max(max(DataCube));
DataCube = DataCube/MaxValue;
DataCube = [DataCube(:,CPIPulseNum/2+1:end) DataCube(:,1:CPIPulseNum/2)];

figure('Name','Range-Velocity Map','NumberTitle','off');
% DataCube = 20*log10(DataCube);
% DataCube(DataCube<-60) = -60;
mesh(Range,Velocity,DataCube)
% axis([-80 80 0 15 -60 0]);
ylabel('Range-km')
xlabel('Velocity-m/s')
shading interp
title('Range Velocity Map')

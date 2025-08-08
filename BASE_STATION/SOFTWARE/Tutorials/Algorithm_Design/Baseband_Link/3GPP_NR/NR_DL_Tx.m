
close all
clear global
clear
clc
global sim_params;

sim_params.workspace = [pwd '\NR_DL_Tx.wsv'];    % ASSUMING workspace is in the same directory as scripts

%%
sim_params.SVEAnalysis = 1;             % SystemVueEngine Analysis Index to be simulated  
                                        % 1 for SVE NR Downlink Tx Analysis 
                                                ...Generation of NR_DL_Tx signal which is available in MATLAB
                                                ...Saving data and the related parameters to a mat file for SVEAnalysis2 use
                                        % 2 for SVE NR Downlink Rx Analysis
                                                ...Loading NR_DL_Tx signal and the related parameters generated in SVEAnalysis1
                                                ...Passing the data to SVE for SPETRUM,CCDF,ACLR and EVM analysis 
                                        % 3 for SVE NR Downlink TxRx Analysis
                                                ...Generation of NR_DL_Tx signal of one subframe
                                                ...Signal processing to the generated NR_DL_Tx in MATLAB such as adding AWGN in this script
                                                ...Passing the data back to SVE for SPETRUM,CCDF,ACLR and EVM analysis
%%
%===================================================================================
%                 Parameters Setting
%===================================================================================

%% ------    Baseband source signal related parameters (ONLY VALID for SVEAnalysis 1 and 3. For SVEAnalysis 2 simulation, these parameters together with NR Tx source data to be measured will be automatically loaded from NR_DL_Tx_GoldenData.mat) -----%
sim_params.SimNumSubframes = 30;        % Number of subframes to be simulated (Should be multiples of 10 and no less than 30 to complete EVM measurements based on NR radio frames)
sim_params.SNR = 30;                    % Used for MATLAB DSP in SVEAnalysis{3}
sim_params.FCarrier = 2e9;              % Carrier frequency (Hz)
sim_params.SignalPowerdBm = 0;          % Expected baseband signal power (dBm)
sim_params.Bandwidth = 1;               % Bandwidth (0:5MHz; 1:10MHz; 2:15MHz; 3:20MHz; 4:25MHz; 5:30MHz; 6:40MHz; 7:50MHz; 8:60MHz; 9:70MHz; 10:80MHz; 11:90MHz; 12:100MHz; 13:200MHz; 14:400MHz)
sim_params.OversamplingOption = 2;      % OversamplingRate option (0:Ratio1; 1:Ratio2; 2:Ratio4; 3:Ratio8)
sim_params.Numerology = 0;              % Downlink Numerology (0:15kHz; 1:30kHz; 2:60kHz; 3:120kHz; 4:240kHz)
sim_params.UseTestModel = 1;            % Use Test Models defined in 4.9.2 of TS 38.141-1 or Not (0: NO; 1: YES).
if (sim_params.UseTestModel == 1)       % Specify TestModel when UseTestModel is YES
    sim_params.TestModel = 0;           % Test Model ((0:NR-FR1-TM1.1; 1:NR-FR1-TM1.2; 2:NR-FR1-TM2; 3:NR-FR1-TM2a; 4:NR-FR1-TM3.1; 5:NR-FR1-TM3.1a; 6:NR-FR1-TM3.2; 7:NR-FR1-TM3.3; 8:NR-FR2-TM1.1; 9:NR-FR2-TM2; 10:NR-FR2-TM3.1)
    sim_params.DuplexType = 1;          % Duplex type setup for Test Model (0:TDD; 1:FDD)
else                                    % Specify user-defined parameters when UseTestModel is NO
    sim_params.SSB_Enable = 1;              % Enable(1) or Disable(0) SS/PBCH block
    sim_params.SSB_RBOffset = 0;            % Starting index of resource blocks allocated to SSB in the whole bandwidth based on 15kHz(FR1) or 60kHz(FR2)
    sim_params.SSB_Lmax = 0;                % Number of SS/PBCH block candidates for a half frame with SS/PBCH blocks (0:L=4; 1:L=8; 2:L=64)
    sim_params.PDSCH_Enable = 1;            % Enable(1) or Disable(0) PDSCH
    sim_params.PDSCH_RBOffset = 0;          % Starting index of resource blocks allocated to PDSCH
    sim_params.PDSCH_NumRBs = 52;           % Number of resource blocks allocated for PDSCH
    sim_params.Modulation = 2;              % Modulation order for PDSCH (1:QPSK; 2:16QAM; 3:64QAM; 4:256QAM)
end

%% ------    Baseband Tx filter parameters (ONLY VALID for SVEAnalysis 1 and 3. For SVEAnalysis 2 simulation, these parameters together with NR Tx source data to be measured will be automatically loaded from NR_DL_Tx_GoldenData.mat) -----%
sim_params.EnableTxFilter = 1;          % Enable(1) or Disable(0) the Tx spectrum shaping filter (an Ideal Lowpass FIR filter)
sim_params.FIR_Taps = 51;               % Number of taps of the ideal lowpass filter valid only if TxFilter is enabled. Range: [1,1000]

%% ------    Baseband Rx filter parameters (VALID for SVEAnalysis 1, 2 and 3) -----%
sim_params.EnableRxFilter = 0;          % Enable(1) or Disable(0) the Rx filter in EVM measurement model

%% ------    EVM measurement related parameters (VALID for SVEAnalysis 1, 2 and 3) -----%
sim_params.ReportEVMIndB = 1;           % EVM results shown in dB(1) or Not(0)
sim_params.SaveConstellation = 1;       % Save(1) the demodulated constellation for display or Not(0)
sim_params.ShowMoreEVMResults = 1;      % Show(1) more EVM measurement results in command window or Not(0)

%% ------    Signal distortion parameters for Tx modulator (ONLY VALID for SVEAnalysis 1 and 3. For SVEAnalysis 2 simulation, these parameters together with NR Tx source data to be measured will be automatically loaded from NR_DL_Tx_GoldenData.mat) -----% 
sim_params.MirrorSignal = 0;            % Mirror signal about carrier (0:NO; 1:YES)
sim_params.GainImbalance = 0.0;         % Gain imbalance in dB
sim_params.PhaseImbalance = 0.0;        % Phase imbalance in degree
sim_params.I_OriginOffset = 0.0;        % I signal original offset
sim_params.Q_OriginOffset = 0.0;        % Q signal original offset
sim_params.IQ_Rotation = 0.0;           % IQ rotation in degree

%% ------    RF Link parameters (RF Link works ONLY for FR1) -----% 
sim_params.EnableTxRFLink = 0;          % Enable(1) or Disable(0) the Tx RF link for the source signal      valid for SVEAnalysis 1 and 3
sim_params.EnableRxRFLink = 0;          % Enable(1) or Disable(0) the Rx RF link for the received signal    valid for SVEAnalysis 2 and 3

% Below RF Link parameters are the default setting in RF models
% Modified in MATLAB will not take effect as automatic update of RF model behaviour is not currently supported in SVE
sim_params.TxRF_AmpGain = 20;           % Tx RF Link amplifier gain in dB                                   valid for SVEAnalysis 1 and 3
sim_params.TxRF_AmpNF = 3;              % Tx RF Link amplifier noise figure in dB                           valid for SVEAnalysis 1 and 3
sim_params.RxRF_LNAGain = 20;           % Rx RF Link LNA gain in dB                                         valid for SVEAnalysis 2 and 3
sim_params.RxRF_LNANF = 3;              % Rx RF Link LNA noise figure in dB                                 valid for SVEAnalysis 2 and 3
sim_params.RxRF_IFCarrier = 400e6;      % Rx RF Link intermediate carrier frequency in Hz                   valid for SVEAnalysis 2 and 3
sim_params.RxRF_IFOSFOPN = [1e3,-70,10e3,-90,100e3,-100,1000e3,-105];            % Rx_RF Link IF oscillator frequency offset (Hz) and phase noise (dB) list  valid for SVEAnalysis 2 and 3

%%
%===================================================================================
%                 SystemVueEngine Setting
%===================================================================================
SVE = NR_DL_Tx_Functions();
[workspace,analysis,link] = SVE.setting();
analysis.start;

%%
%===================================================================================
%                 SystemVueEngine NR Signal Generation and Measurement
%===================================================================================
tic

for i = 1 : sim_params.SimNumSubframes


    %--------------SystemVueEngine of NR tx signal generation only-----------------%
    if (sim_params.SVEAnalysis == 1)
        y = link.getData;
        sim_params.SVE_TxDataSaved = [sim_params.SVE_TxDataSaved y];
    %-------------------------------------------------------------%
        

    %------SystemVueEngine of NR rx signal EVM analysis only-----%
    elseif (sim_params.SVEAnalysis == 2)
        y = sim_params.SVE_RxDataLoaded(:,i);
        link.setData(y);    % setting data y to systemvueengine for EVM analysis
    %-------------------------------------------------------------%

    
    %------SystemVueEngine of both NR tx signal generation and rx signal EVM analysis-----%
    elseif (sim_params.SVEAnalysis == 3)
        x = link.getData;   % getting NR source data from systemvueengine

        %----------MATLAB DSP to x Here ....
        noise = sim_params.sigma*(randn(length(x),1)+1j*randn(length(x),1));
        y = x + noise;
        %-----------------------------------

        link.setData(y);    % setting data y back to systemvueengine for EVM analysis
    %-------------------------------------------------------------%
    end
    
    disp(['     Subframe #' num2str(i) ' Processed']);
end
toc

%%
%===================================================================================
%                 Results Reporting
%===================================================================================
pause(1);                   % saving SVE some time for results processing into dataset
analysis.stop;
dataset = SVE.reporting(analysis);
workspace.close;

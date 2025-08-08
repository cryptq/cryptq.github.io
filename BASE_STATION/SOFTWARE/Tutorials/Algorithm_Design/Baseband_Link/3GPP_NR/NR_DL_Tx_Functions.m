

%%
%===================================================================================
%                 SystemVueEngine functions defined
%===================================================================================
function SVE = NR_DL_Tx_Functions()

    SVE.setting = @SVE_setting;
    SVE.reporting = @SVE_reporting;

end


%%
%===================================================================================
%                 SVE_Setting function
%===================================================================================
function [workspace,analysis,link] = SVE_setting()

    global sim_params;

    %----------Selecting Different SVE analysis according to SVEAnalysis----------%
    if (sim_params.SVEAnalysis==1)
        analysis_name = 'NR_DL_Tx_Analysis';
        sim_params.SVE_TxDataSaved = [];
    elseif (sim_params.SVEAnalysis==2)
        analysis_name = 'NR_DL_Rx_Analysis';
        if (exist('NR_DL_Tx_GoldenData.mat')) %#ok<*EXIST>
            EnableRxFilter = sim_params.EnableRxFilter;
            ReportEVMIndB = sim_params.ReportEVMIndB;
            SaveConstellation = sim_params.SaveConstellation;
            ShowMoreEVMResults = sim_params.ShowMoreEVMResults;
            EnableRxRFLink = sim_params.EnableRxRFLink;
            RxRF_LNAGain = sim_params.RxRF_LNAGain;
            RxRF_LNANF = sim_params.RxRF_LNANF;
            RxRF_IFCarrier = sim_params.RxRF_IFCarrier;
            RxRF_IFOSFOPN = sim_params.RxRF_IFOSFOPN;
            sim_params = load('NR_DL_Tx_GoldenData');   % Load NR DL signal and sim_params used to generate the signal
            sim_params.SVE_RxDataLoaded = sim_params.SVE_TxDataSaved;
            sim_params = rmfield(sim_params,'SVE_TxDataSaved');
            sim_params.SVEAnalysis = 2;
            sim_params.EnableRxFilter = EnableRxFilter;
            sim_params.ReportEVMIndB = ReportEVMIndB;
            sim_params.SaveConstellation = SaveConstellation;
            sim_params.ShowMoreEVMResults = ShowMoreEVMResults;
            sim_params.EnableRxRFLink = EnableRxRFLink;
            sim_params.RxRF_LNAGain = RxRF_LNAGain;
            sim_params.RxRF_LNANF = RxRF_LNANF;
            sim_params.RxRF_IFCarrier = RxRF_IFCarrier;
            sim_params.RxRF_IFOSFOPN = RxRF_IFOSFOPN;
        else
            error('The input source file NR_DL_Tx_GoldenData.mat for SVEAnalysis(2) does not exist. Please run SVEAnalysis(1) first to get it');
        end
    elseif (sim_params.SVEAnalysis==3)
        analysis_name = 'NR_DL_TxRx_Analysis';
    else
        error('SVEAnalysis can only be 1, 2 or 3');
    end    
    disp(sim_params)
    
    %----------Parameter setting to SVE analysis----------%
    workspace = SystemVue.openWorkspace(sim_params.workspace);
    analysis = workspace.analysis(analysis_name);
    analysis.param('FCarrier').value = sim_params.FCarrier;
    analysis.param('SignalPower').value = 10.^((sim_params.SignalPowerdBm-30)/10);  % SignalPower is defined as Watt in SVE interface
    analysis.param('Bandwidth').value = sim_params.Bandwidth;
    analysis.param('OversamplingOption').value = sim_params.OversamplingOption;
    analysis.param('Numerology').value = sim_params.Numerology;
    analysis.param('UseTestModel').value = sim_params.UseTestModel;
    if (sim_params.UseTestModel == 1)
        analysis.param('TestModel').value = sim_params.TestModel;
        analysis.param('DuplexType').value = sim_params.DuplexType;
    else
        analysis.param('SSB_Enable').value = sim_params.SSB_Enable;
        analysis.param('SSB_RBOffset').value = sim_params.SSB_RBOffset;
        analysis.param('SSB_Lmax').value = sim_params.SSB_Lmax;
        analysis.param('PDSCH_Enable').value = sim_params.PDSCH_Enable;
        analysis.param('PDSCH_RBOffset').value = sim_params.PDSCH_RBOffset;
        analysis.param('PDSCH_NumRBs').value = sim_params.PDSCH_NumRBs;
        analysis.param('Modulation').value = sim_params.Modulation;
    end
    analysis.param('EnableTxFilter').value = sim_params.EnableTxFilter;
    analysis.param('FIR_Taps').value = sim_params.FIR_Taps;
    analysis.param('SimNumSubframes').value = sim_params.SimNumSubframes;
    analysis.param('EnableRxFilter').value = sim_params.EnableRxFilter;
    analysis.param('ReportEVMIndB').value = sim_params.ReportEVMIndB;
    analysis.param('SaveConstellation').value = sim_params.SaveConstellation;
    analysis.param('RunFromMATLAB').value = 1;      % DO NOT Change this one while it keeps SVE running through MATLAB
    
    if (sim_params.SVEAnalysis==1)
        analysis.param('MirrorSignal').value = sim_params.MirrorSignal;
        analysis.param('GainImbalance').value = sim_params.GainImbalance;
        analysis.param('PhaseImbalance').value = sim_params.PhaseImbalance;
        analysis.param('I_OriginOffset').value = sim_params.I_OriginOffset;
        analysis.param('Q_OriginOffset').value = sim_params.Q_OriginOffset;
        analysis.param('IQ_Rotation').value = sim_params.IQ_Rotation;
        analysis.param('EnableTxRFLink').value = sim_params.EnableTxRFLink;
        analysis.param('TxRF_AmpGain').value = sim_params.TxRF_AmpGain;
        analysis.param('TxRF_AmpNF').value = sim_params.TxRF_AmpNF;
    elseif (sim_params.SVEAnalysis==2)
        analysis.param('EnableRxRFLink').value = sim_params.EnableRxRFLink;
        analysis.param('RxRF_LNAGain').value = sim_params.RxRF_LNAGain;
        analysis.param('RxRF_LNANF').value = sim_params.RxRF_LNANF;
        analysis.param('RxRF_IFCarrier').value = sim_params.RxRF_IFCarrier;
        analysis.param('RxRF_IFOSFOPN').value = sim_params.RxRF_IFOSFOPN;
    else
        analysis.param('MirrorSignal').value = sim_params.MirrorSignal;
        analysis.param('GainImbalance').value = sim_params.GainImbalance;
        analysis.param('PhaseImbalance').value = sim_params.PhaseImbalance;
        analysis.param('I_OriginOffset').value = sim_params.I_OriginOffset;
        analysis.param('Q_OriginOffset').value = sim_params.Q_OriginOffset;
        analysis.param('IQ_Rotation').value = sim_params.IQ_Rotation;
        analysis.param('EnableTxRFLink').value = sim_params.EnableTxRFLink;
        analysis.param('TxRF_AmpGain').value = sim_params.TxRF_AmpGain;
        analysis.param('TxRF_AmpNF').value = sim_params.TxRF_AmpNF;
        analysis.param('EnableRxRFLink').value = sim_params.EnableRxRFLink;
        analysis.param('RxRF_LNAGain').value = sim_params.RxRF_LNAGain;
        analysis.param('RxRF_LNANF').value = sim_params.RxRF_LNANF;
        analysis.param('RxRF_IFCarrier').value = sim_params.RxRF_IFCarrier;
        analysis.param('RxRF_IFOSFOPN').value = sim_params.RxRF_IFOSFOPN;
    end
    
    link = analysis.link('Link');
    analysis.start;
    
    if (sim_params.SVEAnalysis==3)
        MatlabWgnGen();
    end
end

%%
%===================================================================================
%                 SVE_Reporting function
%===================================================================================

function dataset = SVE_reporting(analysis)

    global sim_params;
    
    dataset = analysis.dataset;
    NumBWPs = dataset.variables.NumBWPs.value;
    color = {'b*', 'g*', 'c*', 'm*', 'y*', 'k*'};

    if (sim_params.UseTestModel == 1)
        SSB_Enable = 0;
        PDSCH_Enable = 1;
        PDCCH_Enable = 1;
        Model = 'dataset.variables.TestModelEVM__EVM_';
    else
        SSB_Enable = sim_params.SSB_Enable;
        PDSCH_Enable = sim_params.PDSCH_Enable;
        PDCCH_Enable = 0;
        Model = 'dataset.variables.EVM_';
    end
    
    if (sim_params.ReportEVMIndB==1)
        EVMUnit = ' dB';
    else
        EVMUnit = ' %';
    end
    
    checkSyncCorr = eval([Model 'SyncCorr.value(end)']);

    if (sim_params.SVEAnalysis==1)
        
        figure('Name','Tx Measurement Waveform');
        subplot(2,1,1);plot(dataset.variables.Spectrum_Src_Freq.value,10*log10(abs(complex(dataset.variables.Spectrum_Src.value.real,dataset.variables.Spectrum_Src.value.imag)).^2/2/50*1000));grid on;title('Tx Spectrum');xlabel('Hz');ylabel('dBm');
        subplot(2,1,2);plot(dataset.variables.CCDF_Src_CCDF_SignalRange_dB.value,dataset.variables.CCDF_Src_CCDF.value);grid on;title('Tx CCDF');xlabel('dB');ylabel('%');
        
        figure('Name','Tx Measurement Report');
        dim = [.05 .05 .9 .9];
        str = ['Error Summary' 10];
        str = [str '     ---------------------------------------------------------' 10];
        str = [str '     | EVM =                     ' num2str(eval([Model 'EVM.value(end)']),'%.4g') EVMUnit 10];
        str = [str '     | Freq.Err =                ' num2str(eval([Model 'FreqErr.value(end)']),'%.4g') ' Hz' 10];
        str = [str '     | SymClk Err =            ' num2str(eval([Model 'SymClkErr.value(end)'])*1e6,'%.4g') ' ppm' 10];
        str = [str '     | IQ Offset =               ' num2str(eval([Model 'IQOffset.value(end)']),'%.4g') ' dB' 10];
        str = [str '     ---------------------------------------------------------' 10];
        if (SSB_Enable==1)
            str = [str '     | PSS.EVM =              ' num2str(eval([Model 'PSSEVM.value(end)']),'%.4g') EVMUnit 10];
            str = [str '     | SSS.EVM =              ' num2str(eval([Model 'SSSEVM.value(end)']),'%.4g') EVMUnit 10];
            str = [str '     | PBCH.EVM =            ' num2str(eval([Model 'PBCHEVM.value(end)']),'%.4g') EVMUnit 10];
        end
        if (PDSCH_Enable==1)
            for cnt = 0:NumBWPs-1
                BWPid = ['BWP' num2str(cnt)];
                str = [str '     | PDSCH' BWPid '.EVM =         ' num2str(eval([Model BWPid 'PDSCHEVM.value(end)']),'%.4g') EVMUnit 10];
            end
        end        
        if (PDCCH_Enable==1)
            str = [str '     | PDCCHBWP0.EVM =         ' num2str(eval([Model 'BWP0PDCCHEVM.value(end)']),'%.4g') EVMUnit 10];
        end        
        str = [str '     ---------------------------------------------------------' 10 10];

        str = [str 'ACLR Summary' 10];
        str = [str '     ---------------------------------------------------------' 10];
        str = [str '     | ACLR_{TxL1} = ' num2str(dataset.variables.ACLR_Src_Lower1.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{TxL2} = ' num2str(dataset.variables.ACLR_Src_Lower2.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{TxU1} = ' num2str(dataset.variables.ACLR_Src_Upper1.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{TxU2} = ' num2str(dataset.variables.ACLR_Src_Upper2.value(end),'%.4g') ' dB' 10];
        str = [str '     ---------------------------------------------------------' 10 10];
        t = annotation('textbox',dim,'String',str);        t.FontSize = 9;

        if (sim_params.SaveConstellation==1 && checkSyncCorr~=0)
            figure('Name','Tx Measurement Constellation');legd = cell(3,1); idx = 0;
			if (PDSCH_Enable==1) %#ok<*ALIGN>
                for cnt = 0:NumBWPs-1
                    BWPid = ['BWP' num2str(cnt)];
                    plot(complex(eval([Model BWPid 'PDSCHConst.value.real']),eval([Model BWPid 'PDSCHConst.value.imag'])),color{cnt+1});hold on;idx=idx+1;legd{idx} = ['PDSCH' BWPid];
                end
            end
			if (PDCCH_Enable==1)
				plot(complex(eval([Model 'BWP0PDCCHConst.value.real']),eval([Model 'BWP0PDCCHConst.value.imag'])),'r+');hold on;idx=idx+1;legd{idx} = 'PDCCH';
            end
			if (SSB_Enable==1)
				plot(complex(eval([Model 'PBCHConst.value.real']),eval([Model 'PBCHConst.value.imag'])),'ro');hold on;idx=idx+1;legd{idx} = 'PBCH';
            end
            grid on;legend(legd{1:idx});axis([-1.2,1.2,-1.2,1.2]);
        end

    elseif (sim_params.SVEAnalysis==2)    
        
        figure('Name','Rx Measurement Waveform');
        subplot(2,1,1);plot(dataset.variables.Spectrum_Rec_Freq.value,10*log10(abs(complex(dataset.variables.Spectrum_Rec.value.real,dataset.variables.Spectrum_Rec.value.imag)).^2/2/50*1000));grid on;title('Rx Spectrum');xlabel('Hz');ylabel('dBm');
        subplot(2,1,2);plot(dataset.variables.CCDF_Rec_CCDF_SignalRange_dB.value,dataset.variables.CCDF_Rec_CCDF.value);grid on;title('Rx CCDF');xlabel('dB');ylabel('%');
        
        figure('Name','Rx Measurement Report');
        dim = [.05 .05 .9 .9];
        str = ['Error Summary' 10];
        str = [str '     ---------------------------------------------------------' 10];
        str = [str '     | EVM =                     ' num2str(eval([Model 'EVM.value(end)']),'%.4g') EVMUnit 10];
        str = [str '     | Freq.Err =                ' num2str(eval([Model 'FreqErr.value(end)']),'%.4g') ' Hz' 10];
        str = [str '     | SymClk Err =            ' num2str(eval([Model 'SymClkErr.value(end)'])*1e6,'%.4g') ' ppm' 10];
        str = [str '     | IQ Offset =               ' num2str(eval([Model 'IQOffset.value(end)']),'%.4g') ' dB' 10];
        str = [str '     ---------------------------------------------------------' 10];
        if (SSB_Enable==1)
            str = [str '     | PSS.EVM =              ' num2str(eval([Model 'PSSEVM.value(end)']),'%.4g') EVMUnit 10];
            str = [str '     | SSS.EVM =              ' num2str(eval([Model 'SSSEVM.value(end)']),'%.4g') EVMUnit 10];
            str = [str '     | PBCH.EVM =            ' num2str(eval([Model 'PBCHEVM.value(end)']),'%.4g') EVMUnit 10];
        end
        if (PDSCH_Enable==1)
            for cnt = 0:NumBWPs-1
                BWPid = ['BWP' num2str(cnt)];
                str = [str '     | PDSCH' BWPid '.EVM =         ' num2str(eval([Model BWPid 'PDSCHEVM.value(end)']),'%.4g') EVMUnit 10];
            end
        end        
        if (PDCCH_Enable==1)
            str = [str '     | PDCCH.EVM =         ' num2str(eval([Model 'BWP0PDCCHEVM.value(end)']),'%.4g') EVMUnit 10];
        end        
        str = [str '     ---------------------------------------------------------' 10 10];

        str = [str 'ACLR Summary' 10];
        str = [str '     ---------------------------------------------------------' 10];
        str = [str '     | ACLR_{RxL1} = ' num2str(dataset.variables.ACLR_Rec_Lower1.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{RxL2} = ' num2str(dataset.variables.ACLR_Rec_Lower2.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{RxU1} = ' num2str(dataset.variables.ACLR_Rec_Upper1.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{RxU2} = ' num2str(dataset.variables.ACLR_Rec_Upper2.value(end),'%.4g') ' dB' 10];
        str = [str '     ---------------------------------------------------------' 10 10];
        t = annotation('textbox',dim,'String',str);        t.FontSize = 9;

        if (sim_params.SaveConstellation==1 && checkSyncCorr~=0)
            figure('Name','Rx Measurement Constellation');legd = cell(3,1); idx = 0;
			if (PDSCH_Enable==1)
                for cnt = 0:NumBWPs-1
                    BWPid = ['BWP' num2str(cnt)];
                    plot(complex(eval([Model BWPid 'PDSCHConst.value.real']),eval([Model BWPid 'PDSCHConst.value.imag'])),color{cnt+1});hold on;idx=idx+1;legd{idx} = ['PDSCH' BWPid];
                end
            end
			if (PDCCH_Enable==1)
				plot(complex(eval([Model 'BWP0PDCCHConst.value.real']),eval([Model 'BWP0PDCCHConst.value.imag'])),'r+');hold on;idx=idx+1;legd{idx} = 'PDCCH';
            end
			if (SSB_Enable==1)
				plot(complex(eval([Model 'PBCHConst.value.real']),eval([Model 'PBCHConst.value.imag'])),'mo');hold on;idx=idx+1;legd{idx} = 'PBCH';
            end
            grid on;legend(legd{1:idx});axis([-1.2,1.2,-1.2,1.2]);
        end

    else
        
        figure('Name','Tx Measurement Waveform');
        subplot(2,1,1);plot(dataset.variables.Spectrum_Src_Freq.value,10*log10(abs(complex(dataset.variables.Spectrum_Src.value.real,dataset.variables.Spectrum_Src.value.imag)).^2/2/50*1000));grid on;title('Tx Spectrum');xlabel('Hz');ylabel('dBm');
        subplot(2,1,2);plot(dataset.variables.CCDF_Src_CCDF_SignalRange_dB.value,dataset.variables.CCDF_Src_CCDF.value);grid on;title('Tx CCDF');xlabel('dB');ylabel('%');
        
        figure('Name','Rx Measurement Waveform');
        subplot(2,1,1);plot(dataset.variables.Spectrum_Rec_Freq.value,10*log10(abs(complex(dataset.variables.Spectrum_Rec.value.real,dataset.variables.Spectrum_Rec.value.imag)).^2/2/50*1000));grid on;title('Rx Spectrum');xlabel('Hz');ylabel('dBm');
        subplot(2,1,2);plot(dataset.variables.CCDF_Rec_CCDF_SignalRange_dB.value,dataset.variables.CCDF_Rec_CCDF.value);grid on;title('Rx CCDF');xlabel('dB');ylabel('%');
        
        figure('Name','Rx Measurement Report');
        dim = [.05 .05 .9 .9];
        str = ['Error Summary' 10];
        str = [str '     ---------------------------------------------------------' 10];
        str = [str '     | EVM =                     ' num2str(eval([Model 'EVM.value(end)']),'%.4g') EVMUnit 10];
        str = [str '     | Freq.Err =                ' num2str(eval([Model 'FreqErr.value(end)']),'%.4g') ' Hz' 10];
        str = [str '     | SymClk Err =            ' num2str(eval([Model 'SymClkErr.value(end)'])*1e6,'%.4g') ' ppm' 10];
        str = [str '     | IQ Offset =               ' num2str(eval([Model 'IQOffset.value(end)']),'%.4g') ' dB' 10];
        str = [str '     ---------------------------------------------------------' 10];
        if (SSB_Enable==1)
            str = [str '     | PSS.EVM =              ' num2str(eval([Model 'PSSEVM.value(end)']),'%.4g') EVMUnit 10];
            str = [str '     | SSS.EVM =              ' num2str(eval([Model 'SSSEVM.value(end)']),'%.4g') EVMUnit 10];
            str = [str '     | PBCH.EVM =            ' num2str(eval([Model 'PBCHEVM.value(end)']),'%.4g') EVMUnit 10];
        end
        if (PDSCH_Enable==1)
            for cnt = 0:NumBWPs-1
                BWPid = ['BWP' num2str(cnt)];
                str = [str '     | PDSCH' BWPid '.EVM =         ' num2str(eval([Model BWPid 'PDSCHEVM.value(end)']),'%.4g') EVMUnit 10];
            end
        end        
        if (PDCCH_Enable==1)
            str = [str '     | PDCCH.EVM =         ' num2str(eval([Model 'BWP0PDCCHEVM.value(end)']),'%.4g') EVMUnit 10];
        end        
        str = [str '     ---------------------------------------------------------' 10 10];
        
        str = [str 'ACLR Summary' 10];
        str = [str '     ---------------------------------------------------------' 10];
        str = [str '     | ACLR_{TxL1} = ' num2str(dataset.variables.ACLR_Src_Lower1.value(end),'%.4g') ' dB'];
        str = [str '               ACLR_{TxL2} = ' num2str(dataset.variables.ACLR_Src_Lower2.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{TxU1} = ' num2str(dataset.variables.ACLR_Src_Upper1.value(end),'%.4g') ' dB'];
        str = [str '               ACLR_{TxU2} = ' num2str(dataset.variables.ACLR_Src_Upper2.value(end),'%.4g') ' dB' 10 10];
        str = [str '     | ACLR_{RxL1} = ' num2str(dataset.variables.ACLR_Rec_Lower1.value(end),'%.4g') ' dB'];
        str = [str '               ACLR_{RxL2} = ' num2str(dataset.variables.ACLR_Rec_Lower2.value(end),'%.4g') ' dB' 10];
        str = [str '     | ACLR_{RxU1} = ' num2str(dataset.variables.ACLR_Rec_Upper1.value(end),'%.4g') ' dB'];
        str = [str '               ACLR_{RxU2} = ' num2str(dataset.variables.ACLR_Rec_Upper2.value(end),'%.4g') ' dB' 10];
        str = [str '     ---------------------------------------------------------' 10 10];
        t = annotation('textbox',dim,'String',str);        t.FontSize = 9;

        if (sim_params.SaveConstellation==1 && checkSyncCorr~=0)
            figure('Name','Rx Measurement Constellation');legd = cell(3,1); idx = 0;
			if (PDSCH_Enable==1)
                for cnt = 0:NumBWPs-1
                    BWPid = ['BWP' num2str(cnt)];
                    plot(complex(eval([Model BWPid 'PDSCHConst.value.real']),eval([Model BWPid 'PDSCHConst.value.imag'])),color{cnt+1});hold on;idx=idx+1;legd{idx} = ['PDSCH' BWPid];
                end
            end
			if (PDCCH_Enable==1)
				plot(complex(eval([Model 'BWP0PDCCHConst.value.real']),eval([Model 'BWP0PDCCHConst.value.imag'])),'r+');hold on;idx=idx+1;legd{idx} = 'PDCCH';
            end
			if (SSB_Enable==1)
				plot(complex(eval([Model 'PBCHConst.value.real']),eval([Model 'PBCHConst.value.imag'])),'mo');hold on;idx=idx+1;legd{idx} = 'PBCH';
            end
            grid on;legend(legd{1:idx});axis([-1.2,1.2,-1.2,1.2]);
        end

    end
    
    if (sim_params.SVEAnalysis == 1)
        save('NR_DL_Tx_GoldenData','-struct','sim_params');
    end
    
    if (sim_params.ShowMoreEVMResults == 1)
        dataset.variables.LogOutput.value{1} %#ok<*NOPRT>
    end

end

%%
function MatlabWgnGen()

    s = RandStream('mt19937ar','Seed',0);
    RandStream.setGlobalStream(s);

    global sim_params;
    
    %----------Calculating WGN standard deviation according to related NR parameters ONLY VALID for SVEAnalysis3 ----------%
    BandwidthTable =[5e6,10e6,15e6,20e6,25e6,30e6,40e6,50e6,60e6,70e6,80e6,90e6,100e6,200e6,400e6];
    FR1NumRBsTable = [25, 52, 79, 106, 133, 160, 216, 270, 0,   0,   0,   0,   0;
                      11, 24, 38, 51,  65,  78,  106, 133, 162, 189, 217, 245, 273;
                      0,  11, 18, 24,  31,  38,  51,  65,  79,  93,  107, 121, 135];
    FR2NumRBsTable = [66, 132, 264,   0;
			          32,  66, 132, 264;
			          17,  34,  69, 138]; %#ok<*NASGU>
    
    if (sim_params.UseTestModel == 1)
        if (sim_params.TestModel==2 || sim_params.TestModel==3 || sim_params.TestModel==9)
            sim_params.PDSCH_NumRBs = 1; % TestModel 2,3 and 9 where PDSCH RB Number is 1
        else
            if (sim_params.FCarrier >= 410e6 && sim_params.FCarrier <= 7125e6)     % FR1
                sim_params.PDSCH_NumRBs = FR1NumRBsTable(sim_params.Numerology+1,sim_params.Bandwidth+1);  % TestModel PDSCH RB Numbers
            else    % FR2
                sim_params.PDSCH_NumRBs = FR2NumRBsTable(sim_params.Numerology+1,sim_params.Bandwidth+1);  % TestModel PDSCH RB Numbers
            end
        end
    end
    SignalPowerdBm = sim_params.SignalPowerdBm;
    if (sim_params.EnableTxRFLink==1)
        SignalPowerdBm = SignalPowerdBm + 20;% currently default TxRF_AmpGain is 20 (sim_params.TxRF_AmpGain) in SV and can not be modified
    end
    sim_params.SamplingRate = 2.^ceil(log2(BandwidthTable(sim_params.Bandwidth+1)/15e3))*15e3*2^sim_params.OversamplingOption;
    sim_params.sigma = sqrt( 10^((SignalPowerdBm-sim_params.SNR)/10)/10*sim_params.SamplingRate/sim_params.PDSCH_NumRBs/15e3/2^sim_params.Numerology/12/2 );
end

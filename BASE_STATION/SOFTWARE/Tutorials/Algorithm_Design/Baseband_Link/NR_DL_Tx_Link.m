% NR_DL_Tx_Link.wsv was created from the example workspace located in
% Examples\Baseband Verification\5GAdvancedModem\3GPP_NR\NR_DL_Tx.wsv 
% It contains one Baseband_Link configured as a sink, which will run 
% continuously. Analysis.stop() must be called to stop the analysis. Use 
% the DataFlowInfo table, created by the analysis in SystemVue, to determine
% when to stop the analysis. The table indicates 245760 samples are 
% calculated at the connection between parts S2 (SetSampleRate part) and C4
% (CxToRec Part) where our Baseband_Link is located.

workspace = SystemVue.openWorkspace('NR_DL_Tx_Link.wsv');

analysis = workspace.analysis('Design1 Analysis');
sink = analysis.link('M1');

analysis.param('FCarrier').value = 2e9;
analysis.param('Bandwidth').value = '50MHz';
analysis.param('BlockSize').value = 10000;
analysis.param('RunFromMATLAB').value = 1;  % Set this to 1 to configure the design to be run from MATLAB

analysis.start();
txData=[];
disp('Starting...')

% The number of loops * Blocksize will determine the amount of data
% retrieved. 
for i = 1:25
    txData = [txData; sink.getData()];
end

analysis.stop();

plot(abs(txData));

workspace.close()
disp('Finished.')


% This example demonstrates using the SystemVue Package as an analyzer.
% Data is streamed from Matlab to SystemVue, and SystemVue creates a
% dataset file (.adx).
%
% The dataset (.adx file) is created in the same location as the workspace.
% If you do not have write permissions to that location this script will 
% not work. You will need to move the workspace to a writable location and 
% provide the full path of the workspace to the openExampleWorkspace 
% function. To edit this file, remove the read-only property.

% Ensure we can connect to SystemVue
SystemVue.config.getVersion()

% Open a workspace from the example area
myWorkspace = SystemVue.openExampleWorkspace('SimpleAnalyzer.wsv');

% Get the analysis
myAnalysis = myWorkspace.analysis('AdderAnalysis');

myLink = myAnalysis.link('FromMatlab');

% Set the design parameter
myAnalysis.param('BlockSize').value = 1;
myAnalysis.param('Const').value = 2;

myAnalysis.start();

% This should be equal to the Num_Samples parameter from the DataFlow
% Analysis
num_samples=1000;

f = 5000;
ts = 1/1e6;
T=1/f;
t = 0:ts:(5*T);
y = sin(2*pi*f*t);

subplot(3,1,1);
plot(t,y)

for m = 1 : num_samples
    myLink.setData(y(m));
end

% Call waitForCompletion to allow the Dataflow analysis to finish 
% calculating and ensure the dataset has been created. Only call 
% waitForCompletion after the last sample point has been set with setData.
myAnalysis.waitForCompletion();

% Retrieve dataset from .adx file produced by analysis.
S1 = myAnalysis.dataset.variables.S1.value;
S1_Time = myAnalysis.dataset.variables.S1_Time.value;

subplot(3,1,2);
plot(S1_Time ,S1);

S2_Power = myAnalysis.dataset.variables.S2_Power.value;
S2_Power_Freq = myAnalysis.dataset.variables.S2_Power_Freq.value;

subplot(3,1,3);
plot(S2_Power_Freq, 10*log10(S2_Power));

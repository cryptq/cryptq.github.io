% This example demonstrates using the SystemVue Package as an simple signal source.
% Data is streamed from SystemVue to Matlab, then plotted.
%
% Ensure we can connect to SystemVue
SystemVue.config.getVersion()

% Open a workspace from the example area
myWorkspace = SystemVue.openExampleWorkspace('SineGenerator.wsv')

% Get the analysis
myAnalysis = myWorkspace.analysis('SourceAnalysis')

link = myAnalysis.link('ToMATLAB');

num_samples = 1000;

% Must start analysis before calling getData or setData on a link.
myAnalysis.start();

sineSignal = [];

for x=1:num_samples
   y = link.getData();
   sineSignal = [sineSignal y];
end

myAnalysis.stop();

plot(1:num_samples,real(sineSignal));

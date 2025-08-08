% This example demonstrates using the SystemVue Package as a computational function.
% The SystemVue analysis adds a constant, defined by a design parameter,
% to the input and sends the result ot the output.
% MATLAB sends and receives data using the 'calculate' helper method.

% Ensure we can connect to SystemVue
SystemVue.config.getVersion()

% Open a workspace from the example area
myWorkspace = SystemVue.openExampleWorkspace('SimpleAdder.wsv')

% Get the analysis
myAnalysis = myWorkspace.analysis('AdderAnalysis')

% Set the design parameter
myAnalysis.param('Const').value = 5

% Execute two iterations of the analysis:
myAnalysis.calculate(7)
myAnalysis.calculate(9)

myAnalysis.stop();

% Copyright 2011 - 2015 Keysight Technologies, Inc

% This example shows how you can call SystemVue using .NET.
% We use the .NET DLL wrapper from the C# example area to simplify
% interfacing to SystemVue over COM.

% Find the directory path where this file is located
pathToDLL = fileparts( mfilename('fullpath'));

% Load the assembly in this directory (source code in C# example area)
NET.addAssembly([pathToDLL '/SystemVueNET.dll']);

% Open SystemVue and the workspace that we are interested in
if exist( 'systemVue') == false
    % Start a new instance of SystemVue
    systemVue = SystemVueExample.SystemVue();

    % Hide SystemVue
    systemVue.Visible = false;
    
    % Open the example workspace
    systemVue.OpenExampleWorkspace('Comms/BER/QPSK_BER_Coded_Viterbi.wsv');

    % Note - we could also open the workspace using a full path
    % systemVue.OpenWorkspace('C:/Program Files/SystemVue2012.06/Comms/BER/QPSK_BER_Coded_Viterbi.wsv');
end


% Index into results matrix
i = 1;

% Sweep Eb/N0 -2 to 10 and calculate the BER
for j =-2:10,

    % Set EbN0
    EbN0(i) = j;
    systemVue.SetParameter('QPSK_BER_Coded_Viterbi.WorkspaceVariables.VarBlock.[EbN0]', EbN0(i));

    % Run the analysis
    systemVue.RunScript('QPSK_BER_Coded_Viterbi.Analyses.Uncoded_QPSK_BER_Analysis.RunAnalysis');

    % Read BER from dataset
    data = systemVue.GetData('QPSK_BER_Coded_Viterbi.Analyses.Uncoded_QPSK_BER_Data.Eqns.VarBlock.B11_BER');
    BER(i) = data;

    % Display NDensity and BER on the console window
    disp(['Eb/N0 = ' num2str(EbN0(i)), ' BER = ', num2str(BER(i))]);

    % Increment index into results matrix
    i = i+1;

end

%plot the results
semilogy(EbN0,BER)
xlabel('Eb/N0')
ylabel('BER')
title('Uncoded QPSK BER Analysis')

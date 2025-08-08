close all
clc
clear
%% Config rectangle array or othe type array (triangle, circle)
xAxis = 0.5*(0:7);
yAxis = 0.5*(0:7);

[X,Y] = meshgrid(xAxis,yAxis);
figure
plot(X(:),Y(:),'o')
grid on
title('Array configration')
%% Setup SystemVue workspace parameters
SampleRate = 2.0e6;
Fcarrier = 10.0e9;
ArrayType = 0; %
LocationX = X(:);
LocationY = Y(:);
PositionError = 0.1;
PhaseShiftErrorType = 2;
PhaseError = 5;
AmplitudeErrorType = 2;
AmplitudeError = 0.5;

%% Open SystemVue workspace and select the analysis to be run
% Assumes workspace is in the same directory as the script.
workspace = SystemVue.openWorkspace('PhaseArray_Radar.wsv');

analysis = workspace.analysis('Radar_PhaseArrayAnalysis');

analysis.param('SampleRate').value = SampleRate; % The sample rate of the simulation
analysis.param('Fcarrier').value = Fcarrier; % The interval of pulse repeation
analysis.param('ArrayType').value = ArrayType; % The width if pulse
analysis.param('LocationX').value = LocationX; % The bandwidth of LFM waveform
analysis.param('LocationY').value = LocationY; % The pulse number of coherent processing interval
analysis.param('PositionError').value = PositionError; % The filter pass bandwidth
analysis.param('PhaseShiftErrorType').value = PhaseShiftErrorType; % The frequency of base band signal
analysis.param('PhaseError').value = PhaseError; % The frequency of IF 
analysis.param('AmplitudeErrorType').value = AmplitudeErrorType; % The phase niose of IF oscillator
analysis.param('AmplitudeError').value = AmplitudeError; % The noise factor of IF mixer

analysis.param('RunFromMATLAB').value = 1;  % Set this to 1 to configure the design to be run from MATLAB

analysis.start();

PatternData = analysis.link('PatternLink').port('input').getData();

analysis.stop();
%% Plot array pattern

Pattern_Value = abs(PatternData);
Pattern_mat = reshape(Pattern_Value, 181, 361);
Pattern_mat = Pattern_mat';
%Pattern_mat = 20*log10(Pattern_mat');

%% According to the antenna data format of EMpro and HFSS
% The range of theta is [0:pi]
% The range of phi is [0:2*pi]
theta = 0 : 180;
phi = 0 : 360;
[T, P] = meshgrid(theta, phi);

%% For XY-plane, x axis is along the horizontal direction and y axis is along the vertical direction
u = sin(T/180*pi) .* cos(P/180*pi);
v = sin(T/180*pi) .* sin(P/180*pi);
w = cos(T/180*pi);

C = u.*v;

mesh(u,v, Pattern_mat);
shading interp

%% Verify that our u,v,w do what we think they do.
level_db = 40;
%Pattern_mat = 20*log10(Pattern_mat) + level_db;
XX = Pattern_mat.*u;
YY = Pattern_mat.*v;
ZZ = Pattern_mat.*w;


%% The function add_spherical_data uses the phi and theta
fig = figure('Name','3D Ploar Pattern','NumberTitle', 'off');
ps = surf(XX,YY,ZZ,  'EdgeColor','none', 'EdgeAlpha', 0.6);
% set(ps, 'FaceColor',[0.169 0.502 1]);
alpha(0.8);
title('3D Polar Power Pattern')

tick_os=(-level_db:10:level_db);
ticks=abs(tick_os)-level_db;
set(gca,'XTick',tick_os,'XTickLabel',ticks);
set(gca,'YTick',tick_os,'YTickLabel',ticks);
set(gca,'ZTick',tick_os,'ZTickLabel',ticks);
% set(gca, 'Xcolor', 'blue', 'Ycolor','blue', 'Zcolor' , 'blue' );
axis equal; 
axis auto; 
box on;
camlight; 
lightangle(0,45);
lighting gouraud;
camproj ('perspective');
colormap jet
colorbar

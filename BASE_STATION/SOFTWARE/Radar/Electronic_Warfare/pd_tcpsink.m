%% tcp server
clear all;
close all;

%% create tcpip object and listening
t = tcpip('0.0.0.0', 2002, 'NetworkRole', 'server');
t.InputBufferSize = 800*64 * 8*2;
t.ByteOrder = 'littleEndian';
fopen(t);

%% receive the data the plot
while(true)
   [x2, count2] = fread(t, 800*64*2, 'double'); 
   pd = x2(1:2:end) + j*x2(2:2:end);
   pd_mat = reshape(pd, 800, 64);   
   
   mesh(abs(pd_mat));
   grid on;
   
   %drawnow;
   pause(0.01);
end
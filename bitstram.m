%% Bob input: 10 low-load samples

Rb = 1000;                         % Bit rate
Tb = 1/Rb;                         % Sample/bit duration

bits = double([1; 0; 1; 1; 0; 0; 1; 0; 1; 0]);

% Time values: 0, Tb, 2Tb, ..., 9Tb
time = (0:length(bits)-1)' * Tb;

% From Workspace matrix:
% First column = time
% Second column = data
BobBitstream = [time, bits];

% Recommended simulation stop time
Tstop = length(bits) * Tb;

% Check result
disp(BobBitstream);
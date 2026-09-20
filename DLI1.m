% ----------------------------
% PARAMETERS (edit if needed)
fs = 50e9;                 % sample rate (Hz)
dt = 1/fs;                 % sample time (s)
Tsim = 200e-9;             % total simulation time (e.g. 200 ns)
t = 0:dt:(Tsim-dt);        % time vector
pulse_rate = 1e9;          % pulse repetition (Hz) for pulse train example
pulse_width = 0.2e-9;      % pulse width (s)
delay_time = 1e-9;         % DLI delay (s)
phase_offset = 0;          % static phase in delayed arm (rad)
% ----------------------------
% Build a pulse-train complex envelope (0 or pi phase random)
pulse_period = 1/pulse_rate;
% amplitude envelope = narrow Gaussian pulses
A = zeros(size(t));
for k = 0:floor(Tsim/pulse_period)-1
    center = k*pulse_period + pulse_width*2;
    A = A + exp(-((t-center)./(pulse_width/4)).^2);
end
% random 0/pi phases (Bernoulli)
rng(0);                        % reproducible
bitstrem = randi([0 1], 1, length(t)); % same length; we'll only use at pulse centers
% For simplicity make phase per pulse (sample aligned)
phi = zeros(size(t));
for k = 0:floor(Tsim/pulse_period)-1
    idx = find(abs(t - (k*pulse_period + pulse_width*2)) < (pulse_width/2));
    bit = randi([0 1]); % random 0 or 1 for each pulse
    phi(idx) = bit*pi;
end
E = A .* exp(1i*phi);     % complex baseband field
E_ts = timeseries(E.', t.'); % column vector timeseries for From Workspace
% Save parameters to workspace for Simulink blocks if you want:
save('DLI_workspace_vars.mat', 'fs', 'dt', 'Tsim', 'delay_time', 'phase_offset', 'E_ts');
fprintf('Ready: E_ts timeseries (%d samples).\\n', numel(E))
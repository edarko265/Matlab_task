% Define the time vector for continuous signals
t = -5:0.01:5; % Time from -5 to 5 with a step of 0.01

% Unit Impulse
impulse = zeros(size(t)); % Initialize impulse signal
impulse(t == 0) = 1; % Set value at t=0 to 1
figure; % Create a new figure
plot(t, impulse, 'r', 'LineWidth', 2); % Plot impulse signal
title('Unit Impulse Signal'); % Title
xlabel('Time (s)'); % X-axis label
ylabel('Amplitude'); % Y-axis label
grid on; % Enable grid

% Unit Step
step = t >= 0; % Step function is 1 for t >= 0
figure; % Create a new figure
plot(t, step, 'b', 'LineWidth', 2); % Plot step signal
title('Unit Step Signal'); % Title
xlabel('Time (s)'); % X-axis label
ylabel('Amplitude'); % Y-axis label
grid on; % Enable grid

% Unit Ramp
ramp = t .* (t >= 0); % Ramp function is t for t >= 0
figure; % Create a new figure
plot(t, ramp, 'g', 'LineWidth', 2); % Plot ramp signal
title('Unit Ramp Signal'); % Title
xlabel('Time (s)'); % X-axis label
ylabel('Amplitude'); % Y-axis label
grid on; % Enable grid

% Exponential Signal
exponential = exp(t); % Exponential function e^t
figure; % Create a new figure
plot(t, exponential, 'm', 'LineWidth', 2); % Plot exponential signal
title('Exponential Signal'); % Title
xlabel('Time (s)'); % X-axis label
ylabel('Amplitude'); % Y-axis label
grid on; % Enable grid

% Signum Signal
signum = sign(t); % Signum function
figure; % Create a new figure
plot(t, signum, 'c', 'LineWidth', 2); % Plot signum signal
title('Signum Signal'); % Title
xlabel('Time (s)'); % X-axis label
ylabel('Amplitude'); % Y-axis label
grid on; % Enable grid

% Sinc Signal
sinc_signal = sinc(t); % Sinc function (normalized)
figure; % Create a new figure
plot(t, sinc_signal, 'k', 'LineWidth', 2); % Plot sinc signal
title('Sinc Signal'); % Title
xlabel('Time (s)'); % X-axis label
ylabel('Amplitude'); % Y-axis label
grid on; % Enable grid

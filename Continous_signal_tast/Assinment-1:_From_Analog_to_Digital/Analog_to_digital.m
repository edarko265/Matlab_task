%% 1. Generate Analog Signal (conceptual)

t = 0:0.0001:0.01;       % very fine step (continuous-like time)

f = 100;                 % frequency = 100 Hz

x_analog = sin(2*pi*f*t);

 

figure;

plot(t, x_analog, 'LineWidth', 1.5);

title('Analog Signal (Sine Wave)');

xlabel('Time (s)'); ylabel('Amplitude');

%% 2. Sampling

Fs = 1000;               % Sampling frequency = 1 kHz

Ts = 1/Fs;               % Sampling period

n = 0:Ts:0.01;           % Discrete sample points

x_sampled = sin(2*pi*f*n);

 

figure;

stem(n, x_sampled, 'filled');

title('Sampled Signal');

xlabel('Time (s)'); ylabel('Amplitude');

%% 3. Quantization

bits = 4;                           % Number of bits

levels = 2^bits;                    % Quantization levels

x_min = min(x_sampled);

x_max = max(x_sampled);

q_step = (x_max - x_min)/levels;    % Step size

 

x_index = round((x_sampled - x_min)/q_step); % Map samples to indices

x_quantized = x_index*q_step + x_min;        % Map back to amplitude

 

figure;

stem(n, x_quantized, 'filled');

title(['Quantized Signal (' num2str(bits) '-bit)']);

xlabel('Time (s)'); ylabel('Amplitude');

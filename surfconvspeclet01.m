clc;
close all;
clear;
% --- Parameters ---
R = 10e-6;          % Bubble radius in meters [cite: 206]
U = 0.3e-3;         % Terminal velocity in m/s [cite: 207]
Ds = 1e-9;          % Surface diffusion coefficient in m^2/s [cite: 208]
Gamma_avg = 2e-6;   % Average surfactant concentration in mol/m^2 [cite: 209]

% Calculate Peclet number
Pes = (U * R) / Ds; % [cite: 222]
fprintf('Calculated Peclet Number (Pe_s): %.2f\n', Pes);

% --- Varying Peclet Number (Pe_s) ---
% Set a for a partially mobile interface, for example a = 1.2
a_value = 1.2; % [cite: 221]
k_values = [0.5, 1, 3, 5]; % Example k values for different Pe_s
theta_deg = 0:1:180;
theta_rad = deg2rad(theta_deg);

figure;
hold on;
title('Surfactant Concentration vs. Angle (Varying k)');
xlabel('Polar Angle \theta (degrees)');
ylabel('Relative Surfactant Concentration \Gamma/\Gamma_{avg}');
grid on;

for k = k_values
    Gamma_rel = calculate_gamma(theta_rad, 1, k);
    plot(theta_deg, Gamma_rel, 'LineWidth', 2, 'DisplayName', ['k = ' num2str(k)]);
end
legend show;
hold off;

% --- Varying Interfacial Mobility (a) ---
% Fix Pe_s, for example Pe_s = 3
Pes_fixed = 3; % [cite: 222]
a_values = [1.5, 1.2, 0.5, 0]; % a=1.5(clean), a=1.2(mobile), a=0.5(less mobile), a=0(rigid) [cite: 150, 151, 154]
k_fixed_values = a_values .* Pes_fixed;
theta_deg = 0:1:180;
theta_rad = deg2rad(theta_deg);

figure;
hold on;
title('Surfactant Concentration vs. Angle (Varying Mobility "a")');
xlabel('Polar Angle \theta (degrees)');
ylabel('Relative Surfactant Concentration \Gamma/\Gamma_{avg}');
grid on;

for k = k_fixed_values
    Gamma_rel = calculate_gamma(theta_rad, 1, k);
    plot(theta_deg, Gamma_rel, 'LineWidth', 2, 'DisplayName', ['a = ' num2str(k/Pes_fixed)]);
end
legend show;
hold off;

% --- Local Function Definition ---
function Gamma_theta = calculate_gamma(theta, Gamma_avg, k)
    Gamma_theta = Gamma_avg .* (k ./ sinh(k)) .* exp(-k .* cos(theta));
end

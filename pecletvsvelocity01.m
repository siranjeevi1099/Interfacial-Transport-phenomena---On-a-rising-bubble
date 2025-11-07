% velocity_study_Pe_vs_U.m
clear; clc; close all;

% --- Physical parameters ---
rho_water = 1000;       % kg/m^3
mu_water  = 0.001;      % Pa·s
g         = 9.81;       % m/s^2
Ds        = 1e-9;       % surface diffusivity [m^2/s]

% --- Target Peclet numbers (range 1 to 10) ---
Pe_target = linspace(1, 10, 200);

% --- Compute radii from Peclet numbers ---
R_vals = ((3*mu_water*Ds)./(rho_water*g) .* Pe_target).^(1/3);

% Preallocate
U_clean  = zeros(size(R_vals));
U_rigid  = zeros(size(R_vals));
U_bubble = zeros(size(R_vals));
Pe_check = zeros(size(R_vals));

for i = 1:length(R_vals)
    R = R_vals(i);

    % --- Theoretical limits ---
    prefactor    = (rho_water * g * R^2) / mu_water;
    U_clean(i)   = (1/3) * prefactor;
    U_rigid(i)   = (2/9) * prefactor;

    % --- Peclet number (verification using U_clean) ---
    Pe_check(i)  = (U_clean(i) * R) / Ds;

    % --- Bubble velocity model ---
    U_bubble(i)  = U_rigid(i) + (U_clean(i)-U_rigid(i)) ./ (1+Pe_check(i).^2);
end

% Convert to mm/s
U_clean_mm  = U_clean * 1e3;
U_rigid_mm  = U_rigid * 1e3;
U_bubble_mm = U_bubble * 1e3;

% --- Plot velocity vs Peclet number ---
figure;
plot(Pe_check, U_bubble_mm, 'b-', 'LineWidth', 2); hold on;
plot(Pe_check, U_clean_mm,  'r--', 'LineWidth', 1.5);
plot(Pe_check, U_rigid_mm,  'g--', 'LineWidth', 1.5);

xlabel('Surface Peclet Number, Pe_s');
ylabel('Terminal Velocity (mm/s)');
title('Terminal Velocity vs Peclet Number');
legend('U_{bubble}','U_{clean}','U_{rigid}','Location','best');
grid on;

% MATLAB code with subplots, common labels, and single title (a = 1)
clear; clc; close all;

% Read the Excel sheet
data = readtable('Surface con calculations.xlsx','Sheet','Sheet1','Range','J10:N16');

% Extract angles (degrees) and gamma values
theta_deg    = data{2:end,1};
Gamma_speed1 = data{2:end,2};
Gamma_speed2 = data{2:end,3};
Gamma_speed3 = data{2:end,4};
Gamma_speed4 = data{2:end,5};

% Smooth interpolation
theta_fine = linspace(min(theta_deg), max(theta_deg), 400);
Gamma1 = spline(theta_deg, Gamma_speed1, theta_fine);
Gamma2 = spline(theta_deg, Gamma_speed2, theta_fine);
Gamma3 = spline(theta_deg, Gamma_speed3, theta_fine);
Gamma4 = spline(theta_deg, Gamma_speed4, theta_fine);

% Plot in subplots
figure;

subplot(2,2,1); plot(theta_fine, Gamma1,'LineWidth',2,'Color',[1, 0, 0]); grid on;
title('U = 1e-5 m/s');

subplot(2,2,2); plot(theta_fine, Gamma2,'LineWidth',2,'Color',[ 0, 1, 0]); grid on;
title('U = 3e-4 m/s');

subplot(2,2,3); plot(theta_fine, Gamma3,'LineWidth',2,'Color',[ 0, 0, 1]); grid on;
title('U = 1e-3 m/s');

subplot(2,2,4); plot(theta_fine, Gamma4,'LineWidth',2,'Color',[ 1, 0, 1]); grid on;
title('U = 1e-2 m/s');

% Common x and y labels
han = axes(gcf,'visible','off'); 
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel(han,'\theta (degrees)');
ylabel(han,'\Gamma(\theta)');

% Common overall title
sgtitle('Surfactant distribution for different rise speeds (a = 1)');

close all; clear; clc;

% Define system matrices
A = [0 1; 32 -2.2];
B = [0; 1];
C = [32 0];
D = 0;

% Create state-space system
sys = ss(A, B, C, D);

% Set Q and R values for LQR controller
Q = 2;
R = 0.1;

% Design LQR controller
[K, S, e] = lqry(sys, Q, R)

% Solve the system using ODE45
[t, x] = ode45(@fun, [0 8], [0.3, 0.5]);

% Plot state variables x1 and x2
figure(1);
plot(t, x(:, 1), 'b', 'linewidth', 1);
hold on;
plot(t, x(:, 2), 'r', 'linewidth', 1);
legend('x_1', 'x_2');
xlabel('Time');
ylabel('State Variables');
title('State Variables x_1 and x_2');

% Calculate and plot control signal u
u = -K * x';
figure(2);
plot(t, u, 'k', 'linewidth', 1);
xlabel('Time');
ylabel('Control Signal u');
title('Control Signal');

% Calculate and plot output y
y = C * x';
figure(3);
plot(t, y, 'k', 'linewidth', 1);
xlabel('Time');
ylabel('Output y');
title('Output');


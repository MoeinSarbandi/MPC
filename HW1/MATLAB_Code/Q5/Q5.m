clc, clear all, close all

% Define the optimization variables
cvx_begin
variables x1 x2

% Define the objective function to minimize
minimize((x1 + 5)^2 + (x2 - 2)^2)

% Define the constraints
subject to
1 <= x1 <= 3
-6 <= x2 <= -2
cvx_end

% Display the results
disp('Optimal values:')
disp(['x1 = ', num2str(x1)])
disp(['x2 = ', num2str(x2)])
disp(['Minimum value: ', num2str((x1 + 5)^2 + (x2 - 2)^2)])

% Plot the objective function and constraints
x1_values = linspace(1, 3, 100);
x2_values = linspace(-6, -2, 100);
[X1, X2] = meshgrid(x1_values, x2_values);
f_values = (X1 + 5).^2 + (X2 - 2).^2;

figure;
contour(X1, X2, f_values, 20); % Contour plot of the objective function
hold on;
plot([1, 1, 3, 3, 1], [-6, -2, -2, -6, -6], 'r--'); % Constraint plot
scatter(x1, x2, 100, 'ro', 'filled'); % Optimal point
xlabel('x1');
ylabel('x2');
title('Objective Function and Constraints');
legend('Objective Function', 'Constraints', 'Optimal Point');
grid on;
axis([0 4 -7 -1])


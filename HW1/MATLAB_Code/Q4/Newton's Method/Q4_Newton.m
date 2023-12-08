% Newton's Method for Convex Optimization
clear; clc; close all;
tic

% Initialization and stopping criterion
x = rand(1, 3);
maxIterations = 1000;
tolerance = 0.001;

% Define the objective function
objective = @(x) (4*x(1) - 7)^2 + (0.6*x(2) - 2)^2 + 3*(x(3) + 4)^2 + 12;

% Newton's Method
objective_values = zeros(1, maxIterations);  % To store objective values at each iteration

x1_values = zeros(1, maxIterations);
x2_values = zeros(1, maxIterations);
x3_values = zeros(1, maxIterations);

for iter = 1:maxIterations
    % Evaluate function, gradient, and Hessian
    f_value = objective(x);
    gradient = computeGradient(x);
    hessian = computeHessian(x);
    
    % Compute step direction
    step_direction = -hessian \ gradient;
    
    % Backtracking line search
    alpha = 0.3;  % Step size parameters
    beta = 0.8;
    t = 1;
    
    while objective(x + t * step_direction) > f_value + alpha * t * gradient' * step_direction
        t = beta * t;
    end
    
    % Update the current solution
    x = x + t * step_direction;
    
    % Store the objective value at this iteration
    objective_values(iter) = f_value;
    
    x1_values(iter) = x(1);
    x2_values(iter) = x(2);
    x3_values(iter) = x(3);
    
    % Print the optimization process in the command window
    fprintf('Iteration %d: Objective Value = %f\n', iter, f_value);
    
    % Check the stopping criterion
    if norm(gradient, 2) < tolerance
        break;
    end
end

toc
disp('----------------------------------------------------- ')
disp('---------------------- Results ---------------------- ')
fprintf('Number of Iterations with Newton Method: %d\n', iter);
fprintf('Optimal Solution: (%.3f, %.3f, %.3f)\n', x(1), x(2), x(3));
fprintf('Optimal Value: %3f\n', objective(x));

% Plot the optimization process
figure;
plot(1:iter, objective_values(1:iter), 'k-');
hold on;
plot(1:iter, objective_values(1:iter), 'ko', 'MarkerFaceColor', 'r');
title('Objective Function Value vs. Iteration in Newton Method');
xlabel('Iteration');
ylabel('Objective Function Value');
grid on;

%%
figure;
% Plot x1 vs. Iteration
plot(1:iter, x1_values(1:iter), 'k-');
hold on;
plot(1:iter, x1_values(1:iter), 'ko', 'MarkerFaceColor', 'r');
% Plot x2 vs. Iteration
plot(1:iter, x2_values(1:iter), 'k-');
hold on;
plot(1:iter, x2_values(1:iter), 'ko', 'MarkerFaceColor', 'g');
% Plot x3 vs. Iteration
plot(1:iter, x3_values(1:iter), 'k-');
hold on;
plot(1:iter, x3_values(1:iter), 'ko', 'MarkerFaceColor', 'c');
title('x_1, x_2, x_3 vs. Iteration');
xlabel('Iteration');
ylabel('amplitude');
grid on;




clc; clear; close all

%% Lyapunov equation
Q = eye(2);

for k = -1:0.1:1
    A = [0, k; -1, -2];
    
    % Check the stability conditions
    try
        P = lyap(A', Q);           % Solve the Lyapunov equation for P
    catch
        fprintf('For k = %.2f, the Lyapunov equation is not solvable.\n', k);
        continue;
    end
    
    % Check the stability conditions
    if all(eig(P) > 0) && all(eig(Q) >= 0)
        fprintf('For k = %.2f, the system is globally asymptotically stable.\n', k);
    else
        fprintf('For k = %.2f, the stability condition is not satisfied.\n', k);
    end
end

%% Numerical simulation for a specific value of k

k_values = [-1, 0, 1];
x0 = [1; 1];
tspan = 0:0.01:10;
figure;

for i = 1:length(k_values)
    k = k_values(i);
    A = [0, k; -1, -2];
    [t, x] = ode45(@(t, x) A*x, tspan, x0);
    
    % Plot
    subplot(length(k_values),1, i);
    plot(t, x(:, 1), 'b', t, x(:, 2), 'r');
    xlabel('Time');
    ylabel('State Value');
    legend('x1', 'x2');
    title(['k = ', num2str(k)]);
end

%% check the eigenvalues based on k

for i = 1:length(-1:0.1:1)
    k = -1 + (i-1) * 0.1;
    A = [0, k; -1, -2];
    eigenvalues = eig(A);
    
    eigenvalues_1(i) = real(eigenvalues(1));
    eigenvalues_2(i) = real(eigenvalues(2));
end

% Plot the eigenvalues
figure;
plot(-1:0.1:1, [eigenvalues_1; eigenvalues_2], '-*', 'LineWidth', 1);
xlabel('k');
ylabel('Real Parts of Eigenvalues');
title('Eigenvalues vs. k');
line([-1 1], [0 0 ], 'Color', 'k', 'LineStyle', '--', 'LineWidth', 1.5);
legend('Eigenvalue 1', 'Eigenvalue 2','Stability line');
grid on


clc; clear; close all

% Define the continuous-time open-loop transfer function
s = tf('s');
G = 12 / (s^2 + 3*s);

figure(1)
step(G, 'k')

% Create the closed-loop transfer function
T = feedback(G, 1);

% Convert the closed-loop system to state-space representation
state_space = ss(T);

% Define the simulation time and sampling times
Tf = 20;               % Total simulation time
Ts_values = [0.2, 0.1, 0.05, 0.02, 0.01, 0.001]; % Different sampling times

% Create time vector for continuous plotting
t_continuous = 0:0.001:Tf;

% Step response of the continuous system
[y_continuous, t_continuous] = step(state_space, t_continuous);

figure(2)
plot(t_continuous, y_continuous, 'k' , 'LineWidth', 1)
title('Continuous-Time Step Response of closed loop system')
xlabel('Time (s)')
ylabel('Amplitude')


for i = 1:length(Ts_values)
    Ts = Ts_values(i);
    N = round(Tf / Ts);
    t = 0:Ts:Tf;
    x = [0; 0];
    Y_output = zeros(N+1, 1);
    
    % Euler approximation
    for j = 1:N+1
        x = Ts * (state_space.A * x + state_space.B * 1) + x;
        Y_output(j) = state_space.C * x;
    end
    figure(3);
    subplot(2, 3, i);
    plot(t, Y_output, 'r--');
    title(['Ts = ', num2str(Ts)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    hold on
    plot(t_continuous, y_continuous,'k', 'LineWidth', 1);
    
    figure(4)
    plot(t, Y_output,'--')
    hold on

end

title('Euler Approximation Step Response')
xlabel('Time (s)')
ylabel('Amplitude')
legend(cellstr(num2str(Ts_values', 'Ts = %.2f')))
plot(t_continuous, y_continuous, 'k' , 'LineWidth', 1)
legend('Euler (Ts = 0.2)', 'Euler (Ts = 0.1)', 'Euler (Ts = 0.05)', 'Euler (Ts = 0.02)','Euler (Ts = 0.01)','Euler (Ts = 0.001)', 'Continuous')
hold off



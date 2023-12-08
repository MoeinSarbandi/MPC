close all; clear; clc;

%% Define Plant Model
% Define system matrices
A = [5 0; 0 -3];
B = [1 0; 4 0];
C = [1 0; 0 1];
D = 0;

% Create state-space representation of the system
sys = ss(A, B, C, D);

%% Define MPC Parameters and Settings
Ts = 0.01;       % Sampling time
Np = 20;         % Prediction horizon
Nc = 15;         % Control horizon

% Define output constraints
outputConstraints = struct('Min', 0, 'Max', 1.2);

% Define weights for the cost function
R = 0.05*eye(2);   % Manipulated variable weight
Q = 10*eye(2);     % Output variable weight
S = 0.1*eye(2);    % Manipulated variable rate weight

% Set up the weights structure
Weights = struct('ManipulatedVariables', R, 'ManipulatedVariablesRate', S, 'OutputVariables', Q);

%% Define Different Sets of Input Constraints
% Define "Easy" input constraints
EasyInputConstraints(1) = struct('Min', -10, 'Max', 10, 'RateMin', -20, 'RateMax', 20);
EasyInputConstraints(2) = struct('Min', -20, 'Max', 20, 'RateMin', -15, 'RateMax', 15);
EasyOutputConstraints = struct('Min', 0, 'Max', 5);

% Define "Moderate" input constraints
ModerateInputConstraints(1) = struct('Min', -6, 'Max', 6, 'RateMin', -9, 'RateMax', 9);
ModerateInputConstraints(2) = struct('Min', -8, 'Max', 8, 'RateMin', -10, 'RateMax', 10);
ModerateOutputConstraints = struct('Min', 0, 'Max', 1.5);

% Define "Hard" input constraints
HardInputConstraints(1) = struct('Min', -1, 'Max', 1, 'RateMin', -2, 'RateMax', 2);
HardInputConstraints(2) = struct('Min', -0.5, 'Max', 0.5, 'RateMin', -1, 'RateMax', 1);
HardOutputConstraints = struct('Min', 0, 'Max', 1.2);

%% Create MPC objects for each constraint set
mpcobjEasy = mpc(sys, Ts, Np, Nc, Weights, EasyInputConstraints, EasyOutputConstraints);
mpcobjModerate = mpc(sys, Ts, Np, Nc, Weights, ModerateInputConstraints, ModerateOutputConstraints);
mpcobjHard = mpc(sys, Ts, Np, Nc, Weights, HardInputConstraints, HardOutputConstraints);

%% Perform Simulations for each MPC object
Reference = ones(2);                    % Reference value for the simulation
SimulationTime = 10;                   % Simulation time in seconds
Samples = SimulationTime / Ts;          % Number of simulation samples

% Simulate MPC controllers for each constraint set
%% Perform Simulations for each MPC object
[~, t1, ~, ~, aEasy, ~] = sim(mpcobjEasy, Samples, Reference);
[~, t2, ~, ~, aModerate, ~] = sim(mpcobjModerate, Samples, Reference);
[~, t3, ~, ~, aHard, ~] = sim(mpcobjHard, Samples, Reference);


%% Plot Results for Plant Output Variable 1
figure;

subplot(3,1,1);
plot(t1, aEasy.Plant(:, 1),'k');
title('Easy Constraints - Output');
hold on
plot(t1, aEasy.Plant(:, 2),'m--');


subplot(3,1,2);
plot(t2, aModerate.Plant(:, 1),'k');
title('Moderate Constraints - Output');
hold on
plot(t2, aModerate.Plant(:, 2),'m--');

subplot(3,1,3);
plot(t3, aHard.Plant(:, 1),'k');
title('Hard Constraints - Output');
hold on
plot(t3, aHard.Plant(:, 2),'m--');
%%
figure;
subplot(3,1,1);
plot(t1, aEasy.LastMove(:, 1),'r');
hold on;
plot(t1, aEasy.LastMove(:, 2),'b');
title('Easy Constraints - Control effort');

subplot(3,1,2);
plot(t2, aModerate.LastMove(:, 1),'r');
hold on
plot(t2, aModerate.LastMove(:, 2),'b');

title('Moderate Constraints - Control effort');

subplot(3,1,3);
plot(t3, aHard.LastMove(:, 1),'r');
hold on;
plot(t3, aHard.LastMove(:, 2),'b');

title('Hard Constraints - Control effort');
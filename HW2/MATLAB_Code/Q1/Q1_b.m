close all; clear; clc;
%% Define Plant Model
A = [0 1; -20 -1];
B = [0; 1];
C = [20 0];
D = 0;
% Create state-space representation of the system
LTI_system = ss(A, B, C, D);

%% Define MPC Parameters and Settings
Ts = 0.1;       % Sampling time
Np = 10;        % Prediction horizon
Nc = 3;         % Control horizon

% Define input and output constraints
InputConstraints = struct('Min', -2, 'Max', 2, 'RateMin', -3, 'RateMax', 3);
outputConstraints = struct('Min', 0, 'Max', 1.2);

% Define weights for the cost function
R = 0.05;   % Manipulated variable weight
Q = 2;      % Output variable weight
S = 0.1;    % Manipulated variable rate weight

% Set up the weights structure
Weights = struct('ManipulatedVariables', R, 'ManipulatedVariablesRate', S, 'OutputVariables', Q);

% Create MPC object
mpcobj = mpc(LTI_system, Ts, Np, Nc, Weights, InputConstraints, outputConstraints);

%% Perform Simulation
Reference = 1;                  % Reference value for the simulation
SimulationTime = 5;            % Simulation time in seconds
Samples = SimulationTime / Ts;  % Number of simulation samples

% Simulate MPC controller
sim(mpcobj, Samples, Reference);

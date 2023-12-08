close all; clear; clc;
%% Define Plant Model
A = [5 0; 0 -3];
B = [1 0; 4 0];
C = [1 0; 0 1];
D = 0;

sys = ss(A, B, C, D);
%% Define MPC Parameters and Settings
Ts = 0.01;       % Sampling time
Np = 20;         % Prediction horizon
Nc = 15;         % Control horizon

% Define weight
R = 0.05*eye(2);   % Manipulated variable weight
Q = 10*eye(2);     % Output variable weight
S = 0.1*eye(2);    % Manipulated variable rate weight

% Set up the weights structure
Weights = struct('ManipulatedVariables', R, 'ManipulatedVariablesRate', S, 'OutputVariables', Q);

% Create MPC object
mpcobj = mpc(sys, Ts, Np, Nc, Weights);
Y = struct('Min',[0.9,0.9],'Max',[1.3,1.3]);
U = struct('Min',[-5,-inf]);

%% Perform Simulation
Reference = ones(2);                  % Reference value for the simulation
SimulationTime = 5;            % Simulation time in seconds
Samples = SimulationTime / Ts;  % Number of simulation samples

% Simulate MPC controller
sim(mpcobj, Samples, Reference);

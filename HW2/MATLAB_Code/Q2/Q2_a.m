close all; clear; clc
%% Define Plant Model
A = [5 0; 0 -3];
B = [1 0; 4 0];
C = [1 0; 0 1];
D = 0;

sys = ss(A, B, C, D);

%%
[sys, controllable, uncontrollableStates, observable, unobservableStates] = Controllability_Observability_Analysis(sys);

%%
Ts = 0.01;  % Sampling time
Np = [5, 10, 15, 20];
Nc = [5, 10, 15, 20];

R = {0.05 * eye(2), 0.1 * eye(2)}; % Cell array for different R values
Q = {1 * eye(2), 5 * eye(2), 10 * eye(2)}; % Cell array for different Q values
S = {0.1 * eye(2), 0.5 * eye(2), 1 * eye(2)}; % Cell array for different S values
%%

best_combination = findBestParameters(sys, Ts, Np, Nc, R, Q, S);
Number_of_Sim = numel(Np)*numel(Nc)*numel(R)*numel(Q)*numel(S)
disp('Best Combination:');
disp(best_combination)
%%
plotSystemResponse(sys, Ts, best_combination);

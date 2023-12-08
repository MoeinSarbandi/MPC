close all; clear; clc;

% Define system matrices
A = [0 1; 32 -2.2];
B = [0; 1];
C = [32 0];
D = 0;

% Create state-space system
SYS = ss(A, B, C, D);

% Create transfer-function system
transfer_function=tf(SYS);

mpcobject=mpc(SYS,0.01);
sim('Q3_b.slx')

% figure(1);
% plot(Y.Time, Y.Data(:,1))
% hold on
% plot(Y.Time, Y.Data(:,2))
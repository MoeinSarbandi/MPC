function plotSystemResponse(sys, Ts, best_combination)
    Np = best_combination.Np;
    Nc = best_combination.Nc;
    R = best_combination.R;
    Q = best_combination.Q;
    S = best_combination.S;

    Weights = struct('ManipulatedVariables', R, 'ManipulatedVariablesRate', S, 'OutputVariables', Q);

    mpcobj = mpc(sys, Ts, Np, Nc, Weights);

    Reference = ones(2);
    SimulationTime = 5;
    Samples = SimulationTime / Ts;

    [~, t1, ~, ~, a, ~] = sim(mpcobj, Samples, Reference);
    Plant_Inputs = a.LastMove;
    Plant_OutPut = a.Plant;

    % Plotting
    figure;
    subplot(2, 1, 1);
    plot(t1, Plant_OutPut(:, 1), 'b', t1, Reference(1, 1) * ones(size(t1)), 'r--');
    xlabel('Time');
    ylabel('Output 1');
    title('System Response for Output 1');
    legend('System Output 1', 'Reference');

    subplot(2, 1, 2);
    plot(t1, Plant_OutPut(:, 2), 'g', t1, Reference(2, 2) * ones(size(t1)), 'm--');
    xlabel('Time');
    ylabel('Output 2');
    title('System Response for Output 2');
    legend('System Output 2', 'Reference');

    figure;
    subplot(2, 1, 1);
    plot(t1, Plant_Inputs(:, 1), 'b');
    xlabel('Time');
    ylabel('Output 1');
    title('Control effort 1');
    legend('System Output 1', 'Reference');

    subplot(2, 1, 2);
    plot(t1, Plant_Inputs(:, 2), 'k');
    xlabel('Time');
    ylabel('Output 2');
    title('Control effort 2');
    legend('System Output 2', 'Reference');
end

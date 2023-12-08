function best_combination = findBestParameters(sys, Ts, Np_values, Nc_values, R_values, Q_values, S_values)
    % Initialization
    best_overshoot = Inf;
    best_control_effort = Inf;
    best_combination = struct('Np', 0, 'Nc', 0, 'R', [], 'Q', [], 'S', []);

    for i = 1:length(Np_values)
        for j = 1:length(Nc_values)
            for k = 1:length(R_values)
                for l = 1:length(Q_values)
                    for m = 1:length(S_values)
                        Np = Np_values(i);
                        Nc = Nc_values(j);
                        R = R_values{k};
                        Q = Q_values{l};
                        S = S_values{m};

                        Weights = struct('ManipulatedVariables', R, 'ManipulatedVariablesRate', S, 'OutputVariables', Q);

                        mpcobj = mpc(sys, Ts, Np, Nc, Weights);

                        Reference = ones(2);
                        SimulationTime = 5;
                        Samples = SimulationTime / Ts;

                        [~, ~, ~, ~, a, ~] = sim(mpcobj, Samples, Reference);
                        Plant_Inputs = a.LastMove;
                        Plant_OutPut = a.Plant;

                        % Compute performance metrics
                        overshoot_metric = max(max(abs(Plant_OutPut - ones(1, 2))));
                        control_effort_metric = sum(sum(abs(Plant_Inputs)));

                        % Compare metrics to find the best combination
                        if overshoot_metric < best_overshoot && control_effort_metric < best_control_effort
                            best_overshoot = overshoot_metric;
                            best_control_effort = control_effort_metric;

                            best_combination.Np = Np;
                            best_combination.Nc = Nc;
                            best_combination.R = R;
                            best_combination.Q = Q;
                            best_combination.S = S;
                        end
                    end
                end
            end
        end
    end
end
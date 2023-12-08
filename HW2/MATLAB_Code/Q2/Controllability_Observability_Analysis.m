function [sys, controllable, uncontrollableStates, observable, unobservableStates] = Controllability_Observability_Analysis(sys)

controllabilityMatrix = ctrb(sys);
observabilityMatrix = obsv(sys);

uncontrollableStates = length(sys.A) - rank(controllabilityMatrix);
unobservableStates = length(sys.A) - rank(observabilityMatrix);

controllable = uncontrollableStates == 0;
observable = unobservableStates == 0;

if ~controllable
    disp(['System has ', num2str(uncontrollableStates), ' uncontrollable state(s).']);
else
    disp('System is fully controllable.');
end

if ~observable
    disp(['System has ', num2str(unobservableStates), ' unobservable state(s).']);
else
    disp('System is fully observable.');
end
end
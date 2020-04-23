ObjectiveFunction = @fitfun;
nvars = 8;    % Number of variables
LB = [1 10 37 7 15 60 170 40];   % Lower bound
UB = [2 15 42 15 25 70 200 50];  % Upper bound
ConstraintFunction = @simple_constraint;

% options = optimoptions(@ga,'MutationFcn',@mutationadaptfeasible);

opts = optimoptions(@ga,'InitialPopulationMatrix',[1 20 38 14 20 50 180 25],'PopulationSize', 10,'MaxGenerations', 20, 'EliteCount', 1,'FunctionTolerance', 500,'PlotFcn', @gaplotbestf);
                
options = optimoptions(opts,'PlotFcn',{@gaplotbestf,@gaplotdistance},'Display','iter');
%
% Next we run the GA solver.
[xbest, fbest, exitflag] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ConstraintFunction,[1 2 3 4 5 6 7 8],options)



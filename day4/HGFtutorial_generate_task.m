function HGFtutorial_generate_task()
%--------------------------------------------------------------------------
% Maybe add a function description or tutorial overview here.
%
%
%
%--------------------------------------------------------------------------


%% Defaults
set(0,'defaultAxesFontSize',16);


%% Generate Input
numberBlocks = 10;
probabilityStructureVolatility=[0.5,0.5,0.9,0.1,0.9,0.1,0.8,0.2,0.5,0.5];
nTrials = 21;
meanProb = [tapas_logit(probabilityStructureVolatility(1),1) tapas_logit(probabilityStructureVolatility(2),1)...
    tapas_logit(probabilityStructureVolatility(3),1),tapas_logit(probabilityStructureVolatility(4),1)...
    tapas_logit(probabilityStructureVolatility(5),1),tapas_logit(probabilityStructureVolatility(6),1)...
    tapas_logit(probabilityStructureVolatility(7),1),tapas_logit(probabilityStructureVolatility(8),1)...
    tapas_logit(probabilityStructureVolatility(9),1),tapas_logit(probabilityStructureVolatility(10),1)];
u = [];
figure;
phaseArray = {'k','g','m','c','m','c','b','r','k','g'};
for iStages = 1:numberBlocks
    [inputVector, probabilityStructureVolatility] = gen_design_volatility(meanProb(iStages), nTrials - 1);
    subplot(5, 2, iStages);
    stem(inputVector, 'r--');
    hold all
    plot(probabilityStructureVolatility, phaseArray{iStages}, 'LineWidth', 3);
    legend('t', '\theta');
    ylim = ([-0.3 1.1]);
    u = [u; inputVector'];
end


%% Basic Implementations
% Get Bayes optimal parameters given the input
bopars = tapas_fitModel([], u, 'tapas_hgf_binary_config', 'tapas_bayes_optimal_binary_config',...
    'tapas_quasinewton_optim_config');
tapas_hgf_binary_plotTraj(bopars);

% The only parameter whose Bayes optimal values we've estimated is $\omega$. 
% This is the tonic volatility in the HGF. At the first level, $\omega_1$ is undefined 
% (NaN) because in the binary HGF the first level is discrete, not continuous. 
% At the second level, we find an optimal value of, for example, $\omega_2=-3.43$, 
% and at the third level one of, for example, $\omega_3=-6.01$ (this will vary 
% on different runs of this script).
% 
% The other parameters are fixed to a particular value because their prior 
% variance has been set to zero in the configuration file _tapas_hgf_binary_config.m. 
% _This means that their posterior means, displayed here, are the same as the 
% prior means set in _tapas_hgf_binary_config.m_.
% 
% Their meanings are
% 
% * $\mu_0$ and $\sigma_0$ are the initial values of the perceptual state
% * $\rho$ is a drift parameter, fixed to zero (ie, no drift) in this example
% * $\kappa$ is a parameter that describes the couple between the different 
% levels of the HGF, fixed to 1 in this example
% 
% For model comparison purposes, several measures of model quality are given 
% by fitModel. The most important of these is the log-model evidence (LME).


%% Simulate Behaviour
sim = tapas_simModel(u,...
    'tapas_hgf_binary', bopars.p_prc.p,...
    'tapas_unitsq_sgm', 5,...
    12345);
tapas_hgf_binary_plotTraj(sim);

% We simulate an agent's responses using the simModel function. To do 
% that, we simply choose the optimal values for the parameters. 
% But in addition to the perceptual model _hgf_binary_, we now 
% need a response model. Here, we take the unit square sigmoid model, _unitsq_sgm_, 
% with parameter $\zeta=5$. The last argument is an optional seed for the random 
% number generator.


%% Inversion
est = tapas_fitModel(sim.y, sim.u,...
    'tapas_hgf_binary_config',...
    'tapas_unitsq_sgm_config',...
    'tapas_quasinewton_optim_config');
tapas_hgf_binary_plotTraj(est);

% Recover parameter values from simulated responses:
% We can now try to recover the parameters we put into the simulation ($\omega_2=-2.5$ 
% and $\omega_3=-6$) using fitModel.


%% Check parameter identifiability
% To check how well the parameters could be identified, we can take a look at 
% their posterior correlation. This gives us an idea to what degree changing one 
% parameter value can be compensated by changing another. Of course changing a 
% parameter is fully equivalent to changing that same parameter, therefore the 
% values on the diagonal of the correlation matrix are all 1. However, it would 
% be worrisome if changing one parameter's value were equivalent to changing another 
% in the same direction (correlation +1) or in the opposite direction (correlation 
% -1). In these cases the two parameters cannot be identified independently and 
% one of them needs to be fixed. The other parameter can then be estimated conditional 
% on the value of the one that has been fixed.

tapas_fit_plotCorr(est)
colormap(flipud(gray)) % Change colormap to gray
add_values_to_imagesc(est.optim.Corr); % Add correlation values to plot
 
% In this case, there is nothing to worry about. Unless their correlation 
% is very close to +1 or -1, two parameters are identifiable, meaning that they 
% describe distinct aspects of the data.

% The posterior parameter correlation matrix is stored in est.optim.Corr,
disp(est.optim.Corr)
 
% While the posterior parameter covariance matrix is stored in est.optim.Sigma
disp(est.optim.Sigma)


%% Posterior means
% The posterior means of the estimated as well as the fixed parameters can be 
% found in est.p_prc for the perceptual model and in est.p_obs for the observation 
% model:
disp(est.p_prc)
disp(est.p_obs)
 
% The posterior means are contained in these structures separately by name 
% (e.g., om for $\omega$) as well as jointly as a vector $p$ in their native space 
% and as a vector $p_{\mathrm{trans}}$ in their transformed space (ie, the space 
% they are estimated in). For details, see the manual.


%% Inferred belief trajectories
% As with the simulated trajectories, we can plot the inferred belief trajectories 
% implied by the estimated parameters.
tapas_hgf_binary_plotTraj(est);
 
% These trajectories can be found in est.traj:
disp(est.traj)


%% Other Perceptual models
% Next, let's try to fit the same data using a different perceptual model while 
% keeping the same response model. We will take the Rescorla-Wagner model _rw_binary_.
est1a = tapas_fitModel(sim.y,...
                       sim.u,...
                       'tapas_rw_binary_config',...
                       'tapas_unitsq_sgm_config',...
                       'tapas_quasinewton_optim_config');
                   
% The single estimated perceptual parameter is the constant learning rate 
% $\alpha$.
% 
% Just as for _hgf_binary_, we can plot posterior correlations and inferred 
% trajectories for _rw_binary_.
tapas_rw_binary_plotTraj(est1a)
tapas_fit_plotCorr(est1a)
colormap(flipud(gray)) % Change colormap to gray
add_values_to_imagesc(est.optim.Corr); % Add correlation values to plot


%% Compare learning rates: HGF versus Rescorla-Wagner
figure; 
plot(est1a.p_prc.al.*ones(size(est1a.traj.v(:,1),1),1),'b','MarkerSize',6);
hold on; plot(est.traj.muhat(:,1).*(1-est.traj.muhat(:,1)).*est.traj.sahat(:,2),'r','MarkerSize',6);
plot(est.traj.sahat(:,3).*est.traj.w(:,2),'s-m','MarkerSize',6);
xlim([1 210]);
title('Learning Rates: RW versus HGF');
xlabel('Trials');
ylabel('Learning Rates');
legend('RW','HGF LR1','HGF LR2','Location','northwest');
  

%% Add Volatility
new_input = [];
for iStages = 1:numberBlocks
    [inputVolatility, probabilityStructureVolatility] = gen_design(meanProb(iStages), nTrials - 1);
    new_input = [new_input; inputVolatility'];
    subplot(5,2,iStages);
    stem(inputVolatility, 'r--');
    hold all
    plot(probabilityStructureVolatility, phaseArray{iStages}, 'LineWidth', 3);
    legend('t', '\theta');
    ylim = ([-0.3 1.1]);
    u = [u;inputVolatility'];
end

% Simulation
sim2 = tapas_simModel(new_input,...
    'tapas_hgf_binary', bopars.p_prc.p,...
    'tapas_unitsq_sgm', 5);
tapas_hgf_binary_plotTraj(sim2);

% Inversion
est2 = tapas_fitModel(sim2.y, sim2.u,...
    'tapas_hgf_binary_config',...
    'tapas_unitsq_sgm_config',...
    'tapas_quasinewton_optim_config');
tapas_hgf_binary_plotTraj(est2);
tapas_fit_plotCorr(est2);
colormap(flipud(gray)) % Change colormap to gray
add_values_to_imagesc(est.optim.Corr); % Add correlation values to plot

% RW
est2a = tapas_fitModel(sim2.y,...
                       sim2.u,...
                       'tapas_rw_binary_config',...
                       'tapas_unitsq_sgm_config',...
                       'tapas_quasinewton_optim_config');

                   
%% Compare learning rates: HGF versus Rescorla-Wagner
figure; 
hold on; 
plot(est1a.p_prc.al.*ones(size(est1a.traj.v(:,1),1),1),'b','MarkerSize',6);
plot(est.traj.muhat(:,1).*(1-est.traj.muhat(:,1)).*est.traj.sahat(:,2),'r','MarkerSize',6);
plot(est.traj.sahat(:,3).*est.traj.w(:,2),'s-m','MarkerSize',6);
plot(est2a.p_prc.al.*ones(size(est2a.traj.v(:,1),1),1),'c','MarkerSize',6);
plot(est2.traj.muhat(:,1).*(1-est2.traj.muhat(:,1)).*est2.traj.sahat(:,2),'k','MarkerSize',6);
plot(est2.traj.sahat(:,3).*est2.traj.w(:,2),'s-g','MarkerSize',6);
hold off;
xlim([1 210]);
title('Learning Rates: RW versus HGF');
xlabel('Trials');
ylabel('Learning Rates');
legend('RW','HGF LR1','HGF LR2','Location','northwest');



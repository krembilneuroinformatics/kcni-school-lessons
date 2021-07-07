%--------------------------------------------------------------------------
% The purpose of this tutorial is to show you the first steps to enable you
% to use the HGF and it consists of several parts:
%
% PART 1: Generating an experimental design 
%   -> Generating a probability structure 
%   -> Generate corresponding experimental inputs
%
% PART 2: Simulating an ideal observer
%   -> Estimating Bayes-optimal parameters given the input structure 
%   -> Simulating responses of an ideal observer
%
% PART 3: Model inversion
%   -> Inverting the HGF model
%   -> Inspect parameter identifiability 
%   -> Visualize inferred belief trajectories.
%
% PART 4: Invert a Rescorla-Wagner model
%   -> Inverting the Rescorla-Wagner model
%   -> Compare learning rates of the two models
%
%--------------------------------------------------------------------------


%% Defaults
% Sets axis font size (this may depend on your screen size, you can
% increase it to 20, if the font is too small).
set(0,'defaultAxesFontSize', 18); 
random_seed = 999; % Random seed for simulations


%% PART 1: Generate probability structure 
% Array that indicates the probability of the binary outcome = 1 for each
% experimental block
prob_struct = [0.5, 0.5, 0.9, 0.1, 0.9, 0.1, 0.8, 0.2, 0.5, 0.5];
n_trials    = 21;                  % Number of trials within a block
n_blocks    = length(prob_struct); % Number of blocks
last_trial  = n_trials*n_blocks;   % Get last trial (for plotting)

% Create the volatility structure for all trials
vol_struct = repmat(prob_struct, n_trials, 1); 
vol_struct = vol_struct(:);

% Let's see what it looks like
figure('units','normalized','outerposition',[0 0 1 1])
plot(vol_struct, 'k');
xlim([0, last_trial]);
ylim([-0.05, 1.05]);
xlabel('Trials')
ylabel('Probability of Outcome ''1''')


%% PART 1: Generate input for a task
% Now let's generate some input sequence by sampling from the true 
% probabilities
rng(random_seed); % Set random seed to make sure, we all see the same results
u = binornd(1, vol_struct);

% Let's add them to the plot
figure('units','normalized','outerposition',[0 0 1 1])
hold on;
plot(vol_struct, 'k');
plot(u,'.', 'Color', [0 0.6 0], 'MarkerSize', 12);
hold off;
xlim([0, last_trial]);
ylim([-.05, 1.05]);
xlabel('Trials')
ylabel('Probability of Outcome ''1''')


%% PART 2: Obtain Bayes-optimal parameters
% We will now simulate parameters of an artifical learner that sees the
% input we just generated. This is useful for example to determine starting
% values, when inverting the behavioral data of actual participants or to
% verify identifiability of parameters or a model space a priori.

% Get Bayes optimal parameters given the input
bopars = tapas_fitModel([], u,...           % experimental input
    'tapas_hgf_binary_config',...           % perceptual model function
    'tapas_bayes_optimal_binary_config',... % observational model function
    'tapas_quasinewton_optim_config');      % optimization function
tapas_hgf_binary_plotTraj(bopars);
hold on; plot(vol_struct,'k:'); hold off; % Plot volatility structure 

% The only parameter whose Bayes optimal values we've estimated is $\omega$. 
% This is the tonic volatility in the HGF. At the first level, $\omega_1$ 
% is undefined (NaN) because in the binary HGF the first level is discrete, 
% not continuous. 
% At the second level, we find an optimal value of, for example, 
% $\omega_2=-3.43$, and at the third level one of, for example, 
% $\omega_3=-6.01$ (this will vary on different runs of this script).
% 
% The other parameters are fixed to a particular value because their prior 
% variance has been set to zero in the configuration file 
% tapas_hgf_binary_config.m. This means that their posterior means,
% displayed here, are the same as the prior means set in 
% tapas_hgf_binary_config.m.
% 
% Their meanings are:% 
% * $\mu_0$ and $\sigma_0$ are the initial values of the perceptual state
% * $\rho$ is a drift parameter, fixed to zero (ie, no drift) in this 
% example
% * $\kappa$ is a parameter that describes the coupling between the 
% different levels of the HGF, fixed to 1 in this example
% 
% For model comparison purposes, several measures of model quality are given 
% by fitModel. The most important of these is the log-model evidence (LME).


%% PART 2: Simulate behaviour of an ideal observer
% We will now simulate how this agent would respond to seeing this input.
sim = tapas_simModel(u,...
    'tapas_hgf_binary', bopars.p_prc.p,...
    'tapas_unitsq_sgm', 5,...
    random_seed);
tapas_hgf_binary_plotTraj(sim);
hold on; plot(vol_struct, 'k:'); hold off; % Plot volatility structure 

% We simulate an agent's responses using the simModel function. To do 
% that, we simply choose the optimal values for the parameters. 
% But in addition to the perceptual model _hgf_binary_, we now 
% need a response model. Here, we take the unit square sigmoid model, 
% tapas_unitsq_sgm_, with parameter $\zeta=5$. The last argument is an 
% optional seed for the random number generator.


%% PART 3: Model Inversion
% Now, we will invert the model on the experimental input (u) and the
% responses we just simulated (y). If you are inverting the model using
% real data you need to pass participants' responses instead of sim.y to
% tapas_fitModel.

est = tapas_fitModel(sim.y, sim.u,...
    'tapas_hgf_binary_config',...
    'tapas_unitsq_sgm_config',...
    'tapas_quasinewton_optim_config');

% When we inspect the parameters that we used to simulate behavior (found
% in the 'sim' structure) and the recovered parameters that we obtained 
% from inverting the model on the simulated responses (found in the 'est'
% structure), we see that they closely correspond to each other. Good.
fprintf('Parameters of ideal observer:\n omega: %.4f\n theta: %.4f\n\n',...
    sim.p_prc.om(end), sim.p_prc.th)
fprintf('Recovered parameters:\n omega: %.4f\n theta: %.4f\n\n',...
    est.p_prc.om(end), est.p_prc.th)


%% PART 3: Investigate parameter identifiability
% To check how well the parameters could be identified, we can take a look 
% at their posterior correlation. This gives us an idea to what degree 
% changing one parameter value can be compensated by changing another. Of 
% course changing a parameter is fully equivalent to changing that same 
% parameter, therefore the values on the diagonal of the correlation matrix 
% are all 1. However, it would be worrisome if changing one parameter's 
% value were equivalent to changing another in the same direction 
% (correlation = +1) or in the opposite direction (correlation = -1). In 
% these cases the two parameters cannot be identified independently and 
% one of them needs to be fixed. The other parameter can then be estimated 
% conditional on the value of the one that has been fixed.

tapas_fit_plotCorr(est)
colormap(flipud(gray))                 % Change colormap to gray
add_values_to_imagesc(est.optim.Corr); % Add correlation values to plot
 
% In this case, there is nothing to worry about. Unless their correlation 
% is very close to +1 or -1, two parameters are identifiable, meaning that 
% they describe distinct aspects of the data.

% The posterior parameter correlation matrix is stored in est.optim.Corr
disp(est.optim.Corr)
 
% While the posterior parameter covariance matrix is stored in 
% est.optim.Sigma
disp(est.optim.Sigma)

% Posterior means
% The posterior means of the estimated as well as the fixed parameters can 
% be found in est.p_prc for the perceptual model and in est.p_obs for the 
% observation model:
disp(est.p_prc)
disp(est.p_obs)
 
% The posterior means are contained in these structures separately by name 
% (e.g., om for $\omega$) as well as jointly as a vector $p$ in their 
% native space and as a vector $p_{\mathrm{trans}}$ in their transformed 
% space (ie, the space they are estimated in). For details, see the manual.


%% PART 3: Inferred belief trajectories
% As with the simulated trajectories, we can plot the inferred belief 
% trajectories implied by the estimated parameters.
tapas_hgf_binary_plotTraj(est);
hold on; plot(vol_struct, 'k:'); hold off; % Plot volatility structure 

% These trajectories can be found in est.traj:
disp(est.traj);


%% PART 4: Inverting a Reescorla-Wagner Model
% Next, let's try to fit the same data using a different perceptual model 
% while keeping the same response model. We will take the Rescorla-Wagner
% model, which can be found in tapas_rw_binary.

est_rw = tapas_fitModel(sim.y,...
                       sim.u,...
                       'tapas_rw_binary_config',...
                       'tapas_unitsq_sgm_config',...
                       'tapas_quasinewton_optim_config');
                   
% The single estimated perceptual parameter is the constant learning rate 
% $\alpha$.

% Just as for _hgf_binary_, we can plot posterior correlations and inferred 
% trajectories for this model.

% Plot Correlation
tapas_fit_plotCorr(est_rw)
colormap(flipud(gray))                 % Change colormap to gray
add_values_to_imagesc(est_rw.optim.Corr); % Add correlation values to plot

% Plot Trajectory
tapas_rw_binary_plotTraj(est_rw);
hold on; plot(vol_struct, 'k:'); hold off; % Plot volatility structure 


%% PART 4: Compare learning rates: HGF versus Rescorla-Wagner
% Now let's compare the learning rates for the two models. To do this, we
% first need to compute them.
lr_rw = est_rw.p_prc.al.*ones(size(est_rw.traj.v(:,1),1),1);
lr_hgf_lvl1 = est.traj.muhat(:,1).*(1-est.traj.muhat(:,1)).*est.traj.sahat(:,2);
lr_hgf_lvl3 = est.traj.sahat(:,3).*est.traj.w(:,2);

% Now we can plot them.
figure('units','normalized','outerposition',[0 0 1 1])
hold on;
plot(lr_rw, 'b');
plot(lr_hgf_lvl1, 'r');
plot(lr_hgf_lvl3, 'c');
plot(u,'.', 'Color', [0 0.6 0], 'MarkerSize', 12); % Plot input
plot(vol_struct, 'k:'); % Plot volatility structure
hold off;
xlim([1 last_trial]);
ylim([-0.05, 1.05])
title('Learning Rates: RW versus HGF');
xlabel('Trials');
ylabel('Learning Rates');
legend('RW', 'HGF LVL1', 'HGF LVL3', 'Input', 'Probability',...
    'Position', [0.78 0.6 0.1 0.2]);



%--------------------------------------------------------------------------
% The purpose of this tutorial is to show you how you can understand 
% changes in parameters and simulate different artificial learners that 
% could correspond to different clinical phenotypes. Again, this tutorial
% consists of several parts:
%
% PART 1: Design your task (Repetition)
%   -> Generating a probability structure 
%   -> Generate corresponding experimental inputs
%
% PART 2: Simulating an ideal observer (Repetition)
%   -> Estimating Bayes-optimal parameters given the input structure 
%
% PART 3: Investigating parameter changes
%   -> Simulate under different parameters to understand how they impact
%   the ensuing belief trajectories
%
% PART 4: Simulating prototypical patients
%   -> Simulate two different learners and compare them
%
%--------------------------------------------------------------------------


%% Defaults
% Sets axis font size (this may depend on your screen size, you can
% increase it to 20, if the font is too small or decrease it).
set(0,'defaultAxesFontSize', 18); 
random_seed = 999; % Random seed for simulations


%% PART 1: Design your task
% Array that indicates the probability of the binary outcome = 1 for each
% experimental block
prob_struct = [0.5, 0.5, 0.9, 0.1, 0.9, 0.1, 0.8, 0.2, 0.5, 0.5];
n_trials    = 21;                  % Number of trials within a block
n_blocks    = length(prob_struct); % Number of blocks
last_trial  = n_trials*n_blocks;   % Get last trial (for plotting)

% Create the volatility structure for all trials
vol_struct = repmat(prob_struct, n_trials, 1); 
vol_struct = vol_struct(:);

% Generate some inputs
rng(random_seed); % Set random seed to make sure, we all see the same results
u = binornd(1, vol_struct);

% Plot the design
figure('units','normalized','outerposition',[0 0 1 1])
hold on;
plot(vol_struct);
plot(u,'.', 'Color', [0 0.6 0], 'MarkerSize', 12);
hold off;
xlim([0, last_trial]);
ylim([-.05, 1.05]);
xlabel('Trials')
ylabel('Probability of Outcome ''1''')


%% PART 2: Generate an ideal observer
% Now let's generate an ideal observer again. However, this time we will
% use a slightly more complex model in which we can also specify a drift 
% at the third level that formalizes the idea that participants may 
% experience the environment as increasingly volatile or increasingly 
% stable over time.

% Get Bayes optimal parameters given the input
bopars = tapas_fitModel([], u,...           % experimental input
    'KCNI2020_hgf_ar1_lvl3_config',...      % perceptual model function
    'tapas_bayes_optimal_binary_config',... % observational model function
    'tapas_quasinewton_optim_config');      % optimization function
% Simulate how this agent would respond to seeing this input.
sim = tapas_simModel(u,...
    'KCNI2020_hgf_ar1_lvl3', bopars.p_prc.p,...
    'tapas_unitsq_sgm', 5,...
    random_seed);
plot_hgf_binary_traj(sim);
hold on; plot(vol_struct, 'k:'); hold off; % Plot volatility structure 


%% PART 3: Investigate parameter changes
% To understand what the parameters do it is helpful to see how changes in
% the parameters affect the belief trajectories. 
% Choose a parameter to vary, possible options are:
% 'ka2'     -> Coupling between hierarchical levels (Phasic learning rate)
% 'om2'     -> Learning rate at second level (Tonic learning rate) 
% 'th'      -> Meta-volatility
% 'm3'      -> Equilibrium/Attractor point for drift at third level
% 'phi3'    -> Drift rate at third level

parameter = 'ka2'; % Change the parameter you want to investigate
[parameter_idx, parameter_name, parameter_array] = get_hgf_parameter_index(parameter);

% Simulate trajectories for different parameter values, while keeping the
% other parameters fixed to the parameters of the ideal observer.
sims = cell(0);
for idx_sim = 1: length(parameter_array)
    sims{idx_sim} = tapas_simModel(u, ...
        'KCNI2020_hgf_ar1_lvl3',...
        [bopars.p_prc.p(1:parameter_idx-1) parameter_array(idx_sim) bopars.p_prc.p(parameter_idx+1:end)],...
        'tapas_unitsq_sgm', 5,...
        random_seed);
end

% And let's look at them
plot_multiple_hgf_traj(sims, parameter_name, parameter_array);
hold on;  h = plot(vol_struct, 'k:'); h.Annotation.LegendInformation.IconDisplayStyle = 'off'; hold off; % Plot volatility structure 

% Feel free to try out different parameters to learn how they will affect
% the belief trajectories.


%% PART 4: Simulate prototypical patients
% Now, you can generate some prototypical patients by specifying which
% parameter will be affected and by specifying a value for this parameter.
% If you select a parameter value that is too high or too low the inversion
% may not work. To be on the safe side, you can use parameters in the
% range of PART 3 (you can also look at the ranges for all parameters in
% the get_hgf_parameter_index() function. These are tested and should work.
% Note, that the parameter range that is sensible may also vary with your
% input structure.

% Let's give this simulation a name
simulation_name = 'Early Psychosis';
% What should we call our artifical agents?
person1_name = 'Patient 1';
person2_name = 'Patient 2';

% Simulate first person
parameter = 'm3';       % You can also generate hypothesis using other parameters 
parameter_value = -1;    % Or other parameter values
parameter_idx = get_hgf_parameter_index(parameter);

person1 = tapas_simModel(u, ...
        'KCNI2020_hgf_ar1_lvl3' ,...
        [bopars.p_prc.p(1:parameter_idx-1) parameter_value bopars.p_prc.p(parameter_idx+1:end)],...
        'tapas_unitsq_sgm', 5,...
        random_seed);

% Simulate second person
parameter = 'm3';       % You can also generate hypothesis using other parameters 
parameter_value = 3;   % Or other parameter values
parameter_idx = get_hgf_parameter_index(parameter);

person2 = tapas_simModel(u, ...
        'KCNI2020_hgf_ar1_lvl3' ,...
        [bopars.p_prc.p(1:parameter_idx-1) parameter_value bopars.p_prc.p(parameter_idx+1:end)],...
        'tapas_unitsq_sgm', 5,...
        random_seed);

% Plot the two artifical agents together 
plot_multiple_hgf_traj({person1, person2}, simulation_name, {person1_name, person2_name});
hold on;  h = plot(vol_struct, 'k:'); h.Annotation.LegendInformation.IconDisplayStyle = 'off'; hold off; % Plot volatility structure 
 



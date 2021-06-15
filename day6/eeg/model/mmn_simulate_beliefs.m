function sim = mmn_simulate_beliefs( tones )
%MMN_SIMULATE_BELIEFS Estimates Bayes-optimal parameters for MMN subjects
%   Given a sequence of tones of subject id, the function computes
%   the parameters and trajectories of an ideal Bayesian learner and saves
%   the results in the sim structure.

%   model versions are now set in the tapas_fitModel.m file
%   currently used models are:
%   modelVersion = 'tapas_hgf_transition_config';
%   bayesVersion = 'tapas_bayes_optimal_transition_config';
%   optimVersion = 'tapas_quasinewton_optim_config';

% fit model to current subject
sim = tapas_fitModel_mmn([], tones);

end


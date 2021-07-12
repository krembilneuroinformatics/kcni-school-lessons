function c = tapas_hgf_transition_volconst_config
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Contains the configuration for the Hierarchical Gaussian Filter (HGF) for binary inputs restricted
% to 2 levels, no drift, and no inputs at irregular intervals, in the absence of perceptual
% uncertainty.
%
% This model deals with the situation where an agent has to determine the contingencies of (i.e.,
% the transition matrix between) different states of its environment. The elements of the transition
% matrix are assumed to perform Gaussian random walks in logit space. The volatilities of all of
% these walks are determined by the same parameter omega.
%
% The HGF is the model introduced in 
%
% Mathys C, Daunizeau J, Friston, KJ, and Stephan KE. (2011). A Bayesian foundation
% for individual learning under uncertainty. Frontiers in Human Neuroscience, 5:39.
%
% This file refers to BINARY inputs (Eqs 1-3 in Mathys et al., (2011));
% for continuous inputs, refer to hgf_config.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The HGF configuration consists of the priors of parameters and initial values. All priors are
% Gaussian in the space where the quantity they refer to is estimated. They are specified by their
% sufficient statistics: mean and variance (NOT standard deviation).
% 
% Quantities are estimated in their native space if they are unbounded (e.g., omega). They are
% estimated in log-space if they have a natural lower bound at zero (e.g., sigma2).
% 
% 'Logit-space' is a logistic sigmoid transformation of native space with a variable upper bound
% a>0:
% 
% logit(x) = ln(x/(a-x)); x = a/(1+exp(-logit(x)))
%
% Parameters can be fixed (i.e., set to a fixed value) by setting the variance of their prior to
% zero. Aside from being useful for model comparison, the need for this arises whenever the scale
% and origin of x3 are arbitrary. This is the case if the observation model does not contain the
% representations mu3 and sigma3 from the third level. A choice of scale and origin is then
% implied by fixing the initial value mu3_0 of mu3 and either kappa or omega.
%
% Kappa and theta can be fixed to an arbitrary value by setting the upper bound to twice that
% value and the mean as well as the variance of the prior to zero (this follows immediately from
% the logit transform above).
% 
% Fitted trajectories can be plotted by using the command
%
% >> tapas_hgf_transition_volconst_plotTraj(est)
% 
% where est is the stucture returned by fitModel. This structure contains the estimated
% perceptual parameters in est.p_prc and the estimated trajectories of the agent's
% representations (cf. Mathys et al., 2011). Their meanings are:
%              
%         est.p_prc.mu2_0      initial values of the mu2s
%         est.p_prc.sa2_0      initial values of the sigma2s
%         est.p_prc.mu3_0      initial value of mu3
%         est.p_prc.sa3_0      initial value of sigma3
%         est.p_prc.ka         kappa
%         est.p_prc.om         omega
%         est.p_prc.th         theta
%
%         est.traj.mu          mu
%         est.traj.sa          sigma
%         est.traj.muhat       prediction mean
%         est.traj.sahat       prediction variance
%         est.traj.v           inferred variances of random walks
%         est.traj.w           weighting factor of informational and environmental uncertainty at the 2nd level
%         est.traj.da          prediction errors
%         est.traj.ud          updates with respect to prediction
%         est.traj.psi         precision weights on prediction errors
%         est.traj.epsi        precision-weighted prediction errors
%         est.traj.wt          full weights on prediction errors (at the first level,
%                                  this is the learning rate)
%
% Tips:
% - When analyzing a new dataset, take your inputs u and use
%
%   >> est = tapas_fitModel([], u, 'tapas_hgf_transition_volconst_config', 'tapas_bayes_optimal_transition_config');
%
%   to determine the Bayes optimal perceptual parameters (given your current priors as defined in
%   this file here, so choose them wide and loose to let the inputs influence the result). You can
%   then use the optimal parameters as your new prior means for the perceptual parameters.
%
% - If you get an error saying that the prior means are in a region where model assumptions are
%   violated, lower the prior means of the omegas, starting with the highest level and proceeding
%   downwards.
%
% - Alternatives are lowering the prior mean of kappa, if they are not fixed, or adjusting
%   the values of the kappas or omegas, if any of them are fixed.
%
% - If the log-model evidence cannot be calculated because the Hessian poses problems, look at
%   est.optim.H and fix the parameters that lead to NaNs.
%
% - Your guide to all these adjustments is the log-model evidence (LME). Whenever the LME increases
%   by at least 3 across datasets, the adjustment was a good idea and can be justified by just this:
%   the LME increased, so you had a better model.
%
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2013-2014 Christoph Mathys, TNU, UZH & ETHZ
% edited from tapas_hgf_whatworld.m, Lilian Weber 2015, TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.


% Config structure
c = struct;

% Model name
c.model = 'hgf_transition_volconst';

% Number of states
c.n_states = 7;

% Sufficient statistics of Gaussian parameter priors

% Initial mu2
c.mu2_0mu = repmat(tapas_logit(1/c.n_states,1),c.n_states);
c.mu2_0sa = zeros(c.n_states);

% Initial sigma2
c.logsa2_0mu = repmat(log(1),c.n_states);
c.logsa2_0sa = zeros(c.n_states);

% Omega
c.ommu =  -6;
c.omsa = 5^2;

%{
% True transition matrices (optional)
c.ttm = NaN(4,4,8);

c.ttm(:,:,1) = [
    0.05 0.05 0.05 0.85;...
    0.85 0.05 0.05 0.05;...
    0.05 0.85 0.05 0.05;...
    0.05 0.05 0.85 0.05;...
               ];

c.ttm(:,:,2) = [
    0.05 0.85 0.05 0.05;...
    0.05 0.05 0.85 0.05;...
    0.05 0.05 0.05 0.85;...
    0.85 0.05 0.05 0.05;...
               ];

c.ttm(:,:,3) = [
    0.05 0.85 0.25 0.25;...
    0.85 0.05 0.25 0.25;...
    0.05 0.05 0.25 0.25;...
    0.05 0.05 0.25 0.25;...
               ];

c.ttm(:,:,4) = [
    0.25 0.25 0.05 0.05;...
    0.25 0.25 0.05 0.05;...
    0.25 0.25 0.05 0.85;...
    0.25 0.25 0.85 0.05;...
               ];

c.ttm(:,:,5) = [
    0.70 0.70 0.70 0.70;...
    0.05 0.05 0.05 0.05;...
    0.20 0.20 0.20 0.20;...
    0.05 0.05 0.05 0.05;...
               ];

c.ttm(:,:,6) = [
    0.05 0.05 0.05 0.05;...
    0.70 0.70 0.70 0.70;...
    0.05 0.05 0.05 0.05;...
    0.20 0.20 0.20 0.20;...
               ];

c.ttm(:,:,7) = [
    0.05 0.05 0.05 0.05;...
    0.20 0.20 0.20 0.20;...
    0.70 0.70 0.70 0.70;...
    0.05 0.05 0.05 0.05;...
               ];

c.ttm(:,:,8) = [
    0.20 0.20 0.20 0.20;...
    0.05 0.05 0.05 0.05;...
    0.05 0.05 0.05 0.05;...
    0.70 0.70 0.70 0.70;...
               ];
%}

% Gather prior settings in vectors
c.priormus = [
    c.mu2_0mu(:)',...
    c.logsa2_0mu(:)',...
    c.ommu,...
             ];

c.priorsas = [
    c.mu2_0sa(:)',...
    c.logsa2_0sa(:)',...
    c.omsa,...
             ];

% Model function handle
c.prc_fun = @tapas_hgf_transition_volconst;

% Handle to function that transforms perceptual parameters to their native space
% from the space they are estimated in
c.transp_prc_fun = @tapas_hgf_transition_volconst_transp;

return;

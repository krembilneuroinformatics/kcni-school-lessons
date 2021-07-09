function sim = mmn_calculate_regressors( sim )
%mmn_CALCULATE_REGRESSORS Creates the trial-by-trial estimates of prediction error, precision, or
%surprise in the mmn study.
%   IN:     sim     - the struct that holds the simulated trajectories (from the HGF toolbox)
%   OUT:    sim     - the struct that additionally holds the regressors

% collect data
tones = sim.u_orig;
eps2 = squeeze(sim.traj.epsi(:, 2, :, :));
eps3 = squeeze(sim.traj.epsi(:, 3, :, :));

% calculate regressors
sim.reg.epsi2 = mmn_calculate_transitionPE(eps2, tones);
sim.reg.epsi3 = mmn_calculate_sumPE(eps3, tones);

end
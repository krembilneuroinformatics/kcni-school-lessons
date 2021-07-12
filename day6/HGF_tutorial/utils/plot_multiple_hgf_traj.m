function fh = plot_multiple_hgf_traj(all_models, parameter_name, parameter_array)
% Plots multiple HGF trajectories on top of each other. Adapted from: 
% tapas_hgf_binary_plotTraj(sim), see description of original function
% below.
%
% Plots the simimated or generated trajectories for the binary HGF perceptual model
% Usage example:  sim = tapas_fitModel(responses, inputs); tapas_hgf_binary_plotTraj(sim);
%
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2012-2013 Christoph Mathys, TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.



%% Options
n_models = length(all_models);
colors = winter(n_models);


%% Set up display
figure('units','normalized','outerposition',[0 0 .96 1],'Name', 'HGF trajectories');

% Time axis
t = ones(1, size(all_models{1}.u,1));
ts = cumsum(t);
ts = [0, ts];

% Number of levels
try
    l = all_models{1}.c_prc.n_levels;
catch
    l = 3;
end


%% Plot trajectories
for idx_model = 1:n_models
    sim = all_models{idx_model};
    
    % Upper levels
    for j = 1:l-1
        % Subplots
        subplot(l,1,j);
        hold all;
        plot(ts, [sim.p_prc.mu_0(l-j+1); sim.traj.mu(:,l-j+1)],...
            'Color', colors(idx_model,:), 'LineWidth', 2);
    end
    
    % Input level
    subplot(l,1,l);
    hold all;
    plot(ts, [tapas_sgm(sim.p_prc.mu_0(2), 1); tapas_sgm(sim.traj.mu(:,2), 1)],...
        'Color', colors(idx_model,:), 'LineWidth', 2);
end


%% Format titles
% Upper levels
for j = 1:l-1
    % Subplots
    subplot(l,1,j);
    xlim([0 ts(end)+1]);
    title(['Posterior expectation of x_' num2str(l-j+1)], 'FontWeight', 'bold');
    ylabel(['\mu_', num2str(l-j+1)]);
    
    if iscell(parameter_array)
        lh = legend(parameter_array,'Location','northeastoutside');
    else
        lh = legend(arrayfun(@num2str, parameter_array, 'UniformOutput', false),...
            'Location','northeastoutside');
    end
    title(lh, sprintf(parameter_name));
end

% Input level
subplot(l,1,l);
input = sim.u(:,1); % inputs
plot(ts(2:end), input, '.k','Markersize', 8);
if isfield(sim, 'y') % plot responses if there are responses
    for idx_model = 1:n_models
        sim = all_models{idx_model};
        sim.y(sim.y == 1) = sim.y(sim.y == 1)+idx_model*0.08;
        sim.y(sim.y == 0) = sim.y(sim.y == 0)-idx_model*0.08;
        plot(ts(2:end), sim.y, '.','Markersize', 8, 'Color', colors(idx_model,:));
    end
end
title(sprintf('Posterior expectation s(\\mu_2)'))
ylabel('u, s(\mu_2)');
xlabel('Trial number');
xlim([0 ts(end)+1]);
ylim([-0.07-n_models*0.08 1.07+n_models*0.08])
yticks([0:0.5:1])
if iscell(parameter_array)
    lh = legend(parameter_array,'Location','northeastoutside');
else
    lh = legend(arrayfun(@num2str, parameter_array, 'UniformOutput', false),...
        'Location','northeastoutside'); 
end
title(lh, sprintf(parameter_name));



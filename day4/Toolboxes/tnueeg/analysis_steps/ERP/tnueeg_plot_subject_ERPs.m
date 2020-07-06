function h = tnueeg_plot_subject_ERPs( D, chanlabel, triallist )
%TNUEEG_PLOT_SUBJECT_ERPS Plots all conditions of an (averaged) M/EEG data set
%   IN:     D           - (averaged) M/EEG data set
%           chanlabel   - label of the EEG channel to be plotted (currently only one)
%           trialliste  - cell array with nLines = nConditions; contains either only the triallabels
%           (as present in D) of the conditions to be plotted, or, in additional columns, the 
%           legendentry strings and RGB colors for plotting these.

%-- preparation -----------------------------------------------------------------------------------%
nTrials = size(triallist, 1);

switch size(triallist, 2)
    case 1
        triallabels = triallist;
        legendentries = triallist;
        cmap = colormap(colorcube);
        trialcolors = cmap(1: nTrials, :);
    case 2
        triallabels = {triallist{:, 1}};
        legendentries = {triallist{:, 2}};
        cmap = colormap(colorcube);
        trialcolors = cmap(1: nTrials, :);
    case 3
        triallabels = {triallist{:, 1}};
        legendentries = {triallist{:, 2}};
        trialcolors = {triallist{:, 3}};
end        
        
% time in ms for x-axis
timeAxisSEC = time(D);
timeAxis = timeAxisSEC*1000;

% channel to be plotted
indChan = indchannel(D, chanlabel);

%-- do the figure ---------------------------------------------------------------------------------%
h = figure; hold on;
grid on;

ylabel('Field intensity (in uV)');
xlabel('Time (ms after tone onset)');

for iTrial = 1: nTrials
    indTrial = indtrial(D, triallabels{iTrial});
    plot(timeAxis, D(indChan, :, indTrial), 'Color', trialcolors{iTrial}, 'LineWidth', 2);
end

legend(legendentries);




end


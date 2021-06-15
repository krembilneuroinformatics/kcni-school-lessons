function fh = tnueeg_diagnostics_effects_on_continuous_D(Dbefore, Dafter, channels, step)
%TNUEEG_DIAGNOSTICS_EFFECTS_ON_CONTINUOUS_D Plots data from selected 
%channels from two SPM EEG data sets side by side (e.g. before and after 
%filtering) to inspect the result of any processing steps on the data. 
%Includes a zoomed part of the first 5 seconds of the recording.
%	IN:     Dbefore     - M/EEG data set before processing step
%           Dafter      - M/EEG data set after processing step
%           channels    - cell array list of channel names to be plotted
%           name        - string containing the name of the processing step
%   OUT:    fh          - handle to the figure created
% Written by F.Petzschner
% 09. August. 2017
% Modified 09/08/2017 to be included in TNUEEG toolbox.

%-- preparation ----------------------------------------------------------%
% channel indices
nPlotRows = length(channels);
idxChannel = NaN(nPlotRows, 1);
for iChannel = 1:   nPlotRows
    idxChannel(iChannel) = indchannel(Dbefore, channels{iChannel});
    if isempty(idxChannel(iChannel))
        warning(['channel ' channels{iChannel} ' not found in object D']);
    end
end

% sample indices for time window to zoom into
windowSize = 5; % in s
idsWindowBefore = find(Dbefore.time < windowSize);
idsWindowAfter = find(Dafter.time < windowSize);
    

%-- start the plot -------------------------------------------------------%
fh = figure;
j = 1;

for iRow = 1: nPlotRows
    
    h(iRow, 1) = subplot(nPlotRows, 3, j);
    plot(Dbefore.time, Dbefore(idxChannel(iRow), :, 1), 'k');
    % ensure scaling is equal for both sides of the plot
    axis([min(Dbefore.time), max(Dbefore.time), ...
        min([min(Dafter(idxChannel(iRow), :, 1)), ...
            min(Dbefore(idxChannel(iRow), :, 1))]), ...
        max([max(Dafter(idxChannel(iRow), :, 1)), ...
            max(Dbefore(idxChannel(iRow), :, 1))])]);
    ylabel('EEG activity [\muV]');
    xlabel('Experiment time [s]');
        
    title(['Channel ' channels{iRow} ': Before ', step]);
    
    h(iRow,2) = subplot(nPlotRows, 3, j+1);
    plot(Dafter.time, Dafter(idxChannel(iRow), :, 1), 'k');
    % ensure scaling is equal for both sides of the plot
    axis([min(Dafter.time), max(Dafter.time), ...
        min([min(Dafter(idxChannel(iRow), :, 1)), ...
            min(Dbefore(idxChannel(iRow), :, 1))]), ...
        max([max(Dafter(idxChannel(iRow), :, 1)), ...
            max(Dbefore(idxChannel(iRow), :, 1))])]);
    title(['Channel ' channels{iRow} ': After ', step]);
    ylabel('EEG activity [\muV]');
    xlabel('Experiment time [s]');
    
    % zoom in on specified time window
    h(iRow,3) = subplot(nPlotRows, 3, j+2);
    plot(Dbefore.time(idsWindowBefore), ...
        Dbefore(idxChannel(iRow), idsWindowBefore,1), 'r');
    hold on;
    plot(Dafter.time(idsWindowAfter), ...
        Dafter(idxChannel(iRow), idsWindowAfter, 1))
    title(['Channel ' channels{iRow} ': Zoom ', step]);
    legend('before', 'after');
    ylabel('EEG activity [\muV]');
    xlabel('Experiment time [s]');
    
    j = j +3;
end

end
    
    
    
    

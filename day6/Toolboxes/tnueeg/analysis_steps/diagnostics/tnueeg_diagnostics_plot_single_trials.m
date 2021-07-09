function fh = tnueeg_diagnostics_plot_single_trials(D, channels, trials)
%TNUEEG_DIAGNOSTICS_PLOT_SINGLE_TRIALS Plots single tria data from selected channels from an SPM EEG
%data set to inspect the nature of these trials (e.g., eyeblink trials or bad trials). Creates
%separate plots for the sensors specified in channels and plots max. 10 trials into one figure. 
%	IN:     D           - M/EEG data set (epoched)
%           channels    - cell array list of channel names to be plotted
%           trials      - vector of trial indices to plot
%           step        - string containing the name of the processing step
%   OUT:    fh          - handle to the figure created

%-- preparation ----------------------------------------------------------%
% channel indices
nFigures = length(channels);
idxChannel = NaN(nFigures, 1);
for iChannel = 1:   nFigures
    idxChannel(iChannel) = indchannel(D, channels{iChannel});
    if isempty(idxChannel(iChannel))
        warning(['channel ' channels{iChannel} ' not found in object D']);
    end
end

% plot dimensions
nRows = 4;
nCols = 4;
nTrialsPerPlot = nRows*nCols;

nTrials = length(trials);
if nTrials > nTrialsPerPlot
    nPlots = max(floor(nTrials/nTrialsPerPlot), ceil(nTrials/nTrialsPerPlot));
else
    nPlots = 1;
end


%-- start the plot -------------------------------------------------------%
for iFigure = 1: nFigures
    t = 1;
    for iPlot = 1: nPlots
        fh(iFigure, iPlot) = figure;
        j = 1;
        while j <= nTrialsPerPlot && t <= nTrials
            subplot(nRows, nCols, j);
            hold on;
            plot(D.time, D(idxChannel(iFigure), :, trials(t)));
            plot([D.time(1) D.time(end)], [0 0], '-k');
            
            xlim([D.time(1) D.time(end)]);

            title(['Channel ' channels{iFigure} ' in trial ' num2str(trials(t))]);
            
            t = (iPlot -1)*nTrialsPerPlot + j + 1;
            j = j+1;
        end
    end
end

end
    
    
    
    

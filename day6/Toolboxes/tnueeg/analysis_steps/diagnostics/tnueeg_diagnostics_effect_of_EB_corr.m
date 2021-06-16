function fh = tnueeg_diagnostics_effect_of_EB_corr(Dbefore, Dafter, channels, trials)
%TNUEEG_DIAGNOSTICS_EFFECT_OF_EB_CORR Plots data from selected channels and
%trials from two SPM EEG data sets (before and after EB correction) side by
%side to inspect the result of the EB correction step on the data.
%   Channels should be those most sensitive to eye blinks, i.e., the
%   frontal channels (such as Fp1, Fp2, AF3, AF4, etc.). Trials should be
%   trials in which there was blink acitivity in the EOG channel (to be
%   determined by inspection).
%	IN:     Dbefore     - M/EEG data set before processing step
%           Dafter      - M/EEG data set after processing step
%           channels    - cell array list of channel names to be plotted
%           trials      - string containing the name of the processing step
%   OUT:    fh          - handle to the figure created

%-- preparation ----------------------------------------------------------%
% channel indices
channels{end+1} = 'EOG';
nPlotRows = length(channels);
idxChannel = NaN(nPlotRows, 1);
for iChannel = 1:   nPlotRows
    idxChannel(iChannel) = find(strcmp(channels{iChannel}, ...
        chanlabels(Dbefore)));
    if isempty(idxChannel(iChannel))
        warning(['channel ' channels{iChannel} ' not found in object D']);
    end
end

nTrials = numel(trials);
scrsz = get(0, 'Screensize');
yDim = scrsz(4);
xDim = scrsz(3)/2;

%-- plot -----------------------------------------------------------------%
for iTrial = 1: nTrials
    fh(iTrial) = figure;
    fh(iTrial).Position = [0 yDim xDim yDim];
    
    j = 1;
    for iRow = 1: nPlotRows 

        h(iRow, 1) = subplot(nPlotRows, 2, j);
        plot(Dbefore.time, ...
            Dbefore(idxChannel(iRow), :, trials(iTrial)), 'k', 'LineWidth', 2);
        
        title([channels{iRow} ...
            ' in Trial ' num2str(trials(iTrial)) ...
            ': Before EB correction']);

        h(iRow, 2) = subplot(nPlotRows, 2, j+1);
        plot(Dafter.time, ...
            Dafter(idxChannel(iRow), :, trials(iTrial)), 'b', 'LineWidth', 2);
        
        title([channels{iRow} ...
            ' in Trial ' num2str(trials(iTrial)) ...
            ': After EB correction']);
        
        % ensure scaling is equal for both sides of the plot
        axis(h(iRow, 1:2), [min(Dafter.time), max(Dafter.time), ...
            min([min(Dafter(idxChannel(iRow), :, trials(iTrial))), ...
                min(Dbefore(idxChannel(iRow), :, trials(iTrial)))])-5, ...
            max([max(Dafter(idxChannel(iRow), :, trials(iTrial))), ...
                max(Dbefore(idxChannel(iRow), :, trials(iTrial)))])+5]);
            
        %linkaxes(h(iRow, 1:2), 'xy');

        j = j +2;
    end
    
end
    
    
    
    

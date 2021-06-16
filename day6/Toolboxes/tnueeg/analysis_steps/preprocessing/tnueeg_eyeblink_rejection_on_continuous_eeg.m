function [ varargout ] = tnueeg_eyeblink_rejection_on_continuous_eeg( D, trialdef, options )
%TNUEEG_REMOVE_EYEBLINK_TRIALS Excludes experimental trials due to overlap with eye blink events.
%   IN:     D               - continuous M/EEG data set
%           trialdef        - struct with field 'times' containing the times of exp. events (trials)
%                           OR: with fields 'labels', 'types' and 'values' for each condition
%           options         - the struct that holds all analysis options
%   OUT:    EITHER (if eventbased rejection):
%           Dc              - updated EEG data set without EB trial events
%           eventsExcluded  - struct with indices of rejected trials in the D object 
%           OR (if timebased rejection):
%           trialdef        - updated trial definition struct without EB trials
%           IN ANY CASE:
%           nExcluded       - number of excluded trials (all; and per condition)
%           idxExcluded     - struct with indices of rejected trials within conditions
%           nTrials         - struct with number of remaining trials per condition
%           fh              - handle to diagnostics (blink-trial-overlap) figure after exclusion
%           nTrialsInitial  - struct with number of initial trials per condition

%-- preparation -----------------------------------------------------------------------------------%
areaColor       = [0.53 0.81 0.98];
rejectionMode   = options.preproc.eyeblinkmode;     % 'eventbased', 'timebased', 
EBwindow        = options.preproc.eyeblinkwindow;
ERPlength       = options.preproc.epochwin(2)/1000; % end of ERP window in s
ERPoffset       = options.preproc.eyeblinktrialoffset; % in s: window to discard at beg. of trial
EOGchannel      = options.preproc.eyeblinkEOGchannel; % EOG channel (name/idx) to plot
if isfield(options.preproc, 'eyeblinkEEGchannel')
    EEGchannel  = options.preproc.eyeblinkEEGchannel; % EEG channel (name/idx) to plot
else
    EEGchannel  = 'none';
end
nExcluded.all       = 0;
nTrialsInitial.all  = 0;

%-- experimental events ---------------------------------------------------------------------------%
EEGevents = events(D);

switch rejectionMode
    case 'eventbased'
        % in this case, we have to find the event times per condition first
        eventRejection              = true;
        allExcludedTrialEventIds    = [];

        % go through all experimental conditions/trialtypes
        conditions      = unique(trialdef.labels);
        for iCond       = 1: numel(conditions)
            condLabel   = conditions{iCond};
            condIndex   = find(strcmp(trialdef.labels, condLabel));
            condValues  = trialdef.values(condIndex);
            numericValues = isnumeric(condValues);
            % condValues = sprintfc('%d', condValues);
            
            % go through all trial values and collect trial times & event indices for this condition
            condTrialIndices    = [];
            condTrialTimes      = [];
            for iVal                = 1: numel(condValues)
                idxValueEvents = ...
                    tnueeg_find_indices_of_value_in_mixed_cell_array(...
                    {EEGevents.value}, condValues(iVal));
                condTrialIndices    = [condTrialIndices idxValueEvents];
                condTrialTimes      = [condTrialTimes EEGevents(idxValueEvents).time];
            end

            % sort indices according to their appearance within the experiment (i.e., according to
            % trial time) to have consistent within-condition ordering
            [condTrialTimes, sortIdx] = sort(condTrialTimes);
            condTrialIndices = condTrialIndices(sortIdx);            
            
            % update temporary trialdefinition
            tmptrialdef.labels{iCond}   = condLabel;
            tmptrialdef.types{iCond}    = 'Stimulus';
            tmptrialdef.times{iCond}    = condTrialTimes;
            tmptrialdef.indices{iCond}  = condTrialIndices;     
        end


    case 'timebased'        
        if ~isfield(trialdef, 'times')
            error(['In time-based EB rejection, the times of the experimental events need to ' ...
                'be defined in the trialdef. Consider using event-based mode.']);
        end
        eventRejection = false;
        tmptrialdef    = trialdef; 
end

%-- eye blink events ------------------------------------------------------------------------------%
idxEyeblinks    = find(strcmp({EEGevents.type}, 'artefact_eyeblink'));
if isempty(idxEyeblinks)
    error(['No eyeblink artefacts have been marked in the EEG data set. ' ...
           'Run eyeblink detection first!']);
else
    fprintf('Checking %d eyeblink events for overlap with experimental trials...\n', ...
        numel(idxEyeblinks));
end
EBtimes         = [EEGevents(idxEyeblinks).time];

%-- exclude artefactual trials within all conditions ----------------------------------------------%
for iCond       = 1: numel(tmptrialdef.labels)
    condLabel   = tmptrialdef.labels{iCond};
    trialTimes  = tmptrialdef.times{iCond};
    if eventRejection
        trialEventIndices = tmptrialdef.indices{iCond};
    end

    %-- exclude overlapping trials ----------------------------------------------------------------%
    excludedTrialTimes          = [];
    excludedTrialIds            = [];
    if eventRejection
    	excludedTrialEventIds   = [];
    end
    
    % go through all Trials
    for iTrial = 1: numel(trialTimes)
        % go through all EBs
        for iEB = 1: numel(EBtimes)
            EBstart = EBtimes(iEB) - EBwindow/2;
            EBstop  = EBtimes(iEB) + EBwindow/2;
            trialStart = trialTimes(iTrial) + ERPoffset;
            trialStop  = trialTimes(iTrial) + ERPlength;
            % check whether current EB is problematic for current Trial
            if      isEventInWindow(trialStart, EBstart, EBstop) ...
                ||  isEventInWindow(trialStop, EBstart, EBstop) ...
                ||  isEventInWindow(EBtimes(iEB), trialStart, trialStop) 
                % if any of these applies, add the current Trial to the list of excluded Trials
                excludedTrialTimes = [excludedTrialTimes trialTimes(iTrial)];
                excludedTrialIds   = [excludedTrialIds iTrial];
                if eventRejection
                    excludedTrialEventIds = [excludedTrialEventIds trialEventIndices(iTrial)];
                end
            end
        end    
    end
    % remove double listings
    excludedTrialTimes = unique(excludedTrialTimes); % currently, these are not used for anything
    excludedTrialIds   = unique(excludedTrialIds);
    if eventRejection
        excludedTrialEventIds       = unique(excludedTrialEventIds);
        allExcludedTrialEventIds    = [allExcludedTrialEventIds excludedTrialEventIds];
    end
    
    %-- remove these trials from the list and count them ------------------------------------------%
    excludedTimes{iCond}        = excludedTrialTimes;
    trialTimes(excludedTrialIds)= [];
    tmptrialdef.times{iCond}    = trialTimes;
    nTrials.(condLabel)         = numel(trialTimes);
    
    idxExcluded.(condLabel)     = excludedTrialIds;
    nExcluded.(condLabel)       = numel(excludedTrialIds);
    eventsExcluded.(condLabel)  = excludedTrialEventIds;
    disp(['Excluding ' num2str(nExcluded.(condLabel)) ' trials due to eye blinks in condition ' ...
        condLabel '.']);
    nExcluded.all = nExcluded.all + nExcluded.(condLabel);
    
    nTrialsInitial.(condLabel)  = nTrials.(condLabel) + nExcluded.(condLabel);
    nTrialsInitial.all          = nTrialsInitial.all + nTrialsInitial.(condLabel);
    
end

if eventRejection
    eventsExcluded.all = allExcludedTrialEventIds;
    EEGevents(eventsExcluded.all) = [];
    Dc = events(D, 1, EEGevents);
    varargout{1} = Dc;
    varargout{2} = eventsExcluded;
elseif timeRejection
    trialdef = tmptrialdef;
    varargout{1} = trialdef;
end

varargout{end+1} = nExcluded;
varargout{end+1} = idxExcluded;
varargout{end+1} = nTrials;

%-- plot for diagnostics --------------------------------------------------------------------------%
trialonsets.original    = [tmptrialdef.times{:}];
trialonsets.excluded    = [excludedTimes{:}];
trialsamples.original   = indsample(D, trialonsets.original);
trialsamples.excluded   = indsample(D, trialonsets.excluded);
fh                      = tnueeg_plot_trial_and_EB_overlap(D, trialonsets, trialsamples, ...
                            EBtimes, EBwindow, EEGchannel, EOGchannel, areaColor);

varargout{end+1} = fh;    
varargout{end+1} = nTrialsInitial;
end


function fh = tnueeg_plot_trial_and_EB_overlap(D, trialTimes, smpTrials, EBtimes, EBwindow, ...
                                                EEGchannel, EOGchannel, rangeColor)
%TNUEEG_PLOT_TRIAL_AND_EB_OVERLAP Diagnostics plot for Eye blink artefacts rejection.
%   Plots an EEG channel with the experimental trial times along with the EOG signal and marks the 
%   critical periods around each detected eye blink.
%   IN:     D               - continuous M/EEG data set
%           trialTimes      - struct with onset times of experimental trials (.original, .excluded)
%           smpTrials       - struct with sample indices of experimental trials (.original, .excluded)
%           EBtimes         - peak times of detected eye blinks
%           EBwindow        - length of time window around each EB
%           EEGchannel      - name (string) or index (numeric) of EEG channel to plot
%           EOGchannel      - name (string) or index (numeric) of EOG channel to plot
%           rangeColor      - color with which to mark the periods around each EB
%   OUT:    fh              - handle to the figure

fh = figure; hold on;

%-- preparation: channel names and indices --------------------------------------------------------%
chanNames = chanlabels(D);

if isempty(EEGchannel) || strcmpi(EEGchannel, 'none')
    doEEGchannelplot = false;
else
    if isnumeric(EEGchannel)
        EEGname = chanNames{EEGchannel};
    else
        EEGname     = EEGchannel;
        EEGchannel  = indchannel(D, EEGname);
    end
    doEEGchannelplot = true;
end

if ~isnumeric(EOGchannel)
    EOGchannel  = indchannel(D, EOGchannel);
end

%-- mark the areas around each eye blink ----------------------------------------------------------%
try % this works if the FaceAlpha property is defined for the area plot (depends on Matlab version)
    for iEye = 1: numel(EBtimes)
        area([EBtimes(iEye)-EBwindow/2 EBtimes(iEye)+EBwindow/2], ...
            [1 1], 0, 'FaceColor', rangeColor, ...
            'FaceAlpha', 0.5, 'LineStyle', 'none');
        area([EBtimes(iEye)-EBwindow/2 EBtimes(iEye)+EBwindow/2], ...
            [-1 -1], 0, 'FaceColor', rangeColor, ...
            'FaceAlpha', 0.5, 'LineStyle', 'none');
    end
catch % in case there is no FaceAlpha property, we just put the area in the background
    for iEye = 1: numel(EBtimes)
        area([EBtimes(iEye)-EBwindow/2 EBtimes(iEye)+EBwindow/2], ...
            [1 1], 0, 'FaceColor', rangeColor, ...
             'LineStyle', 'none');
        area([EBtimes(iEye)-EBwindow/2 EBtimes(iEye)+EBwindow/2], ...
            [-1 -1], 0, 'FaceColor', rangeColor, ...
            'LineStyle', 'none');
    end
end

%-- EEG and experimental events -------------------------------------------------------------------%
if doEEGchannelplot
    eeg     = plot(D.time, D(EEGchannel, :, :)/max(squeeze(D(EEGchannel, :, :))), '-b');
    trials1  = stem(trialTimes.original, ...
                D(EEGchannel, smpTrials.original, :)/max(squeeze(D(EEGchannel, :, :))), ...
                'g', 'LineWidth', 2);
    trials2  = stem(trialTimes.excluded, ...
                D(EEGchannel, smpTrials.excluded, :)/max(squeeze(D(EEGchannel, :, :))), ...
                'r', 'LineWidth', 2);
else
    trials1  = stem(trialTimes.original, ones(numel(trialTimes.original), 1), 'g', 'LineWidth', 2);
    trials2  = stem(trialTimes.excluded, ones(numel(trialTimes.excluded), 1), 'r', 'LineWidth', 2);
end
%-- EOG -------------------------------------------------------------------------------------------%
eog = plot(D.time, -D(EOGchannel, :, :)/max(squeeze(-D(EOGchannel, :, :))), '-y', 'LineWidth', 2);

%-- Legend ----------------------------------------------------------------------------------------%
if doEEGchannelplot
    legend([eeg trials1 trials2 eog], {['Signal at ' EEGname ' (a.u.)'], ...
        'Trial onsets: good', 'Trial onsets: excluded', 'Signal at EOG (a.u.)'});
else
    legend([trials1 trials2 eog], ...
        {'Trial onsets: good', 'Trial onsets: excluded', 'Signal at EOG (a.u.)'});
end

end


function answer = isEventInWindow(eventTime, windowStart, windowStop)
%ISEVENTINWINDOW Returns true if eventTime lies in between windowStart and windowStop.
%   IN:     eventTime   - time of the event (in the same time format as the other inputs)
%           windowStart - start time of time window (in the same time format as the other inputs)
%           windowStop  - end time of time window (in the same time format as the other inputs)
%   OUT:    answer      - true if event lies in the time window, false otherwise

answer = (eventTime >= windowStart && eventTime <= windowStop);

end


function evt = tnueeg_find_eeg_trigger_event_times(D, options)
%TNUEEG_FIND_EEG_TRIGGER_EVENT_TIMES Finds EEG events based on trigger 
%names for trial definition
%   IN:     D           - M/EEG data set
%           options     - struct that holds all analysis options
%   OUT:    evt         - struct that holds all event times based on the
%                       trigger names defined in details

% -- EEG events ----------------------------------------------------------%
eegEvents       = events(D);
evt.eegTime     = time(D);
allOnsetTimes   = [];

% loop through all events as defined in options.preproc.triggerValues
for iEventtype = 1: numel(options.preproc.triggerValues)
    % find all EEG events with this value
    idxEvent        = find(strcmp({eegEvents.value}, ...
                    options.preproc.triggerValues(iEventtype)));
    % get all onset times of that event
    onsetTimes      = [eegEvents(idxEvent).time];
    % save all times for later
    allOnsetTimes   = [allOnsetTimes onsetTimes];
    % what is the event name
    nameEvent       = options.preproc.triggerNames{iEventtype};
    % save in new event struct
    evt.(nameEvent) = onsetTimes;
end

% consider only data between first relevant block start trigger and last 
% relevant block end trigger
evt.eegStart    = min(allOnsetTimes);
evt.eegEnd      = max(allOnsetTimes);

end



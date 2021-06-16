function D = tnueeg_heartbeats_mark_heartbeat_events(D, trialdef)
%TNUEEG_HEARTBEATS_MARK_HEARTBEAT_EVENTS Marks every detected heartbeat as an event in the EEG data 
%set, given the time of the event in EEG time (peakTimes) and event type and value strings (all 
%these must be stored in trialdef).
%   IN:     D           - M/EEG data set
%           trialdef    - trialdefinition struct containing type and value strings and the vector of
%                       onset times of heartbeat events
%   OUT:    D           - M/EEG data set with HB events (e.g. for epoching)

triggers = events(D);
isNumericValues = isnumeric(trialdef.values);

% go through all trial types / conditions
for iCon = 1: numel(trialdef.types)
    % go through all events of one trial type / condition and add to the trigger event list
    for ev = 1: length(trialdef.times{iCon})
        triggers(end+1).type    = trialdef.types{iCon};
        triggers(end).time      = trialdef.times{iCon}(ev);
        triggers(end).duration  = 1;
        triggers(end).offset    = 0;
        if isNumericValues
            triggers(end).value = trialdef.values(iCon);
        else
            triggers(end).value = trialdef.values{iCon};
        end
    end
end

D = events(D, 1, triggers);

end

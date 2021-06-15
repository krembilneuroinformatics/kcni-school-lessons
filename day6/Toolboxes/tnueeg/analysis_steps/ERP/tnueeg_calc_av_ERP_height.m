function [ERPh] = tnueeg_calc_av_ERP_height(D, elec, window)
%TNUEEG_CALC_AV_ERPHEIGHT Calculates the average ERP Height of one subject
% and condition within an specified time window and at a specified electrode 
%   IN:     D           - m/eeg struct after epoching
%           elec        - list of electrodes of interest named, e.g. {'Fz', FCz'}
%           window      - time window of interest [starttime, endtime]

timeAxisSEC = time(D); 
timeAxis = timeAxisSEC*1000; % time in ms for x-axis

for iElec = 1: length(elec) % in case we average over multiple electrodes
    elecpos(iElec) = find(strcmp(chanlabels(D),elec(iElec))); % electrode number
end

% average over window and electrode
for iCon = 1: length(conditions(D))
    idxTime = [find(timeAxis>window(1),1): find(timeAxis>window(2),1)];
    ERPh.data(iCon) = mean(mean(D(elecpos,idxTime,iCon)));
    ERPh.name(iCon) = conditions(D,iCon);
end

ERPh.window = window;
ERPh.elec = elec;

end
function [ D ] = tnueeg_average( D, avgopt )
%TNUEEG_AVERAGE Averages all trials of the conditions in data set D
%   IN:     D           - preprocessed data set with correct condition labels
%           avgopt      - string option whether to use robust or standard averaging
%   OUT:    D           - averaged data set (number of trials now equals
%                       the number of conditions

S.D = D;
S.prefix = 'm';

% for backward compatibility
if isstruct(avgopt)
    avgopt = avgopt.erp.averaging;
end

switch avgopt
    case {'r', 'robust'}
        S.robust.ks = 3;
        S.robust.bycondition = true;
        S.robust.savew = true;
        S.robust.removebad = false;
    case {'s', 'standard'}
        S.robust = 0;
end

D = spm_eeg_average(S);

end
function D = tnueeg_redefine_conditions( D, condlist )
%TNUEEG_REDEFINE_CONDITIONS Updates the condition list before averaging
%   IN:     D           - preprocessed data set
%           condlist    - list with new condition names
%   OUT:    D           - data set with new conditions

if isempty(condlist)
    % do nothing, i.e., keep conditions in D as they are
else
    nTrials = numel(condlist);
    if numel(D.conditions) ~= nTrials
        error(['Unequal number of trials for subject ' id]);
    end
    D = conditions(D, 1: nTrials, condlist);
end

disp(['Redefined ' num2str(numel(D.conditions)) ' trials in current data set.']);

end


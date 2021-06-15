function ga = tnueeg_grandmean_with_error(erpfiles, electrode, keepdata)
%TNUEEG_GRANDMEAN_WITH_ERROR Computes the mean, standard deviation and
%standard error of the mean of multiple ERPs in one electrode.
%   The function computes grand averages (and variance estimates) for all
%   conditions/trials present in the input EEG data sets. Input data sets
%   must be equivalent in terms of the number of conditions/trials, the
%   number of samples per trial, and the condition/trial order. 
%   IN:     erpfiles    - cell array of size nFiles containing the
%                       filenames and paths of the input EEG files
%           electrode   - electrode label (string)
%           keepdata    - if 1/yes (default), all data from which the mean
%                       was computed, will be kept in the output variable
%   OUT:    ga          - grand average struct with a field per
%                       condition/trial and subfields containing the mean
%                       and variance estimates

numSubjects = numel(erpfiles);
D = spm_eeg_load(erpfiles{1});

% collect information on dimensions, using the first file
conlist = condlist(D);
numConditions = numel(conlist);
numSamples = nsamples(D);
ga.time = time(D).*1000;
ga.electrode = electrode;

% loop over all conditions present in the EEG files
for iCon = 1: numConditions
    conlabel = char(conlist{iCon});
    
    % get the data to be averaged
    data = NaN(numSubjects, numSamples);
    for iSub = 1: numSubjects
        D = spm_eeg_load(erpfiles{iSub});
        
        indEl = indchannel(D, electrode);
        data(iSub, :) = squeeze(D(indEl, :, iCon));
    end
    
    % do the actual averaging
    ga.(conlabel).mean = mean(data);
    ga.(conlabel).sd = std(data);
    ga.(conlabel).error = std(data)/sqrt(numSubjects);
    
    if keepdata
        ga.(conlabel).data = data;
    end
    
end

end

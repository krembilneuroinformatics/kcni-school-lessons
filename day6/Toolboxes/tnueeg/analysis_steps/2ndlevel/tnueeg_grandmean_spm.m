function D = tnueeg_grandmean_spm(erpfiles, gafilename)
%TNUEEG_GRANDMEAN_SPM Applies the SPM function to computes the mean of 
%multiple ERPs in all electrodes. Does NOT compute variance estimates.
%   The function computes grand averages for all electrodes and all
%   conditions/trials present in the input EEG data sets. Input data sets
%   must be equivalent in terms of the number of conditions/trials, the
%   number of samples per trial, condition/trial order, and number of 
%   electrodes. 
%   IN:     erpfiles    - cell array of size nFiles containing the
%                       filenames and paths of the input EEG files
%           gafilename  - name for the output grand average (GA) file
%   OUT:    D           - EEG data struct containing the average across
%                       input data sets, the file will be saved in the same
%                       directory as first input file.

S.D = char(erpfiles);
S.weighted = 0;
S.outfile = gafilename;

D = spm_eeg_grandmean(S);

end

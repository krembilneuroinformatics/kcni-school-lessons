function [ D ] = tnueeg_contrast_over_epochs( D, contrasts, condlabels, options )
%TNUEEG_CONTRAST_OVER_EPOCHS Computes contrasts over conditions in data
%set D
%   IN:     D           - preprocessed, averaged data set
%           contrasts   - vector of size nContrasts x nConditions,
%                       containing the condition weights for each contrast
%           condlabels  - cell array of size nContrasts x 1 containing
%                       labels of newly computed conditions
%           options     - the struct that holds all analysis options
%   OUT:    D           - averaged data set (number of trials now equals
%                       the number of conditions


S.D         = D;
S.c         = contrasts;
S.label     = condlabels;
S.weighted  = options.erp.contrastWeighting;
S.prefix    = options.erp.contrastPrefix;

D = spm_eeg_contrast(S);

end
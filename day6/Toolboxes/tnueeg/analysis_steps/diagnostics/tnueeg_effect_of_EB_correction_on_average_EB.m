function [Dbefore, Dafter] = tnueeg_effect_of_EB_correction_on_average_EB( Dinit, Dconf, options)
%TNUEEG_EFFECT_OF_EB_CORRECTION_ON_AVERAGE_EB Calculates the average eyeblink epoch before and after
%EB correction method was applied.
%   IN:     id          - subject identifier string, e.g. '001'
%           options     - the struct that holds all analysis options
%   OUT:    -

if ischar(Dinit)
    Dinit   = spm_eeg_load(fullfile(Dinit)); 
end
Dbefore = tnueeg_average(Dinit, 's');

Dcorr   = tnueeg_correct_epoched_EB(Dinit, Dconf, options);
Dafter  = tnueeg_average(Dcorr, 's');

end



trials = 1;

fh = dmpad_tnueeg_diagnostics_effect_of_EB_corr(Dbefore, Dafter, channels, trials);
if nargin > 2 && ~isempty(ebFigure)
    saveas(fh, ebFigureFile, 'fig');
end
close(fh)
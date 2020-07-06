function [ fhMask ] = tnueeg_check_mask_image(pathToStatsFolder, maskFigure)
%TNUEEG_CHECK_MASK_IMAGE Plots the mask image located in the specified directory and saves the plot
%to the specified figure file name.
%   IN:     pathToStatsFolder   - path to the SPM.mat
%           maskFigure          - full file name (including path) for saving the resulting plot
%   OUT:    -

spm_check_registration(fullfile(pathToStatsFolder, 'mask.nii'));
fhMask = gcf;
if nargin > 1 && ~isempty(maskFigure)
    saveas(fhMask, maskFigure, 'fig');
end
close(fhMask);

end
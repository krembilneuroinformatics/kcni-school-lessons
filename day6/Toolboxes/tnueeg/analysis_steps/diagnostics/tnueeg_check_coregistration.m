function [ fhMesh, fhData ] = tnueeg_check_coregistration(dataFile, meshFigure, dataFigure)
%TNUEEG_CHECK_COREGISTRATION Plots the mesh and data coregistration (EEG space to sMRI space via
%fiducial locations) and saves the plots to the specified figure file names.
%   IN:     dataFile                - full file name (including path) to EEG data set with coreg
%           meshFigure, dataFigure  - full file names (including paths) for saving the resulting
%           plots
%   OUT:    -

D = spm_eeg_load(dataFile);

% check the mesh
spm_eeg_inv_checkmeshes(D);
fhMesh = gcf;
if nargin > 1 && ~isempty(meshFigure)
    saveas(fhMesh, meshFigure, 'fig');
end
close(fhMesh);

% check the data
spm_eeg_inv_checkdatareg(D, 1, 1);
fhData = gcf;
if nargin > 2 && ~isempty(dataFigure)
saveas(fhData, dataFigure, 'fig');
close(fhData);

end
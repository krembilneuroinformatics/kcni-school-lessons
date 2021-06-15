function [ D ] = tnueeg_project_to_2D( D )
%TNUEEG_PROJECT_TO_2D Projects 3D channel locations onto a 2D plane
%   This function uses the 3D location information (x, y, z) about sensors 
%   in an EEG data set to project the channel locations onto a 2D plane 
%   (x, y direction remaining). 3rd dimension will then become within-trial
%   time.
%   IN:     D       - EEG data set with 3D sensor location information
%   OUT:    D       - EEG data set with a 2D plane projection of sensors

S = [];

S.D = D;
S.task = 'project3d';
S.modality = 'EEG';
S.save = 1;

D = spm_eeg_prep(S);

end


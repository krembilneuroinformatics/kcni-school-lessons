function [ D ] = tnueeg_transform_sensor_locations( D, fidFile )
%TNUEEG_TRANSFORM_SENSOR_LOCATIONS Transforms sensor locations into MRI space
%   IN:     D       - EEG data set with original sensor locations
%           fidFile - file with fiducial locations in MRI space
%   OUT:    D       - EEG data set with transformed sensor locations

% current sensor locations
elec = sensors(D, 'EEG');
% current fiducials
oldFid = D.fiducials;

% new fiducials - from sMRI
newFid = getfield(load(fidFile), 'fid');

% coordinate transformation matrix
M = tnueeg_spm_eeg_inv_headcoordinates(...
    newFid.data(1, :), newFid.data(2, :), newFid.data(3, :));

% transform electrode coords
elec = ft_transform_sens(inv(M), elec);
% transform fiducials coords
eegfid = ft_transform_headshape(inv(M), oldFid);

% replace old with new fiducials
eegfid.fid.pnt = newFid.data;
eegfid.fid.label = newFid.labels;

% replace electrode positions in D 
D = sensors(D, 'EEG', elec);
% replace fid locations in D
D = fiducials(D, eegfid);

end    
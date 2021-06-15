function [ D ] = tnueeg_sensor_locations( D, elecFile )
%TNUEEG_SENSOR_LOCATIONS Loads a file indicating the locations of channels
%in 3D space
%   IN:     D           - EEG data set
%           elecFile    - filename of the sensor locations file incl. path
%   OUT:    D           - EEG data set with 3D sensor location information

S = [];

S.D = D;
S.task = 'loadeegsens';
S.source = 'locfile';
S.sensfile = elecFile;
S.save = 1;

D = spm_eeg_prep(S);


end


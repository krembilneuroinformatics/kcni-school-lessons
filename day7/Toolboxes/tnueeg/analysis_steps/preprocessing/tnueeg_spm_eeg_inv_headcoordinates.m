function M1 = tnueeg_spm_eeg_inv_headcoordinates(nas, lpa, rpa)
%TNUEEG_SPM_EEG_INV_HEADCOORDINATES
% Returns the homogenous coordinate transformation matrix
% that converts the specified fiducials in any coordinate system (e.g. MRI)
% into the rotated and translated headccordinate system.
%
% M1 = headcoordinates(nas, lpa, rpa)
%
% The headcoordinate system in CTF is defined as follows:
% the origin is exactly between lpa and rpa
% the X-axis goes towards nas
% the Y-axis goes approximately towards lpa, orthogonal to X and in the plane spanned by the fiducials
% the Z-axis goes approximately towards the vertex, orthogonal to X and Y 
%_______________________________________________________________________
% Copyright (C) 2003 Robert Oostenveld

% Robert Oostenveld
% $Id: spm_eeg_inv_headcoordinates.m 3589 2009-11-20 17:17:41Z guillaume $

% modified 2016-06-08 Lilian Weber for TNU electrode digitization
% Our headcoordinate system in is defined as follows:
% the origin is exactly between lpa and rpa
% the Y-axis goes towards nas
% the X-axis goes approximately towards rpa, orthogonal to Y and in the plane spanned by the fiducials
% the Z-axis goes approximately towards the vertex, orthogonal to X and Y 

% ensure that they are row vectors
lpa = lpa(:)';
rpa = rpa(:)';
nas = nas(:)';

% compute the origin and direction of the coordinate axes in MRI coordinates

% follow CTF convention - mod LW: follow our own convention (exchange x and
% y and revert x-axis.
origin = [lpa+rpa]/2;
diry = nas-origin;
diry = diry/norm(diry);
dirz = cross(diry,lpa-rpa);
dirz = dirz/norm(dirz);
dirx = cross(diry,dirz); % mod LW, was: dirx = cross(dirz,diry)

% compute the rotation matrix
rot = eye(4);
rot(1:3,1:3) = inv(eye(3) / [dirx; diry; dirz]);
% compute the translation matrix
tra = eye(4);
tra(1:4,4)   = [-origin(:); 1];
% compute the full homogenous transformation matrix from these two
M1 = rot * tra;

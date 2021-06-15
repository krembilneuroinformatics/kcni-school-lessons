function [ job ] = mmn_headmodel_job( D,fid )
%MMN_HEADMODEL_JOB Defines a job to run a headmodel for an EEG data set
%   The job will be filled with options and can then be run using the
%   spm_jobman.
%   IN:     D       - EEG data set
%           fid     - fiducial IDs
%   OUT:    job     - the job to pass to the spm_jobman

job{1}.spm.meeg.source.headmodel.D = {fullfile(D)};
job{1}.spm.meeg.source.headmodel.val = 1;
job{1}.spm.meeg.source.headmodel.comment = '';

job{1}.spm.meeg.source.headmodel.meshing.meshes.template = 1;
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).fidname = 'spmnas';
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).fidname = 'spmlpa';
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).fidname = 'spmrpa';


job{1}.spm.meeg.source.headmodel.meshing.meshres = 2;

job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).specification.type = fid.pnt(1, :);
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).specification.type = fid.pnt(2, :);
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).specification.type = fid.pnt(3, :);
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.useheadshape = 1;

job{1}.spm.meeg.source.headmodel.forward.eeg = 'EEG BEM';
job{1}.spm.meeg.source.headmodel.forward.meg = 'Single Sphere';

end


function [ job ] = tnueeg_headmodel_job( D, fid, details, options )
%TNUEEG_HEADMODEL_JOB Defines a job to run a headmodel for an EEG data set
%   The job will be filled with options and can then be run using the
%   spm_jobman.
%   IN:     D       - EEG data set
%           fid     - a struct containing the locations of the fiducials
%           details - the struct that holds all paths and filenames
%           options - the struct that holds all analysis options
%   OUT:    job     - the job to pass to the spm_jobman

job{1}.spm.meeg.source.headmodel.D = {fullfile(D)};
job{1}.spm.meeg.source.headmodel.val = 1;
job{1}.spm.meeg.source.headmodel.comment = '';

switch options.preproc.mrifile
    case 'template'
        job{1}.spm.meeg.source.headmodel.meshing.meshes.template = 1;
        job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).fidname = 'spmnas';
        job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).fidname = 'spmlpa';
        job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).fidname = 'spmrpa';

    case 'subject'
        if exist(details.mrifile, 'file')
            job{1}.spm.meeg.source.headmodel.meshing.meshes.mri = {details.mrifile};
            job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).fidname = 'NAS';
            job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).fidname = 'LPA';
            job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).fidname = 'RPA';
        else
            warning('Could not locate subject-specific MRI file. Using template!');
            job{1}.spm.meeg.source.headmodel.meshing.meshes.template = 1;
            job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).fidname = 'NAS';
            job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).fidname = 'LPA';
            job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).fidname = 'RPA';
        end

end
job{1}.spm.meeg.source.headmodel.meshing.meshres = 2;

job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).specification.type = fid.data(1, :);
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).specification.type = fid.data(2, :);
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).specification.type = fid.data(3, :);
job{1}.spm.meeg.source.headmodel.coregistration.coregspecify.useheadshape = 0;

job{1}.spm.meeg.source.headmodel.forward.eeg = 'EEG BEM';
job{1}.spm.meeg.source.headmodel.forward.meg = 'Single Sphere';

end


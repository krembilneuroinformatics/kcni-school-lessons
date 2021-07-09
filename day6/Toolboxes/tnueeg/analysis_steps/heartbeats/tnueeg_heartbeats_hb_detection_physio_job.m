function job = tnueeg_heartbeats_hb_detection_physio_job(id, ECGfile, duration, options)
%TNUEEG_HEARTBEATS_HB_DETECTION_PHYSIO_JOB
%   IN:     id          -
%           ECGfile     -
%           duration    -
%           options     -
%   OUT:    -

job{1}.spm.tools.physio.save_dir = {''};

job{1}.spm.tools.physio.log_files.vendor = 'Custom';
job{1}.spm.tools.physio.log_files.cardiac = {ECGfile};
job{1}.spm.tools.physio.log_files.respiration = {''};
job{1}.spm.tools.physio.log_files.scan_timing = {''};
job{1}.spm.tools.physio.log_files.sampling_interval = 1/options.hb.samplingRate;
job{1}.spm.tools.physio.log_files.relative_start_acquisition = 0;
job{1}.spm.tools.physio.log_files.align_scan = 'last';

job{1}.spm.tools.physio.scan_timing.sqpar.Nslices = 35;
job{1}.spm.tools.physio.scan_timing.sqpar.NslicesPerBeat = [];
job{1}.spm.tools.physio.scan_timing.sqpar.TR = 2;
job{1}.spm.tools.physio.scan_timing.sqpar.Ndummies = 0;
job{1}.spm.tools.physio.scan_timing.sqpar.Nscans = floor(duration/2);
job{1}.spm.tools.physio.scan_timing.sqpar.onset_slice = 1;
job{1}.spm.tools.physio.scan_timing.sqpar.time_slice_to_slice = [];
job{1}.spm.tools.physio.scan_timing.sqpar.Nprep = [];
job{1}.spm.tools.physio.scan_timing.sync.nominal = struct([]);

job{1}.spm.tools.physio.preproc.cardiac.modality = 'ECG';
job{1}.spm.tools.physio.preproc.cardiac.initial_cpulse_select.auto_matched.min = 0.4;
job{1}.spm.tools.physio.preproc.cardiac.initial_cpulse_select.auto_matched.file = 'initial_cpulse_kRpeakfile.mat';
job{1}.spm.tools.physio.preproc.cardiac.posthoc_cpulse_select.off = struct([]);

job{1}.spm.tools.physio.model.output_multiple_regressors = '';
job{1}.spm.tools.physio.model.output_physio = 'physio.mat';
job{1}.spm.tools.physio.model.orthogonalise = 'none';
job{1}.spm.tools.physio.model.retroicor.no = struct([]);
job{1}.spm.tools.physio.model.rvt.no = struct([]);
job{1}.spm.tools.physio.model.hrv.no = struct([]);
job{1}.spm.tools.physio.model.noise_rois.no = struct([]);
job{1}.spm.tools.physio.model.movement.no = struct([]);
job{1}.spm.tools.physio.model.other.no = struct([]);

job{1}.spm.tools.physio.verbose.level = 2;
job{1}.spm.tools.physio.verbose.fig_output_file = ['PhysIO_diagnostics_' id '.fig'];
job{1}.spm.tools.physio.verbose.use_tabs = false;

end

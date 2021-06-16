function [RpeakTimes, TpeakTimes] = tnueeg_heartbeats_detect_heartbeats(options, details)
%TNUEEG_HEARTBEATS_DETECT_HEARTBEATS Detects heartbeats using the ECG data or the
%pulse oxi data. Uses the method indicated in options.
%   IN:     options     - the struct that holds all analysis options
%           details     - the struct that holds all subject-specific paths
%           (only needed for the PhysIO toolbox)
%   OUT:    hbTimes     - times of heartbeat events (in EEG time, to be
%                       used in EEG epoching)

switch options.hb.detectionType
   case 'Rphysio'
       % preparation
       spm('defaults', 'eeg');
       spm_jobman('initcfg');

       % detect Rpeaks or pulse peaks
       load(details.eegeventfile);
       dur = evt.eegEnd - evt.eegStart;
       detJob = tnueeg_heartbeats_hb_detection_physio_job(...
           id, details.ecgtxt, dur, options);
       spm_jobman('run', detJob);

       % load times of Rpeaks
       load(details.physiofile);

       % hbTimes as detected by PhysIO
       hbTimes = physio.ons_secs.cpulse;

       % to use HBs as EEG events
       hbTimes = hbTimes + evt.eegStart;

       % save HB times for epoching
       save(details.hbfile, 'hbTimes');
       
       RpeakTimes = hbTimes;
       TpeakTimes = [];

   case {'Rfourier', 'Twave'}
       load(details.eegevents);
       load(details.ecgfilemat);
       [RpeakTimes, TpeakTimes] = tnueeg_heartbeats_hb_detection_fourier(...
           evt, ecgData, ecgTime);

   case 'pulseOnset'
       % detect onset of pulse wave
       % develop code for this
end

end


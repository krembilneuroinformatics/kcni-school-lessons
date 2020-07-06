function [ D, numEyeblinks ] = tnueeg_eyeblink_detection_spm( D, options )
%TNUEEG_EYEBLINK_DETECTION_SPM Detects eye blink events based on thresholding
%   Detects eye blink events in an EEG data set by thresholding the
%   indicated eye (EOG) channel(s).
%   IN:     D       - continuous EEG data set
%           options - the struct that holds all analysis options
%   OUT:    D       - continuous EEG data set with marked eye blink events

S = [];
S.D = D;
S.mode = 'mark';
S.badchanthresh = 1;
S.methods.channels = options.preproc.eyeblinkchannels;

if isfield(options.preproc, 'eyeblinkdetection')
    % for backward compatibility
    switch options.preproc.eyeblinkdetection
        case 'sdThresholding'
            S.methods.fun = 'sdthresh';
            S.methods.settings.threshold = options.preproc.eyeblinkthreshold; % SD of EOG amplitude
            S.methods.settings.excwin = 0; % set this to zero to manually exclude trials with EB overlap
            % set the excwin to 1000 to use SPM event-based rejection.
            S.prefix = 'b';
        case 'ampThresholding'
            S.methods.fun = 'ampthresh';
            S.methods.settings.threshold = options.preproc.eyeblinkthreshold; % EOG amplitude in uV
            S.methods.settings.excwin = 1000;
            S.prefix = 'b';
        case 'ampThreshUnfiltered'       
            S.methods.fun = 'threshchan';
            S.methods.settings.threshold = options.preproc.eyeblinkthreshold; % in mV (applied to EOG amplitude)
            S.methods.settings.excwin = 1000;
            % excision window: Window (in ms) to mark as bad around each jump 
            % (for mark mode only), 0 - do not mark data as bad
    end    
else
    % newer version: detection should depend on eyeblink treatment
    % in all cases, we don't consider negative EOG peaks as blinks
    switch options.preproc.eyeblinktreatment
        case 'reject'
            % here, we include all EB events, even very large ones that might be other artefacts,
            % but we exclude very small peaks to not reject noise peaks
            S.methods.fun = 'eyeblinks_for_rejection';   
            S.windowOfInterestInSamples = options.preproc.windowForEyeblinkdetection;     
        case {'ssp', 'berg'}
            % here, we include all EB events, even very large ones that might be other artefacts -
            % precleaning before confound estimation should be performed based on the EEG data! We
            % also exclude very small peaks to not base our confound estimation on EOG noise peaks.
            S.methods.fun = 'eyeblinks_for_correction';    
            S.windowOfInterestInSamples = options.preproc.windowForEyeblinkdetection;        
    end
    S.methods.settings.threshold = options.preproc.eyeblinkthreshold; % SD of EOG amplitude
    S.methods.settings.excwin = 0; % set this to zero to manually exclude trials with EB overlap
    % set the excwin to 1000 to use SPM event-based rejection.
    S.prefix = 'b';
end 
S.append = true;
% 1: if other artefact detection has already been applied, 
% only the remaining clean channels will be used for this session.
% 0: all channels will be scanned for artefacts

fprintf('\nPerforming eye blink detection using a threshold of %s standard deviations.\n', ...
    num2str(options.preproc.eyeblinkthreshold));
D = tnueeg_spm_eeg_artefact(S); 

numEyeblinks = tnueeg_count_blink_artefacts(D);

if ~options.preproc.keep
    delete(S.D);
end

end


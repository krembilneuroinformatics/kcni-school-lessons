function SRC = tnueeg_bergscherg_source_waveforms(D, mode)
%TNUEEG_BERGSCHERG_SOURCE_WAVEFORMS Calculates the trial-wise estimated
%(artefact) source activity, given a matrix of spatial confounds. Can be
%used to inspect the estimated source acitivity of artefactual sources
%(eyes, cardiac field, ...) during artefact correction.
%   IN:     D               - epoched EEG data set with spatial confounds 
%                           and a headmodel (in case of Berg-mode) - BEFORE
%                           artefact correction!
%           mode            - either 'Berg' for estimating artefact source
%                           activity in presence of (the first principal
%                           components of) brain source activity, or any
%                           other string for a simple projection.
%   OUT:    SRC             - struct with fields:
%                           .data: an nChannels x nSamples x nTrials array
%                           containing the trial-wise estimated activity of
%                           the sources giving rise to the artefact
%                           expressed by:
%                           .A: the spatial confounds matrix 
%                           - and other fields depending on mode.


%-- input check ----------------------------------------------------------%
% get the confounds matrix
if ~any(D.sconfounds)
    error('Data set does not contain any spatial confounds!');
end
SRC.A = D.sconfounds;

mode = 'SSP';
% choose good channels
[mod, ~] = modality(D, 1, 1);
SRC.label = D.chanlabels(indchantype(D, mod, 'GOOD'))';    
if size(SRC.A, 1)~=numel(SRC.label)
    error('Spatial confound vector does not match the channels');
end

% save within-trial time for plotting
SRC.time = D.time;

%-- invert the confounds matrix ------------------------------------------%
if isequal(lower(mode), 'berg')
    % check that we have a head model
    if  ~isfield(D, 'val') || ~isfield(D, 'inv') || ~iscell(D.inv) ||...
            ~(isfield(D.inv{D.val}, 'forward') ...
            && isfield(D.inv{D.val}, 'datareg')) ||...
            ~isa(D.inv{D.val}.mesh.tess_ctx, 'char')% detects old version 
                                                    % of the struct
        error('Data set does not contain a head model yet!');
    end

    % compute the lead field matrix (tells us how sources project onto
    % channels)
    [SRC.L, D] = spm_eeg_lgainmat(D, [], SRC.label);
    % only keep the principal components of B that explain most
    % variance (more than 0.1)
    SRC.B = spm_svd(SRC.L*SRC.L', 0.1);

    % make sure B doesn't get too big (code copied from
    % spm_eeg_correct_sensor_data.m)
    lim = min(0.5*size(SRC.L, 1), 45); % 45 is the number of dipoles BESA would use.
    if size(SRC.B, 2) > lim;
        SRC.B = SRC.B(:, 1:lim);
    end

    % eye activity in presence of brain activity (A tells us how eye
    % sources project onto channels)
    SRC.SX = full([SRC.A SRC.B]);        
    SRC.SXi = pinv(SRC.SX); 
    % inverted matrix: tells us how to transform channel data to get to 
    % source data

    % now only keep the matrix (parts) for the eye sources
    SRC.invertedMatrix = SRC.SXi(1:size(SRC.A, 2), :);
else
    % in this case, eye activity is estimated separately from brain
    % activity
    SRC.invertedMatrix = pinv(SRC.A);
end    

%-- source 'reconstruction' ----------------------------------------------%
SRC.data = tnueeg_bergscherg_calculate_source_activity(D, SRC.invertedMatrix);


end




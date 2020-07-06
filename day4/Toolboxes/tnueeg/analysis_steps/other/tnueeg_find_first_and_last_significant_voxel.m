function [sigVoxels, xSPM] = tnueeg_find_first_and_last_significant_voxel(queryMode, searchMode, varargin)
%TNUEEG_FIND_FIRST_AND_LAST_SIGNIFICANT_VOXEL Reads the first and last
%time point of a cluster of significant activation from the xSPM struct. 
%What you need is:
% - an estimated SPM.mat
% - a height treshold ('FWE', 'none', and p-value)
% - an extent threshold (k - minimum number of voxels per blob) 
% The function will determine the z-values (in EEG, this corresponds to
% within-trial time) at the borders of the significant blobs that survive
% the height and extent thresholding.
%
%   IN:     queryMode   - String indicating either interactive ('gui')
%                       browsing of the SPM.mat and the contrast of 
%                       interest, or directly entering the thresholded xSPM
%                       struct ('xSPM')
%           searchMode  - String indicating whether function should look 
%                       for cluster-specific time points ('cluster') or the
%                       overall start and end time points ('overall').
%           varargin    - if in 'xSPM' queryMode, the xSPM struct has to be
%                       given as an input and has to contain the following
%                       fields (for a description, see below):
%                       xSPM.swd, xSPM.title, xSPM.Ic, xSPM.n, xSPM.Im, 
%                       xSPM.pm, xSPM.Ex, xSPM.u, xSPM.k, xSPM.thresDesc
%   OUT:    sigVoxels   - Struct containing the first and last timepoints
%                       (if in 'overall' searchMode) or the cluster-
%                       specific values and a summarizing cluster table (if
%                       in 'cluster' searchMode)

% get xSPM struct containing all significant voxels and their coordinates
switch queryMode
    case 'gui'
        [~, xSPM] = spm_getSPM;
        
    case 'xSPM'
        % Evaluated fields in xSPM (input)
        %
        % xSPM          - structure containing SPM, distribution & filtering details
        % .swd          - SPM working directory - directory containing current SPM.mat
        % .title        - title for comparison (string)
        % .Ic           - indices of contrasts (in SPM.xCon)
        % .n            - conjunction number <= number of contrasts
        % .Im           - indices of masking contrasts (in xCon)
        % .pm           - p-value for masking (uncorrected) 
        % .Ex           - flag for exclusive or inclusive masking
        % .u            - height threshold. In this case, u is the p value 
        %                 threshold. In the output xSPM, u will be the stat 
        %                 threshold (e.g., T value)
        % .k            - extent threshold {voxels}
        % .thresDesc    - description of height threshold (string) - 'none'
        %                 or 'FWE'

        % get xSPM struct back
        [~, xSPM] = spm_getSPM(xSPM);
end

% extract beginning and end time point of all voxels or clusters
switch searchMode
    case 'overall'
        % find first and last significant voxels
        sigVoxels.all   = xSPM.XYZmm;
        sigTimePoints   = sigVoxels.all(3, :);
        sigVoxels.first = min(sigTimePoints);
        sigVoxels.last  = max(sigTimePoints);

        % display
        disp('first significant time point of activation:');
        disp(sigVoxels.first);
        disp('last significant time point of activation:');
        disp(sigVoxels.last);

        % save this info
        save([xSPM.swd '/sig_time_window_' xSPM.title '.mat'], 'sigVoxels', 'xSPM');

    case 'cluster'
        L = xSPM.XYZ;
        A = spm_clusters(L);
        nClusters = max(A);

        for cl = 1: nClusters
            sigVoxels.clusters(cl).all  = xSPM.XYZmm(:, A==cl);
            
            sigTimePoints               = sigVoxels.clusters(cl).all(3, :);
            sigVoxels.clusters(cl).first= min(sigTimePoints);
            sigVoxels.clusters(cl).last = max(sigTimePoints);
            sigVoxels.clusters(cl).num  = numel(sigTimePoints);

        end
        if exist('sigVoxels')
            if numel(sigVoxels.clusters) > 1
                sigVoxels.clusterTable = struct2table(sigVoxels.clusters);
                % display the pretty table
                sigVoxels.clusterTable
            else
                % display the struct itself
                sigVoxels.clusters
            end
            save([xSPM.swd '/sig_time_window_clusters_' xSPM.title '.mat'], 'sigVoxels', 'xSPM');
        else
            disp('No significant Voxels found.')
            sigVoxels = NaN;
        end       
end


%% explanation for fields of xSPM (thresholded SPM)

% possible fields of xSPM:
%
% xSPM      - structure containing SPM, distribution & filtering details
% .swd      - SPM working directory - directory containing current SPM.mat
% .title    - title for comparison (string)
% .Z        - minimum of Statistics {filtered on u and k}
% .n        - conjunction number <= number of contrasts
% .STAT     - distribution {Z, T, X, F or P}
% .df       - degrees of freedom [df{interest}, df{residual}]
% .STATstr  - description string
% .Ic       - indices of contrasts (in SPM.xCon)
% .Im       - indices of masking contrasts (in xCon)
% .pm       - p-value for masking (uncorrected)
% .Ex       - flag for exclusive or inclusive masking
% .u        - height threshold
% .k        - extent threshold {voxels}
% .XYZ      - location of voxels {voxel coords}
% .XYZmm    - location of voxels {mm}
% .S        - search Volume {voxels}
% .R        - search Volume {resels}
% .FWHM     - smoothness {voxels}
% .M        - voxels -> mm matrix
% .iM       - mm -> voxels matrix
% .VOX      - voxel dimensions {mm} - column vector
% .DIM      - image dimensions {voxels} - column vector
% .Vspm     - Mapped statistic image(s)
% .Ps       - uncorrected P values in searched volume (for voxel FDR)
% .Pp       - uncorrected P values of peaks (for peak FDR)
% .Pc       - uncorrected P values of cluster extents (for cluster FDR)
% .uc       - 0.05 critical thresholds for FWEp, FDRp, FWEc, FDRc
% .thresDesc - description of height threshold (string)


%% OPTION: use mask to only look at a given cluster
% first, write out an image (binary mask) of the current cluster of
% interest.
% then:
%v = spm_data_hdr_read(Im{i});
%Mask = spm_data_read(v,'xyz',v.mat\SPM.xVol.M*[XYZ; ones(1,size(XYZ,2))]);
%Q = Mask ~= 0 & ~isnan(Mask);
%XYZ   = XYZ(:,Q);
%Z     = Z(Q);
%now we can find the max/min time point of this set of coordinates!

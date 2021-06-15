function [ con ] = mnket_write_contrast_results( xSPM )
%MNKET_WRITE_CONTRAST_RESULTS
%   IN:
%   OUT:
% xSPM      - structure containing SPM, distribution & filtering details
% .swd      - SPM working directory - directory containing current SPM.mat
% .title    - title for comparison (string)
% .Ic       - indices of contrasts (in SPM.xCon)
% .n        - conjunction number <= number of contrasts
% .Im       - indices of masking contrasts (in xCon)
% .pm       - p-value for masking (uncorrected)
% .Ex       - flag for exclusive or inclusive masking
% .u        - height threshold
% .k        - extent threshold {voxels}
% .thresDesc - description of height threshold (string)

%-- check input ----------------------------------------------------------%
if nargin < 1
    [~, xSPM] = spm_getSPM;
end
try 
    allVox = xSPM.XYZ;
catch
    [~, xSPM] = spm_getSPM(xSPM);
    allVox = xSPM.XYZ;
end

%-- store results info for plotting --------------------------------------%
con.name = 'Ketamine: Effect of epsi3';
con.stat = xSPM.STAT;

switch xSPM.thresDesc 
    case 'p<0.001 (unc.)'
        con.peak.correction     = 'None';
        con.peak.threshold      = 0.001;
        con.clust.correction    = 'FWE';
        con.clust.threshold     = 0.05;
    case 'p<0.05 (FWE)'
        con.peak.correction     = 'FWE';
        con.peak.threshold      = 0.05;
end
        

%-- collect results info from xSPM ---------------------------------------%
DIM     = xSPM.DIM > 1;
FWHM    = full(xSPM.FWHM);          % Full width at half max
FWHM    = FWHM(DIM);
V2R     = 1/prod(FWHM);             % voxels to resels
Resels  = full(xSPM.R);  
Resels  = Resels(1: find(Resels ~= 0, 1, 'last')); 
        
minz        = abs(min(min(xSPM.Z)));
statValue   = 1 + minz + xSPM.Z;
[numVoxels, statValue, XYZ, clustAssign, L]  = spm_max(statValue, allVox);
statValue   = statValue - minz - 1;

nClusters   = max(clustAssign);    
numResels   = numVoxels*V2R;
XYZmm       = xSPM.M(1:3, :) * [XYZ; ones(1, size(XYZ, 2))];

iClus = 0;
 while numel(find(isfinite(statValue)))
     % Count another cluster
     iClus = iClus + 1;
     
     % Find largest remaining local maximum
     [maxPeak, maxIdx]   = max(statValue);
     peakCoords          = XYZmm(:, maxIdx);
     clusterIndices      = find(clustAssign == clustAssign(maxIdx));
    
     allClusterVoxels    = XYZmm(:, clusterIndices);
     allClusterTimes     = allClusterVoxels(3, :);
     clusterTimeWindow   = [min(allClusterTimes) max(allClusterTimes)];
     
     % Keep clusters based on their p-values
     if isfield(con, 'clust') 
         % Cluster-level FWE-correction
         [Pk, ~] = spm_P(1, numResels(maxIdx), ...
             xSPM.u,  xSPM.df, xSPM.STAT, Resels, xSPM.n, xSPM.S);         % cluster-level FWE p value

         % Exclude cluster with cluster-level FWE pvalue > 0.05
         if Pk < con.clust.threshold
             % Save all cluster info for plotting
             con.clusters(iClus).peak    = peakCoords;
             con.clusters(iClus).timewin = clusterTimeWindow;
             con.clusters(iClus).pvalue  = Pk;
             con.clusters(iClus).extent  = numVoxels(maxIdx);
         end
     else
         switch con.peak.correction
             case 'FWE'
                 % Peak-level FWE-correction
                 P = spm_P(1, 0, ...
                    maxPeak, xSPM.df, xSPM.STAT, Resels, xSPM.n, xSPM.S);  % FWE-corrected p value
             case 'None'
                 % Peak-level uncorrected
                 P = spm_P(1, 0, ...
                    maxPeak, xSPM.df, xSPM.STAT, 1,      xSPM.n, xSPM.S);  % uncorrected p value
         end
         
         % Save all cluster info relevant for plotting
         con.clusters(iClus).peak    = peakCoords;
         con.clusters(iClus).timewin = clusterTimeWindow;
         con.clusters(iClus).pvalue  = P;
         con.clusters(iClus).extent  = numVoxels(maxIdx);
     end         

     % Remove voxels of this cluster from the list
     statValue(clusterIndices) = NaN; 
 end
 
 con.nClusters.all = nClusters;
 con.nClusters.sig = numel(con.clusters);
 
end


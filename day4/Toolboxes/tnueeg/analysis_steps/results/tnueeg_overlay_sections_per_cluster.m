function tnueeg_overlay_sections_per_cluster( xSPM, con )
%TNUEEG_OVERLAY_SECTIONS_PER_CLUSTER
%   IN:     xSPM        - 
%           con         - 
%   OUT:    -
%
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
if nargin < 2
    con = mnket_write_contrast_results(xSPM);
end

img = con.imgFile;
try 
    V = spm_vol(img);
catch
    warning('Could not find the image file')
    [img, sts] = spm_select(1,'image','Select image for rendering on');
    if ~sts, return; end
end


%-- setup plot -----------------------------------------------------------%
f = tnueeg_spm_sections(xSPM, [], img);
spm_figure('ColorMap', 'gray-jet')
spm_orthviews('Space');
title(con.name);

if isfield(con, 'clust')
    threshDesc = ['clevel_' con.clust.correction ...
        '_p' num2str(con.clust.threshold)];
else
    threshDesc = ['plevel_' con.peak.correction ...
        '_p' num2str(con.peak.threshold)];
end

%-- save a plot per cluster (centered on cluster peak) -------------------%
for iClus = 1: con.nClusters.sig
    
    % one file (image) per sig. cluster
    fileName = ['sections' ...
        '_' con.stat ...
        '_' threshDesc ...
        '_cluster' num2str(iClus) ...
        '_k' num2str(con.clusters(iClus).extent) ...
        ];
    
    % reposition to new cluster peak
    centre = con.clusters(iClus).peak;
    spm_orthviews('Reposition', centre);
    
    % print info on peak location
    
    if iClus == 1
        dim = [.2 .5 .3 .3];
        str = sprintf(...
            'View is centered at: \n%3.4f mm, %3.4f mm, %3.4f ms', ...
            con.clusters(iClus).peak);
        a = annotation('textbox', dim, ...
            'String', str, 'FitBoxToText', 'on');
    else
        str = sprintf(...
            'View is centered at: \n%3.4f mm, %3.4f mm, %3.4f ms', ...
            con.clusters(iClus).peak);
        a.String = str;
        
    end

    % save the figure (with and without crosshairs)
    spm_orthviews('Xhairs', 'on')
    print(f, [fileName '_cross.png'], '-dpng', '-r600');
    
    spm_orthviews('Xhairs', 'off')
    print(f, [fileName '.png'], '-dpng', '-r600');
    
    if iClus == con.nClusters.sig
        delete(a.Parent.Children);
    end
end

end
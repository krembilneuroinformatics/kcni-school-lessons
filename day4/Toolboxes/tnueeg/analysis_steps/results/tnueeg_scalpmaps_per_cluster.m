function tnueeg_scalpmaps_per_cluster( con, configs )
%TNUEEG_SCALPMAPS_PER_CLUSTER
%   IN:     con     - 
%           D       -
%           img     - 
%           configs - 
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

S.image     = con.imgFile;
S.D         = configs.D;
S.configs   = configs;
%S.clim = [];

[~, conName, ~, ~] = spm_fileparts(S.image);

%-- save a plot per cluster (i.e., per sig. time window) -----------------%
for iClus = 1: con.nClusters.sig
    S.window = con.clusters(iClus).timewin;
    
    %{
    S.style = 'spm';
    F = tnueeg_spm_eeg_img2maps(S);
    fileName = ['scalpmaps' ...
        '_' conName ...
        '_' S.style ...
        '_cluster' num2str(iClus) ...
        '_tw_' num2str(round(con.clusters(iClus).timewin(1))) 'ms'...
        '_to_' num2str(round(con.clusters(iClus).timewin(2))) 'ms'...
        '.png'];
    print(F, fileName, '-dpng', '-r600');
    %}
    
    S.style = 'ft';
    F = tnueeg_spm_eeg_img2maps(S);
    fileName = ['scalpmaps' ...
        '_' conName ...
        '_' S.style ...
        '_cluster' num2str(iClus) ...
        '_tw_' num2str(round(con.clusters(iClus).timewin(1))) 'ms'...
        '_to_' num2str(round(con.clusters(iClus).timewin(2))) 'ms'...
        '.png'];
    print(F, fileName, '-dpng', '-r600');
end

spm_figure('Close',F);

end



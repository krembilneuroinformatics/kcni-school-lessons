function [xSPM, varargout] = mnket_write_table_results( xSPM, pValueMode, setLevel )
%MNKET_WRITE_TABLE_RESULTS
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
if nargin < 3
    setLevel = false;
end
if nargin < 2
    pValueMode = 'clusterFWE';
end
if nargin < 1
    [~, xSPM] = spm_getSPM;
end
try 
    voxelCoords = xSPM.XYZ;
catch
    [~, xSPM] = spm_getSPM(xSPM);
    voxelCoords = xSPM.XYZ;
end

%-- filename for table ---------------------------------------------------%
ofile = ['table' ...
    '_' xSPM.STAT ...
    '_' pValueMode...
    '.csv'];

%-- data for table -------------------------------------------------------%
TabDat = spm_list('Table',xSPM);

nLines          = size(TabDat.dat, 1);
nCols           = size(TabDat.dat, 2);
clusterFWEpCol  = 3;

TabDat.hdr{2, end} = 'x {mm},y {mm},z {ms}';
TabDat.hdr{3, end} = 'mm mm ms';
TabDat.fmt{1, end} = '%3.0f %3.0f %3.0f';

if ~setLevel
    % remove set-level inference columns
    TabDat.dat(:, 1:2) = [];
    TabDat.hdr(:, 1:2) = [];
    TabDat.fmt(:, 1:2) = [];

    clusterFWEpCol  = 1;
    nCols           = nCols -2;
end

switch pValueMode
    case {'uncorr', 'peakFWE'}
        % do nothing
    case 'clusterFWE'
        % only keep clusters that survive cluster-level threshold of 0.05
        removeLines = [];
        iLine       = 1;
        while iLine <= nLines
            if TabDat.dat{iLine, clusterFWEpCol} >= 0.05
                removeLines = [removeLines iLine];
                iLine       = iLine +1;
                if iLine > nLines, break; end
                while isempty(TabDat.dat{iLine, clusterFWEpCol})
                    removeLines = [removeLines iLine];
                    iLine       = iLine +1;
                    if iLine > nLines, break; end
                end
            else
                iLine = iLine + 1;
            end
        end
        
        TabDat.dat(removeLines, :) = [];
        nLines = nLines - numel(removeLines);
end

kCol        = clusterFWEpCol + 2;
kMin        = min([TabDat.dat{:, kCol}]);
kCritical   = xSPM.uc(3);
                
                
%-- significant time windows ---------------------------------------------%
locs        = xSPM.XYZ;
% only continue if there are surviving voxels
if ~isempty(locs)
    clAssign    = spm_clusters(locs);
    nClusters   = max(clAssign);

    for iClus = 1: nClusters
        clusters(iClus).all    = xSPM.XYZmm(:, clAssign == iClus);

        sigTimePoints       = clusters(iClus).all(3, :);
        clusters(iClus).first  = min(sigTimePoints);
        clusters(iClus).last   = max(sigTimePoints);
        clusters(iClus).num    = numel(sigTimePoints);

    end

    if numel(clusters) > 1
        clusterTable = struct2table(clusters);
        disp(clusterTable);
    else
        disp(clusters);
    end

    varargout{1} = clusterTable;

    %-- add time windows to table ----------------------------------------%
    for iLine = 1: nLines
        for iClus = 1: nClusters
            if isequal(clusters(iClus).num, TabDat.dat{iLine, kCol})
                TabDat.dat{iLine, nCols +1} = clusters(iClus).first;
                TabDat.dat{iLine, nCols +2} = clusters(iClus).last;
            end
        end
    end    
    TabDat.hdr{1, nCols +1} = '';
    TabDat.hdr{1, nCols +2} = '';
    TabDat.hdr{2, nCols +1} = 'first {ms}';
    TabDat.hdr{2, nCols +2} = 'last {ms}';
    TabDat.hdr{3, nCols +1} = 'ms';
    TabDat.hdr{3, nCols +2} = 'ms';
    TabDat.fmt{1, nCols +1} = '%3.0f';
    TabDat.fmt{1, nCols +2} = '%3.0f';

    nCols = nCols +2;
    if ~isequal(nCols, size(TabDat.dat, 2))
        warning('Unequal column numbers, s.th. is wrong. Check the file!');
    end

    varargout{2} = TabDat;

    %-- write full table to CSV file -------------------------------------%
    fid = fopen(ofile, 'wt');
    fprintf(fid, [repmat('%s,', 1, nCols -3) '%s,,,%s,%s,\n'], ...
                    TabDat.hdr{1, :});
    fprintf(fid, [repmat('%s,', 1, nCols) '\n'], TabDat.hdr{2, :});
    fmt = TabDat.fmt;
    [fmt{2,:}] = deal(','); 
    fmt = [fmt{:}];
    fmt(end:end+1) = '\n'; fmt = strrep(fmt,' ',',');
    for maxIdx = 1: size(TabDat.dat, 1)
        fprintf(fid, fmt, TabDat.dat{maxIdx,:});
    end
    fclose(fid);


    %-- display reduced table --------------------------------------------%
    redDat = TabDat.dat;
    switch pValueMode
        case 'peakFWE'
            % only keep cluster-FWE pvalue, k, xyz of peak, and time window
            redDat(:, [1:2 4 6:9]) = [];

            redTab = array2table(redDat);
            redTab.Properties.VariableNames{'redDat1'} = 'clusterExtent';
            redTab.Properties.VariableNames{'redDat2'} = 'pFWEpeak';
            redTab.Properties.VariableNames{'redDat3'} = 'xyz';
            redTab.Properties.VariableNames{'redDat4'} = 'firstSigVox';
            redTab.Properties.VariableNames{'redDat5'} = 'lastSigVox';
        
        case 'clusterFWE'
            % only keep cluster-FWE pvalue, k, xyz of peak, and time window
            redDat(:, 1:2) = [];
            redDat(:, 3:8) = [];

            redTab = array2table(redDat);
            redTab.Properties.VariableNames{'redDat1'} = 'pFWEcluster';
            redTab.Properties.VariableNames{'redDat2'} = 'clusterExtent';
            redTab.Properties.VariableNames{'redDat3'} = 'xyz';
            redTab.Properties.VariableNames{'redDat4'} = 'firstSigVox';
            redTab.Properties.VariableNames{'redDat5'} = 'lastSigVox';
    end
    disp(redTab);
    
else
    fid = fopen(ofile, 'wt');
    fprintf(fid, 'No voxels survived.');
    fclose(fid);
end

end

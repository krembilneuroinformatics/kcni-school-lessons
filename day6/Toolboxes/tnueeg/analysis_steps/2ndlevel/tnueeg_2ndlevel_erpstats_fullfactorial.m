function tnueeg_2ndlevel_erpstats_fullfactorial( scndlvlroot, factorNames, factorLevels, ...
    factorDependence, factorVarianceUnequal, cells )
%TNUEEG_2NDLEVEL_ERPSTATS_FULLFACTORIAL Computes main effects and interactions for a full factorial
%analysis of on the second level.
%   IN:     scndlvlroot             - directory (string) for saving the SPM.mat
%           factorNames             - cell array list of factor names
%           factorLevels            - vector with number of levels of each factor
%           factorDependence        - vector with 1 for each dependent factor and 0 for each
%                                   independent factor
%           factorVarianceUnequal   - vector with 1 (0) for each factor with unequal (equal) 
%                                   variances
%           cells                   - cell struct with nCells entries and substruct fields 
%                                   specifying the factor levels and the corresponding image files 
%                                   (scans) for each cell of the design
%   OUT:    --

%-- preparation -----------------------------------------------------------------------------------%
nFactors = numel(factorNames);

% specify the nature of the factors
for iFac = 1: nFactors
    factors{1, iFac} = factorNames{iFac};
    factors{2, iFac} = factorLevels(iFac);
    factors{3, iFac} = factorDependence(iFac);
    factors{4, iFac} = factorVarianceUnequal(iFac);
end

%-- statistics in SPM -----------------------------------------------------------------------------%
spm('defaults', 'EEG');
spm_jobman('initcfg');

% create and run the job - one test per regressor
job = tnueeg_getjob_2ndlevel_fullfactorial(scndlvlroot, factors, cells);
spm_jobman('run', job);

end
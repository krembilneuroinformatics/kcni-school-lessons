function mnket_2ndlevel_erpbased
%MNKET_2NDLEVEL_ERPBASED Performs all 2nd level analyses steps for
%modelfree ERP analysis in the MNKET study.
%   Currently, this only uses the difference waves from the first level (no
%   computation of grand averages or stats for deviant and standard
%   waveforms separately).
%   IN:     --
%   OUT:    --

options = mnket_set_analysis_options;

options.conversion.mode = 'diffWaves';
options.stats.mode = 'diffWaves';

for optionsCell = {'placebo', 'ketamine'}
    options.condition = char(optionsCell);
    
    % roving definition
    options.erp.type = 'roving';
    mnket_2ndlevel_erpanalysis_percondition(options);
    mnket_2ndlevel_erpstats_percondition(options);
    
    % MMN AD definition
    options.erp.type = 'mmnad';
    mnket_2ndlevel_erpanalysis_percondition(options);
    mnket_2ndlevel_erpstats_percondition(options);
    
end

% roving definition
options.erp.type = 'roving';
mnket_2ndlevel_erpanalysis_drugdiff(options);
mnket_2ndlevel_erpstats_drugdiff(options);

% MMN AD definition
options.erp.type = 'mmnad';
mnket_2ndlevel_erpanalysis_drugdiff(options);
mnket_2ndlevel_erpstats_drugdiff(options);

end


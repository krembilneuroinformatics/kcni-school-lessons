function mnket_analyze_subject( id )
%MNKET_ANALYZE_SUBJECT Performs all analysis steps for one subject of the
%MNKET study (up until first level modelbased statistics)
%   IN:     id  - subject identifier string, e.g. '0001'
%   OUT:    --

options = mnket_set_analysis_options;

for optionsCell = {'placebo', 'ketamine'}
    options.condition = char(optionsCell);
    
    % Preparation and Pre-processing
    mnket_data_preparation(id, options);
    mnket_preprocessing(id, options);
    
    % ERP analysis (up until conversion): roving definition
    options.erp.type = 'roving';
    mnket_erp(id, options);
    
    options.conversion.mode = 'diffWaves';
    mnket_conversion(id, options);
    
    % ERP analysis (up until conversion): MMN definition
    options.erp.type = 'mmnad';
    mnket_erp(id, options);
    
    options.conversion.mode = 'diffWaves';
    mnket_conversion(id, options);

    % modelbased analysis (up until 1st level)
    options.conversion.mode = 'modelbased';
    mnket_conversion(id, options);
    
    options.stats.mode = 'modelbased';
    options.stats.design = 'epsilon';
    mnket_1stlevel(id, options);
    
end


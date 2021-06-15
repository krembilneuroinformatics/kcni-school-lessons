function dprst_analyze_subject( id )
%DPRST_ANALYZE_SUBJECT Performs all analysis steps for one subject of the
%DPRST study (up until first level modelbased statistics)
%   IN:     id  - subject identifier string, e.g. '0001'
%   OUT:    --

options = dprst_set_analysis_options;

% Preparation and Pre-processing
%dprst_data_preparation(id, options);
dprst_preprocessing(id, options);

% % ERP analysis (up until conversion): roving definition
% options.erp.type = 'roving';
% dprst_erp(id, options);
% 
% options.conversion.mode = 'diffWaves';
% dprst_conversion(id, options);
% 
% % ERP analysis (up until conversion): MMN definition
% options.erp.type = 'mmnad';
% dprst_erp(id, options);
% 
% options.conversion.mode = 'diffWaves';
% dprst_conversion(id, options);
% 
% % modelbased analysis (up until 1st level)
% options.conversion.mode = 'modelbased';
% dprst_conversion(id, options);
% 
% options.stats.mode = 'modelbased';
% options.stats.design = 'epsilon';
% dprst_1stlevel(id, options);

end


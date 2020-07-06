function mmn_analyze_subject( id, options )
%MMN_ANALYZE_SUBJECT Performs all analysis steps for one subject of the MMN roving EEG study (up until
%first level modelbased statistics)
%   IN:     id  - subject identifier string, e.g. '0001'
%   OUT:    --

if nargin < 2
    options = mmn_set_analysis_options;
end

%% Preparation and Modeling
mmn_data_preparation(id, options);
mmn_model(id, options);

%% Pre-processing: reject eyeblinks
options.preproc.eyeblinktreatment = 'reject';
fprintf('\n\n --- Subject analysis using: %s method ---\n\n', upper(options.preproc.eyeblinktreatment));
mmn_preprocessing_reject(id, options);

%% ERP analysis: tone definition
options.erp.type = 'lowhighEpsi2';
mmn_erp(id, options);

options.erp.type = 'lowhighEpsi3';
mmn_erp(id, options);

%% Modelbased analysis (up until 1st level)
options.conversion.mode = 'modelbased';
mmn_conversion(id, options);

options.stats.mode = 'modelbased';
options.stats.design = 'epsilon';
mmn_1stlevel(id, options);



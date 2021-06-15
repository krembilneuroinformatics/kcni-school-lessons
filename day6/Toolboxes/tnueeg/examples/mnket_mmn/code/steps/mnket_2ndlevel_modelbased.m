function mnket_2ndlevel_modelbased
%MNKET_2NDLEVEL_MODELBASED Performs all 2nd level analyses steps for
%modelbased single-trial EEG analysis in the MNKET study
%   IN:     --
%   OUT:    --

options = mnket_set_analysis_options;

options.stats.mode = 'modelbased';
options.stats.design = 'epsilon';    

for optionsCell = {'placebo', 'ketamine'}
    options.condition = char(optionsCell);

    mnket_2ndlevel_singletrial_percondition(options);
end

mnket_2ndlevel_singletrial_drugdiff(options);

end


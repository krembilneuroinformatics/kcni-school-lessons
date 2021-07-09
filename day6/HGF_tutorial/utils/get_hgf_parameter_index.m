function [parameter_idx, parameter_name, parameter_array] = get_hgf_parameter_index(parameter)
% -------------------------------------------------------------------------
% This function returns the parameter index in the est.p_prc.p array for
% the KCNI2020_hgf_ar1_lvl3 model. Note, that this may change depending on
% the model that you use, as different models may include different
% parameters. This function also returns a name to generate pretty plots
% and an array of parameter values with a reasonable range.
% -------------------------------------------------------------------------


%% Main
switch parameter
     case 'phi2'
        parameter_idx = 8;
        parameter_name = '\\phi_2';
        parameter_array = [0 .05 .1 .25 .3 .6];
    
    case 'phi3'
        parameter_idx = 9;
        parameter_name = '\\phi_3';
        parameter_array = [0 .05 .1 .25 .3 .6];
      
    case 'm2'
        parameter_idx = 11;
        parameter_name = 'm_2';
        parameter_array = [-1 -.5 0 .5 1];
               
    case 'm3'
        parameter_idx = 12;
        parameter_name = 'm_3';
        parameter_array = [-2 -1 0 1 2 3];
             
    case 'ka2'
        parameter_idx = 14;
        parameter_name = '\\kappa_2';
        parameter_array = [.2 .4 .6 .8];
        
    case 'om2'
        parameter_idx = 16;
        parameter_name = '\\omega_2';
        parameter_array = [-10 -8 -6 -4 -2];
        
    case 'th'
        parameter_idx = 17;
        parameter_name = '\\theta';
        parameter_array = [.2 .4 .6 .8];
end
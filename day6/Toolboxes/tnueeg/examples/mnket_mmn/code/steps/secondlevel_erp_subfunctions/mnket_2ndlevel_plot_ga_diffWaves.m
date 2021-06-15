function mnket_2ndlevel_plot_ga_diffWaves(options)
%MNKET_2NDLEVEL_PLOT_GA_DIFFWAVES Plots Grand Averages with shaded Error Bars

titleForGA = ['Grand average ' options.erp.type 'difference waves: ' ...
    ' at electrode ' options.erp.electrode];
myColors = [1 0.55 0; 0 0 0];

for iCon = 1: numel(options.conditions)
    options.condition = options.conditions{iCon};
    [~, paths] = mnket_subjects(options);
    fileNames{iCon} = paths.erpgafile;
end

tnueeg_plot_grandmean_with_sem(fileNames, titleForGA, options.conditions, ...
    paths.erpgafig, myColors, 2);
end


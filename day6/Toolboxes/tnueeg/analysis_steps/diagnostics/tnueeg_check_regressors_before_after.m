function [ fhComp ] = tnueeg_check_regressors_before_after(beforeDesignFile, ...
    afterDesignFile, compFigure)
%TNUEEG_CHECK_REGRESSORS_BEFORE_AFTER Plots all regressors of a given design file before and after 
%pruning for bad EEG trials and saves the plots to the specified figure file names.
%   IN:     dataFile                - full file name (including path) to EEG data set with coreg
%           meshFigure, dataFigure  - full file names (including paths) for saving the resulting
%           plots
%   OUT:    -

beforeDesign= getfield(load(beforeDesignFile), 'design');
afterDesign = getfield(load(afterDesignFile), 'design');

regressors  = fieldnames(beforeDesign);

for iReg = 1: numel(regressors)
    fhComp(iReg) = figure;
    
    subplot(2, 1, 1);
    plot(beforeDesign.(regressors{iReg}), '.k', 'MarkerSize', 3);
    xlim([1 numel(beforeDesign.(regressors{iReg}))]);
    title([regressors{iReg} ' before pruning']);
    
    subplot(2, 1, 2);
    plot(afterDesign.(regressors{iReg}), '.b', 'MarkerSize', 3);
    xlim([1 numel(beforeDesign.(regressors{iReg}))]);
    title([regressors{iReg} ' after pruning']);
        
    if nargin > 2 && ~isempty(compFigure)
        saveas(fhComp(iReg), [compFigure '_' regressors{iReg}], 'fig');
        close(fhComp(iReg));
    end

end
    
    


end
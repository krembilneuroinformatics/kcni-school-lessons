function tnueeg_bergscherg_plot_spatial_confounds_scalpmap(D)

% Plot scalp topographies
% ---------------------------------------------------------------------
if any(any(D.sconfounds))
    
    Fgraph = spm_figure('GetWin','Graphics');clf
    
    in = [];
    in.f = Fgraph;
    in.noButtons = 1;
    in.cbar = 0;
    in.plotpos = 0;
    
    [junk, modalities] = modality(D, 1, 1);
    
    conf = getfield(D, 'sconfounds');
    
    nm = numel(modalities);
    nc = size(conf.coeff, 2);
    
    for i = 1:nc
        for j = 1:nm
            in.type = modalities{j};
            
            ind = D.indchantype(modalities{j}, 'GOOD');
            
            [sel1, sel2] = spm_match_str(D.chanlabels(ind), conf.label);
            
            Y = conf.coeff(sel2, i);            
            
            in.max = max(abs(Y));
            in.min = -in.max;
            
            in.ParentAxes = subplot(nc, nm, (i - 1)*nm + j);
            spm_eeg_plotScalpData(Y, D.coor2D(ind) , D.chanlabels(ind), in);
            title(sprintf('%s\ncomponent %.0f', modalities{j}, i));           
        end
    end
end


end
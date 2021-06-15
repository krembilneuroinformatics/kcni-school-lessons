function mnket_rsync_model_results( options, sourceprojectroot )
%MNKET_RSYNC_MODEL_RESULTS Syncs results of the model simulations from a
%previous MNKET analysis with the new analysis folder for each subject.

disp('MNKET setup: Rsync modeling results with new analysis folder');

conditions      = {'placebo', 'ketamine'};

% source: where are the modeling results
moddatasource   = fullfile(sourceprojectroot, 'data', 'subjects');
srcprefix       = 'MMN_';
srcsubfolder    = 'model';

% destination: where should I also put them
moddatadest     = fullfile(options.workdir, 'data', 'pro', 'subjects');
destprefix      = 'MMN_';

% loop over conditions and subjects
for condCell    = conditions
    cond        = char(condCell);

    for idCell  = options.subjects.all
        id      = char(idCell);

        srcmod  = fullfile(moddatasource, cond, [srcprefix id], srcsubfolder);
        destmod = fullfile(moddatadest, cond, [destprefix id]);
        
        cmdStr  = ['rsync -av ' srcmod ' ' destmod];
        system(cmdStr);
        
        disp(['Rsynced model results for subject ' id ' in condition ' cond]);
    end
end

end


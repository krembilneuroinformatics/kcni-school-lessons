% a short script containing settings for model comparison

matlabbatch{1}.spm.dcm.bms.inference.dir = {pwd};

matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{1}.dcmmat = {[pwd '/DCMnomod.mat']
                                                           [pwd '/DCMmodb22.mat']
                                                           [pwd '/DCMmodb21.mat']
                                                           };
matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
matlabbatch{1}.spm.dcm.bms.inference.method = 'FFX';
matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {''};
matlabbatch{1}.spm.dcm.bms.inference.bma.bma_no = 0;
matlabbatch{1}.spm.dcm.bms.inference.verify_id = 0;

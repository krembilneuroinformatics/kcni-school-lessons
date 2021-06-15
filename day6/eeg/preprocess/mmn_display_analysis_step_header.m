function mmn_display_analysis_step_header( stepstr, id, opstruct )
%mmn_LOG_HEADER Displays a header with current time and date, subject id
%and name of the analysis step
%   IN:     stepstr - string with name of current analysis step, e.g 'ERP'
%           id      - subject identifier string, e.g. '0001'
%   OUT:    --

wid = 50;
lch = '*';

fprintf('\n%s\n', ['Start of ' upper(stepstr) ' step for MMN_' id]);
fprintf('%s',repmat(lch,1,wid)),fprintf('\n')
fprintf('%s\n\n', spm('time'));
disp(opstruct);

end


function tnueeg_display_analysis_step_header( stepstr, pid, id, opstruct )
%TNUEEG_DISPLAY_ANALYSIS_STEP_HEADER Displays a header with current time 
%and date, subject id, and name of the analysis step
%   IN:     stepstr - string with name of current analysis step, e.g 'ERP'
%           pid     - string with name of project, e.g. 'DPRST'
%           id      - subject identifier string, e.g. '0001'
%           opstruct - struct (part of general options) with step-relevant
%                   options
%   OUT:    --

wid = 50;
lch = '*';

fprintf('\n%s\n', ['Start of ' upper(stepstr) ' step for ' ...
                    upper(pid) '_' id]);
fprintf('%s', repmat(lch, 1, wid)), fprintf('\n')
fprintf('%s\n\n', spm('time'));
disp(opstruct);

end


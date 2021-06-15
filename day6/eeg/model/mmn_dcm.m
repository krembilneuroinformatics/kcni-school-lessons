function mmn_dcm(id, options)
%mmn_dcm Computes DCMs for one subject from the mmn study.
%   IN:     id                  - subject identifier, e.g '0001'
%   OUT:    D                   - DCM structure file


%% General options
% analysis options
if nargin < 2
    options = mmn_set_analysis_options;
end

% paths and files
[details, ~] = mmn_subjects(id, options);

% prepare spm
spm('defaults', 'EEG');

% record what we're doing
diary(details.logfile);
mmn_display_analysis_step_header('DCM', id, options.dcm);

% check destination folder
if ~exist(details.dcmroot, 'dir')
    mkdir(details.dcmroot);
end

%% Model definition
%--------------------------------------------------------------------------
% Analysis directory
%--------------------------------------------------------------------------
% Set output directory
cd(details.dcmroot);

% Set output file name
file_name = details.dcmfile;


%--------------------------------------------------------------------------
% Data filename
%--------------------------------------------------------------------------
% Set data file name
dcmData.xY.Dfile = details.erpfile;

%--------------------------------------------------------------------------
% Parameters and options used for setting up model
%--------------------------------------------------------------------------
dcmData.options = options.dcm;

%--------------------------------------------------------------------------
% Data and spatial model
%--------------------------------------------------------------------------
dcmNetwork = spm_dcm_erp_data(dcmData);

%--------------------------------------------------------------------------
% Location priors for dipoles
%--------------------------------------------------------------------------
dcmNetwork.Lpos  = options.dcm.sources.mni;
dcmNetwork.Sname = options.dcm.sources.name;

%--------------------------------------------------------------------------
% Spatial model
%--------------------------------------------------------------------------
dcmModel = spm_dcm_erp_dipfit(dcmNetwork);


%--------------------------------------------------------------------------
% Specify connectivity model
%--------------------------------------------------------------------------
% Forward connections
dcmModel.A{1,1} = ...
    [0 0 0 0 0
    0 0 0 0 0
    1 0 0 0 0
    0 1 0 0 0
    0 0 0 1 0];

% Backward connections
dcmModel.A{1,2} = ...
    [0 0 1 0 0
    0 0 0 1 0
    0 0 0 0 0
    0 0 0 0 1
    0 0 0 0 0];

% Lateral connections
dcmModel.A{1,3} = ...
    [0 1 0 0 0
    1 0 0 0 0
    0 0 0 1 0
    0 0 1 0 0
    0 0 0 0 0];

% PE modulation
dcmModel.B{1,1} = ...
    [0 0 1 0 0
    0 0 0 1 0
    1 0 0 0 0
    0 1 0 0 1
    0 0 0 1 0];

% Input
dcmModel.C = [1; 1; 0; 0; 0];


%--------------------------------------------------------------------------
% Between trial effects
%--------------------------------------------------------------------------
dcmModel.xU.X    = options.dcm.contrast.code;
dcmModel.xU.name = options.dcm.contrast.type;


%--------------------------------------------------------------------------
% Invert
%--------------------------------------------------------------------------
dcmModel.name = file_name;
dcmInverted = spm_dcm_erp(dcmModel);

%--------------------------------------------------------------------------
% Explore Results
%--------------------------------------------------------------------------
figure;
BmatrixParameters = exp(dcmInverted.Ep.B{1}); 
nParameters       = 5;
imagesc(BmatrixParameters);
colormap(jet);
colorbar;
labelNames = options.dcm.sources.name;
set(gca,'XTickLabel',labelNames);   % gca gets the current axis
set(gca,'YTickLabel',labelNames);    % gca gets the current axis
xticks([1:nParameters]);
yticks([1:nParameters]);

textStrings = num2str(BmatrixParameters(:), '%0.2f');       % Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
[x, y] = meshgrid(1:nParameters);  % Create x and y coordinates for the strings
hStrings = text(x(:), y(:), textStrings(:), ...  % Plot the strings
                'HorizontalAlignment', 'center');
midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range
set(hStrings,'Fontsize',32);
textColors = repmat(BmatrixParameters(:) < midValue, 1, 3);
set(hStrings, {'Color'}, num2cell(textColors, 2));  % Change the text colors
savefig(details.dcmFigParam);

spm_dcm_erp_results(dcmInverted,'response');
savefig(details.dcmPredictedSimulated);
spm_dcm_erp_results(dcmInverted,'scalp maps');
savefig(details.dcmScalpMaps);

fprintf('\nSaved the DCM figures for subject %s\n\n', id);








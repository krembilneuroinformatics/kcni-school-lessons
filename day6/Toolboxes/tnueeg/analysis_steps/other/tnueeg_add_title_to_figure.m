function tnueeg_add_title_to_figure(fullFileName, figureTitle, destinationDir, fileFormat)
%TNUEEG_ADD_TITLE_TO_FIGURE Opens an existing figure file, adds a title at the top center of it, and
%saves the resulting figure.
%   Can be used to add a title to an existing figure, to copy an existing figure to destinationDir
%   with or without an additional title, and to save a .fig file in any other file format such as
%   .png or .pdf. 
%   IN:     fullFileName    - full name of existing .fig file including path
%           figureTitle     - string with title to display (or empty)
%           destinationDir  - 
%           fileFormat

% use empty string for title if unspecified or empty vector
if nargin < 2 || isempty(figureTitle)
    figureTitle = '';
end

% open figure and add title
fh = openfig(fullFileName);
tnueeg_main_title(figureTitle);

% save figure according to input arguments
[filePath, fileName, ~] = fileparts(fullFileName);

if nargin > 2 && isempty(destinationDir)
    destinationDir = filePath;
end

if nargin < 3
    saveas(fh, fullFileName, 'fig');
elseif nargin < 4
    saveas(fh, fullfile(destinationDir, fileName), 'fig');
else
    saveas(fh, fullfile(destinationDir, fileName), fileFormat);
end

% close figure
close(fh);

end
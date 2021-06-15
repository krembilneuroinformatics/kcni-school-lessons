function [ axisHandle, titleHandle ] = tnueeg_main_title( titleString )
%TNUEEG_MAIN_TITLE Centers a title over a group of subplots.
%   IN:     fh
%           titleString
%   OUT:    axisHandle 
%           titleHandle

% create invisible axis on the top center of the figure
axisHandle = axes('Units', 'Normal', 'Position', [.075 .075 .85 .90], 'Visible', 'off');

% set title of the axis to visible and fill it with the string
set(get(axisHandle, 'Title'), 'Visible', 'on')
title(titleString);

if (nargout < 2)
    return
end
titleHandle = get(axisHandle, 'Title');

end
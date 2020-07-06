function [ conf ] = mnket_configure_scalpmaps(con, options, flag)
%MNKET_CONFIGURE_SCALPMAPS
%   IN:   con    -
%         options - 
%         flag    - 
%   OUT:  conf    -

% choose on subject ID for plotting electrode locations
id = options.stats.exampleID;
details = mnket_subjects(id, options);
conf.D = spm_eeg_load(details.prepfile);

% use the T/F-statistic image of the contrast for the scalpmap
conf.img = con.imgFile;

% configure FT scalpmap plot
conf.cfg.colormap = jet;
conf.cfg.colorbar = 'yes';

conf.cfg.marker = 'on'; % 'on', 'labels'
conf.cfg.markersymbol       = '.';
conf.cfg.markercolor        = [0 0 0];
conf.cfg.markersize         = 20;
conf.cfg.markerfontsize     = 12;

if ischar(flag)
    switch flag
        case options.conditions
            conf.cfg.zlim = 'zeromax';
        case 'drugdiff'
            conf.cfg.zlim = 'maxabs';
    end
else
    conf.cfg.zlim = flag;
end

% configure SPM scalpmap plot
conf.spm.plotpos = false;
conf.spm.noButtons = true;

end

% The configuration can have the following parameters:
%   cfg.parameter          = field that contains the data to be plotted as color
%                           'avg', 'powspctrm' or 'cohspctrm' (default depends on data.dimord)
%   cfg.maskparameter      = field in the data to be used for masking of
%                            data. Values between 0 and 1, 0 = transparent
%   cfg.xlim               = selection boundaries over first dimension in data (e.g., time)
%                            'maxmin' or [xmin xmax] (default = 'maxmin')
%   cfg.ylim               = selection boundaries over second dimension in data (e.g., freq)
%                            'maxmin' or [xmin xmax] (default = 'maxmin')
%   cfg.channel            = Nx1 cell-array with selection of channels (default = 'all'), see FT_CHANNELSELECTION for details
%   cfg.refchannel         = name of reference channel for visualising connectivity, can be 'gui'
%   cfg.baseline           = 'yes','no' or [time1 time2] (default = 'no'), see FT_TIMELOCKBASELINE or FT_FREQBASELINE
%   cfg.baselinetype       = 'absolute' or 'relative' (default = 'absolute')
%   cfg.trials             = 'all' or a selection given as a 1xN vector (default = 'all')

%   cfg.colormap           = any sized colormap, see COLORMAP
%   cfg.colorbar           = 'yes'
%                            'no' (default)
%                            'North'              inside plot box near top
%                            'South'              inside bottom
%                            'East'               inside right
%                            'West'               inside left
%                            'NorthOutside'       outside plot box near top
%                            'SouthOutside'       outside bottom
%                            'EastOutside'        outside right
%                            'WestOutside'        outside left
%   cfg.zlim               = plotting limits for color dimension, 'maxmin', 'maxabs', 'zeromax', 'minzero', or [zmin zmax] (default = 'maxmin')

%   cfg.marker             = 'on', 'labels', 'numbers', 'off'
%   cfg.markersymbol       = channel marker symbol (default = 'o')
%   cfg.markercolor        = channel marker color (default = [0 0 0] (black))
%   cfg.markersize         = channel marker size (default = 2)
%   cfg.markerfontsize     = font size of channel labels (default = 8 pt)

%   cfg.highlight          = 'on', 'labels', 'numbers', 'off'
%   cfg.highlightchannel   =  Nx1 cell-array with selection of channels, or vector containing channel indices see FT_CHANNELSELECTION
%   cfg.highlightsymbol    = highlight marker symbol (default = 'o')
%   cfg.highlightcolor     = highlight marker color (default = [0 0 0] (black))
%   cfg.highlightsize      = highlight marker size (default = 6)
%   cfg.highlightfontsize  = highlight marker size (default = 8)
%   cfg.hotkeys            = enables hotkeys (up/down arrows) for dynamic colorbar adjustment



%   cfg.interplimits       = limits for interpolation (default = 'head')
%                            'electrodes' to furthest electrode
%                            'head' to edge of head
%   cfg.interpolation      = 'linear','cubic','nearest','v4' (default = 'v4') see GRIDDATA
%   cfg.style              = plot style (default = 'both')
%                            'straight' colormap only
%                            'contour' contour lines only
%                            'both' (default) both colormap and contour lines
%                            'fill' constant color between lines
%                            'blank' only the head shape
%   cfg.gridscale          = scaling grid size (default = 67)
%                            determines resolution of figure
%   cfg.shading            = 'flat' 'interp' (default = 'flat')
%   cfg.comment            = string 'no' 'auto' or 'xlim' (default = 'auto')
%                            'auto': date, xparam and zparam limits are printed
%                            'xlim': only xparam limits are printed
%   cfg.commentpos         = string or two numbers, position of comment (default 'leftbottom')
%                            'lefttop' 'leftbottom' 'middletop' 'middlebottom' 'righttop' 'rightbottom'
%                            'title' to place comment as title
%                            'layout' to place comment as specified for COMNT in layout
%                            [x y] coordinates
%   cfg.interactive        = Interactive plot 'yes' or 'no' (default = 'yes')
%                            In a interactive plot you can select areas and produce a new
%                            interactive plot when a selected area is clicked. Multiple areas
%                            can be selected by holding down the SHIFT key.
%   cfg.directionality     = '', 'inflow' or 'outflow' specifies for
%                            connectivity measures whether the inflow into a
%                            node, or the outflow from a node is plotted. The
%                            (default) behavior of this option depends on the dimor
%                            of the input data (see below).
%   cfg.layout             = specify the channel layout for plotting using one of
%                            the supported ways (see below).
%   cfg.interpolatenan     = string 'yes', 'no' (default = 'yes')
%                            interpolate over channels containing NaNs
%
% For the plotting of directional connectivity data the cfg.directionality
% option determines what is plotted. The default value and the supported
% functionality depend on the dimord of the input data. If the input data
% is of dimord 'chan_chan_XXX', the value of directionality determines
% whether, given the reference channel(s), the columns (inflow), or rows
% (outflow) are selected for plotting. In this situation the default is
% 'inflow'. Note that for undirected measures, inflow and outflow should
% give the same output. If the input data is of dimord 'chancmb_XXX', the
% value of directionality determines whether the rows in data.labelcmb are
% selected. With 'inflow' the rows are selected if the refchannel(s) occur in
% the right column, with 'outflow' the rows are selected if the
% refchannel(s) occur in the left column of the labelcmb-field. Default in
% this case is '', which means that all rows are selected in which the
% refchannel(s) occur. This is to robustly support linearly indexed
% undirected connectivity metrics. In the situation where undirected
% connectivity measures are linearly indexed, specifying 'inflow' or
% 'outflow' can result in unexpected behavior.
%
% The layout defines how the channels are arranged. You can specify the
% layout in a variety of ways:
%  - you can provide a pre-computed layout structure, see FT_PREPARE_LAYOUT
%  - you can give the name of an ascii layout file with extension *.lay
%  - you can give the name of an electrode file
%  - you can give an electrode definition, i.e. "elec" structure
%  - you can give a gradiometer definition, i.e. "grad" structure
% If you do not specify any of these and the data structure contains an
% electrode or gradiometer structure, that will be used for creating a
% layout. If you want to have more fine-grained control over the layout
% of the subplots, you should create your own layout file.
%
% See also FT_SINGLEPLOTER, FT_MULTIPLOTER, FT_SINGLEPLOTTFR, FT_MULTIPLOTTFR,
% FT_TOPOPLOTTFR, FT_PREPARE_LAYOUT

% Undocumented options:
%
% It is possible to use multiple highlight-selections (e.g.: multiple
% statistical clusters of channels) To do this, all the content of
% the highlight-options (including cfg.highlight) should be placed
% in a cell-array (even if the normal content was already in a
% cell-array). Specific marker settings (e.g. color, size) are defaulted
% when not present.
%
% Example (3 selections):
% cfg.highlight          = {'labels', 'labels', 'numbers'}
% cfg.highlightchannel   = {{'MZF03','MZC01','MRT54'}, [1:5], 'C*'}
% cfg.highlightsymbol    = {'o',[],'+'}        % the empty option will be defaulted
% cfg.highlightcolor     = {'r',[0 0 1]};      % the missing option will be defaulted
% cfg.highlightsize      = [];                 % will be set to default, as will the missing cfg.highlightfontsize
%
% Other options:
% cfg.labeloffset (offset of labels to their marker, default = 0.005)
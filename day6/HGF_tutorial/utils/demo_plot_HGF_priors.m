% -------------------------------------------------------------------------
% This script shows conversion of probability distribution from logit/log 
% space and allows you to compare different prior means and variances.
% -------------------------------------------------------------------------


%% Options
% Array or single value
muArray    = [0 0 0 0 0];   % Mean
sigmaArray = [.1 .5 1 2 5]; % Variance! NOT standard deviation
bArray     = [1 1 1 1 1];   % upper Bound for logit
myTrafo    = 'logit';       % 'logit','log, or 'nat' (no transformation)

% Plotting boundaries of real-valued random variable before transformation
xmax      = 300;
dx        = .001;

% Plot numerical estimate of cumulative density function from PDF as well
doPlotCdf = false;


%% Loop over computation and plotting for different distro parameters
nDistros = numel(sigmaArray);

for iDistro = 1:nDistros
    mu = muArray(iDistro);
    sigma = sqrt(sigmaArray(iDistro)); % matlab convention transform variance -> std
    b = bArray(iDistro);
    
    switch myTrafo
        case 'nat'
            trafo = @(x) x;
            invtrafo = @(x)  x;
            ddy_invtrafo = @(y) 1;
        case 'logit'
            trafo = @(x) tapas_sgm(x,b);
            invtrafo = @(y) tapas_logit(y, b);
            ddy_invtrafo = @(y) 1./(y.*(1-y));
        case 'log'
            trafo = @(x) exp(x);
            invtrafo = @(y) log(y);
            ddy_invtrafo = @(y) 1./y;
    end
    
    
    %% Compute PDFs before/after trafo
    x = -xmax:dx:xmax;
    y = trafo(x);
    
    % Remove boundary y's (0,1 for logit)
    switch myTrafo
        case 'nat'
            y = y(y>mu-30 & y < mu+30);
        case 'logit'
            y = y(y>0 & y<b);
        case 'log'
            y = y(y>0 & y<4); % Up to + infinity, but hard to see :-)
    end
    px = normpdf(x, mu, sigma);
    
    % Using transformation of random variables:
    % p_Y(y) = p_X(g^-1(y))*abs(( d/dy g^-1(y) ))
    py = normpdf(invtrafo(y), mu, sigma).*abs(ddy_invtrafo(y));
    
    %% Plot results
    if iDistro == 1
        stringTitle = 'Conversion of probability distro of logit-Gaussian random variable';
        figure('units','normalized','outerposition',[0 0 .96 1],'Name', stringTitle);
    end
    
    stringLegend{iDistro} = sprintf('\\mu =%.1f \\sigma^2 = %.1f b = %.1f', ...
        mu, sigma^2, b);
    
    subplot(1,2,1);
    plot(x,px, 'LineWidth', 2); hold all;
    
    if iDistro == nDistros
        title('Random Variable X (logit/log space)');
        xlabel('x');
        ylabel('p(x)');
        ylim([0 4]);
        xlim([-3 3]);
        legend(stringLegend{:});
    end
    
    subplot(1,2,2);
    plot(y,py, 'LineWidth', 2); hold all;
    
    if doPlotCdf
        plot(y(1:end-1),cumsum(py(1:end-1).*diff(y)), '--');
    end
    
    if iDistro == nDistros
        title('Random Variable Y (space after transformation)');
        xlabel('y');
        ylabel('p(y)');
        ylim([0 4]);
        legend(stringLegend{:});
    end
    
end
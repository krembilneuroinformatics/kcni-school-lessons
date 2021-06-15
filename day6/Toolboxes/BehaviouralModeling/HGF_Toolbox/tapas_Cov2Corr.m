function Corr = tapas_Cov2Corr(Cov)
% Converts a covariance matrix into a correlation matrix
%
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2013 Christoph Mathys, TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.

% Check if Cov is symmetric...
if max(max(abs(Cov'-Cov))) >= eps % ...but give some tolerance, e.g. *machine precision
    nEpsMax = 300; % max number of machine precision before error is prompted
    disp('Asymmetry of Cov Matrix: abs(Cov''-Cov)')
    abs(Cov'-Cov)
    fprintf('Maximum deviation in multiples of machine precision %.1f*eps (eps=%.1e)\n', ...
        max(max(abs(Cov'-Cov)))/eps, eps);
    
    % give some slack to symmetry, and make symmetric, but stop, if error
    % too big
    if  max(max(abs(Cov'-Cov))) >= nEpsMax*eps
        error('Input matrix is not symmetric.');
    else
        % symmetrize
        Cov = (Cov+Cov')/2;
    end
end

% Check if Cov is positive-definite
if any(isinf(Cov(:))) || any(isnan(Cov(:))) || any(eig(Cov)<=0)
    error('Input matrix is not positive-definite.');
end

sdev = sqrt(diag(Cov));
Norm = sdev * sdev';
Corr = Cov./Norm;

return;

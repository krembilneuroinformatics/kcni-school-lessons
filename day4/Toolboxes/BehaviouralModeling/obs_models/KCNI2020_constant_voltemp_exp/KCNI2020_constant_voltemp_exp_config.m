function c = KCNI2020_constant_voltemp_exp_config(ptrans)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Contains the configuration for the IOIO Diaconescu et al. 2014 observation model with mu3hat as
% decision temperature
%
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2014 Christoph Mathys, Andreea Diaconescu TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.

% Config structure
c = struct;

% Model name
c.model = 'KCNI2020_constant_voltemp_exp';

% Sufficient statistics of Gaussian parameter priors

if ~nargin
    % Zeta_1
    c.logitze1mu = tapas_logit(0.5,1); 
    c.logitze1sa = 1;
    
    % Zeta_2
    c.logze2mu = log(48);
    c.logze2sa = 1;
else
    % Zeta_1
    c.logitze1mu = ptrans(1); % 0;
    c.logitze1sa = ptrans(2);
    
    % Zeta_2
    c.logze2mu = ptrans(3);
    c.logze2sa = ptrans(4);
end

% Gather prior settings in vectors
c.priormus = [
    c.logitze1mu,...
    c.logze2mu,...
    ];

c.priorsas = [
    c.logitze1sa,...
    c.logze2sa,...
    ];

% Model filehandle
c.obs_fun = @KCNI2020_constant_voltemp_exp;

% Handle to function that transforms observation parameters to their native space
% from the space they are estimated in
c.transp_obs_fun = @KCNI2020_constant_voltemp_exp_transp;

return;

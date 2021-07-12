function pstruct = tapas_hgf_transition_volconst_namep(pvec)
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2013 Christoph Mathys, TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.

ntr = 49;

pstruct = struct;

pstruct.mu2_0 = pvec(1:ntr);
pstruct.sa2_0 = pvec(ntr+1:2*ntr);
pstruct.om    = pvec(2*ntr+1);

return;

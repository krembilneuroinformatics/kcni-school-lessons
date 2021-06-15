function conditions = mmn_lowhighPE_conditions(peValues, label, options)
%MNKET_LOWHIGHPE_CONDITIONS Specifies trial type for each tone in a sequence
%based on the 'lowhighEpsi2' or 'lowhighEpsi3' definition
%   IN:     peValues    - a vector of numbers indicating trialwise pwPE
%           label       - string indicating type of pwPE (epsi2 or epsi3)
%           options     - the struct that holds all analysis options
%   OUT:    conditions  - a cell array of condition labels of length nTones
%
%   lowhighEpsi2 definition:
%   Low PE trials       - lowest (options.erp.percentPe)% of pwPE values
%   High PE trials      - highest (options.erp.percentPe)% of pwPE values
%   Other trials        - all other tones in the sequence

nValues         = length(peValues);
% we add a dummy entry in the beginning, because the prepfile_modelbased D
% still has the first trial in it, which will be removed later for
% modelbased 1st level analysis
conditions      = cell(1, nValues+1);
conditions(:)   = {'other'};

nLow    = round(options.erp.percentPE/100 *nValues);
nHigh   = nLow -1;

[sortedPE, sortIdx] = sort(peValues);

lowIdcs     = sortIdx(1: nLow);
highIdcs    = sortIdx(end-nHigh: end);

conditions(lowIdcs+1)    = {'low'};
conditions(highIdcs+1)   = {'high'};



% figure
lowValues   = sortedPE(1: nLow);
highValues  = sortedPE(end-nHigh: end);

figure; plot(peValues, '.k');
hold on;
plot([1 nValues], [max(lowValues) max(lowValues)], '-g');
plot([1 nValues], [min(highValues) min(highValues)], '-r');
legend('All PE values', ['Lowest ' num2str(options.erp.percentPE) '%'],...
                        ['Highest ' num2str(options.erp.percentPE) '%']);
title(['Low and high ' label ' values']);                    
end
function [ sumPE ] = mmn_calculate_sumPE( pwPE, tones )
%mmn_CALCULATE_SUMPE Calculates the sum of prediction errors (pwPE) across transitions
% Given a tone sequences and the precision-weighted PEs for each tone transition of a given agent,
% this function sums the PEs on all possible transitions per trial.

% The agent learns about transition probabilities, therefore, she can only have prediction errors
% starting at the second tone (the first one will be determined by her prior).

sumPE = NaN(length(tones)-1, 1);

for k = 2: length(tones)
    sumPE(k-1) = sum(squeeze(pwPE(k-1, :, tones(k-1))));
end

end
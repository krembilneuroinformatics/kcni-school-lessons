function [ peTrans ] = mmn_calculate_transitionPE( pe, tones )
%mmn_CALCULATE_TRANSITIONPE Finds the PE on the current transition for each trial. Tones has one 
%element more than PE, because there was no PE on the first input (only on the first transition).

peTrans = NaN(length(tones)-1, 1);

for k = 2 : length(tones)
   peTrans(k-1) = pe(k-1, tones(k), tones(k-1)); 
end

end

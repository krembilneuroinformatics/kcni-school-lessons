function conditions = mnket_mmnad_conditions(tones)
%MNKET_MMNAD_CONDITIONS Specifies trial type for each tone in a sequence
%based on the 'mmnad' definition that was used in Schmidt & Diaconescu et
%al., 2013, Cerebral Cortex
%   IN:     tones       - a vector of numbers indicating tone identities
%   OUT:    conditions  - a cell array of condition labels of length nTones
%
%   MMNAD definition:
%   Standard trials     - every 6th repetition of a tone
%   Deviant trials      - every 1st presentation of a tone
%   Other trials        - all other tones in the sequence

conditions = cell(1, length(tones));

conditions{1} = 'other';
stacnt = 0;
for i = 2: length(tones)
    if tones(i - 1) == tones(i)
        stacnt = stacnt + 1;
        if stacnt == 6
            conditions{i} = 'standard';
        else
            conditions{i} = 'other';
        end
    else
        conditions{i} = 'deviant';
        stacnt = 0;
    end
end 

end
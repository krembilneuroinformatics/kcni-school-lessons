function conditions = mnket_roving_conditions(tones)
%MNKET_ROVING_CONDITIONS Specifies trial type for each tone in a sequence
%based on the 'roving' definition
%   IN:     tones       - a vector of numbers indicating tone identities
%   OUT:    conditions  - a cell array of condition labels of length nTones
%
%   Roving definition:
%   Standard trials     - every 6th repetition of a tone
%   Deviant trials      - every 1st presentation of a tone that is preceded
%                       by at least 6 repetitions of another tone
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
        if stacnt > 5
            conditions{i} = 'deviant';
        else
            conditions{i} = 'other';
        end
        stacnt = 0;
    end
end 

end
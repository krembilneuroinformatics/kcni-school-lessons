function conditions = mnket_memory_conditions(tones)
%MNKET_MEMORY_CONDITIONS Specifies trial type for each tone in a sequence
%based on the 'memory' definition
%   IN:     tones       - a vector of numbers indicating tone identities
%   OUT:    conditions  - a cell array of condition labels of length nTones
%
%   Memory definition:
%   Standard trials     - every 6th repetition of a tone
%   DevNREP trials      - every 1st presentation of a tone, where the
%                       number of preceding repetitions of a different tone
%                       is indicated by NREP 
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
        if stacnt > 3
            conditions{i} = ['dev' num2str(stacnt)];
        else
            conditions{i} = 'other';
        end
        stacnt = 0;
    end
end 

end
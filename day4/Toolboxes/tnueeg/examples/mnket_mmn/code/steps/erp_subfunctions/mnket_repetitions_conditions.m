function conditions = mnket_repetitions_conditions(tones)
%MNKET_REPETITIONS_CONDITIONS Specifies trial type for each tone in a 
%sequence based on the 'repetitions' definition
%   IN:     tones       - a vector of numbers indicating tone identities
%   OUT:    conditions  - a cell array of condition labels of length nTones
%
%   Repetitions definition:
%   StanNREP trials     - every repetition of a tone, where the number of
%                       repetitions is indicated by NREP
%   DevNREP trials      - every 1st presentation of a tone, where the
%                       number of preceding repetitions of a different tone
%                       is indicated by NREP
%   First trial         - the first tone in the sequence

conditions = cell(1, length(tones));

conditions{1} = 'first';
stacnt = 1;
for i = 2: length(tones)
    if tones(i - 1) == tones(i)
        stacnt = stacnt + 1;
        conditions{i} = ['stan' num2str(stacnt)];
    else
        conditions{i} = ['dev' num2str(stacnt)];
        stacnt = 1;
    end
end 

end
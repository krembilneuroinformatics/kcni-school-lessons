function [ indices ] = tnueeg_find_indices_of_value_in_mixed_cell_array( cellArray, value)
%TNUEEG_FIND_INDICES_OF_VALUE_IN_MIXED_CELL_ARRAY Finds all occurences of a numeric or string value
%in a (mixed) cell array and outputs the indices of these occurences
%   IN:     cellArray   - can have mixed (i.e., numeric and string) entries
%           value       - value of interest (can be numeric or string)
%   OUT:    indices     - indices of all occurences of the value in the cellArray

indices = [];

switch isnumeric(value)
    case 1
        for iEntry = 1: numel(cellArray)
            if isnumeric(cellArray{iEntry})
                if cellArray{iEntry} == value
                    indices = [indices iEntry];
                end
            end
        end
    case 0
        for iEntry = 1: numel(cellArray)
            if strcmp(cellArray{iEntry}, value)
                indices = [indices iEntry];
            end
        end
end



end


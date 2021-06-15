function tones = mnket_create_model_tone_sequence( id, options, details, paths )
%MNKET_CREATE_MODEL_TONE_SEQUENCE Returns the tone sequence a given subject
%from the MNKET study was exposed to.
%modeling.
%   IN:     id      - subject identifier string, e.g. '0001'
%           options - the struct that holds all analysis options
%           details - the struct that holds all subject-specific paths and
%                   filenames
%           paths   - the struct that holds all general paths and filenames
%   OUT:    tones   - vector of tones (numbers 1:7) for subject id

switch id
    % we only have textfiles for these subjects:
    case {'4534', '4507', '4459', '4422', '4478'} 
        TXTtones = mnket_read_tones_from_txtfile(details.tonestxt);
    
    % we have a text file and the paradigm struct for the rest:    
    otherwise 
        TXTtones = mnket_read_tones_from_txtfile(details.tonestxt);
        
        load(paths.paradigm)
        switch options.condition
            case 'placebo'
                data = paradigm.Placebo;
            case 'ketamine'
                data = paradigm.Ketamine;
        end
        MATtones = mnket_read_tones_from_matfile(id, data);
    
        if ~isequal(TXTtones, MATtones)
            warning(['Files do not agree on subject ' id ...
                ' for condition ' options.condition]);
        end
end

tones = TXTtones;

end

function tones = mnket_read_tones_from_txtfile( fileName )
%MNKET_READ_TONES_FROM_TXTFILE Reads the tone sequence of a subject as
%saved in the subject's tones textfile.
% IN:   id      - subject identifier string, e.g. '0001'
%       data    - a subfield from the paradigm struct containing the tone
%               sequences of all subjects from one condition
% OUT:  tones   - the tone sequence

tones = [];
nTon = 0;

fileID = fopen(fileName, 'r');
A = fscanf(fileID, '%s');
fclose(fileID);

A(1: 11) = [];

for i = 1: length(A)
    if ~isempty(str2double(A(i))) && ~isnan(str2double(A(i)))
        nTon = nTon + 1;
        tones(nTon) = str2double(A(i));
    end
end

tones = tones';

end


function tones = mnket_read_tones_from_matfile(id, data)
%MNKET_READ_TONES_FROM_MATFILE Finds the tone sequence of a subject as
%saved in the data struct.
% IN:   id      - subject identifier string, e.g. '0001'
%       data    - a subfield from the paradigm struct containing the tone
%               sequences of all subjects from one condition
% OUT:  tones   - the tone sequence

for sub = 1: numel(data)
    if strcmp(num2str(data{sub}.sub_nr), id)
        tones = data{sub}.tones;
    end
end

end

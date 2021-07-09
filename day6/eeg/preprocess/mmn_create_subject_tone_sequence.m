function tones = mmn_create_subject_tone_sequence( id, options, details, paths )
%mmn_CREATE_SUBJECT_TONE_SEQUENCE Returns the tone sequence a given subject
%from the mmn study was exposed to.
%modeling.
%   IN:     id      - subject identifier string, e.g. '0001'
%           options - the struct that holds all analysis options
%           details - the struct that holds all subject-specific paths and
%                   filenames
%           paths   - the struct that holds all general paths and filenames
%   OUT:    tones   - vector of tones (numbers 1:7) for subject id


load(paths.paradigm)

data = paradigm.Placebo;

MATtones = mmn_read_tones_from_matfile(id, data);


tones = MATtones;

end


function tones = mmn_read_tones_from_matfile(id, data)
%mmn_READ_TONES_FROM_MATFILE Finds the tone sequence of a subject as
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

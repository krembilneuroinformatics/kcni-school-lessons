function [ tones ] = mnket_find_subject_tones( id, options, details, paths )
%MNKET_FIND_SUBJECT_TONES Returns the tone sequence a given subject was
%exposed to
%   IN:     id
%           options
%           paths
%   OUT:    tones

load(paths.paradigm)

switch options.condition
    case 'placebo'
        data = paradigm.Placebo;
    case 'ketamine'
        data = paradigm.Ketamine;
end

tones = [];

switch id
    case {'4459', '4507', '4422', '4478'}
        t = load(details.tonesfile);
        tones = t.TXTtones;
    case {'4534'}
        t = load(details.tonesfile);
        tones = t.TXTtones;
        switch options.condition
            case {'ketamine'}
                tones(1: 29) = [];
        end
    otherwise
        for i = 1: numel(data)
            if strcmp(id, num2str(data{i}.sub_nr))
                tones = data{i}.tones;
                break;
            end
        end
end

if isempty(tones)
    error('No stimulus data for this subject found!')
end

save(details.eegtones, 'tones');

end


function [ chandef ] = mmn_channel_definition( paths )
%mmn_CHANNEL_DEFINTION Channel definition for mmn MMN EEG data sets
%   IN:     paths       - struct that holds all general paths
%   OUT:    chandef     - struct with as many fields as channel types

chandef{1}.type = 'EOG';
chandef{1}.ind = [65 66 69 70];

save(paths.channeldef, 'chandef');

end


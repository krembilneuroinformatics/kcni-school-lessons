function [ chandef ] = dprst_channel_definition(D, paths, options )
%DPRST_CHANNEL_DEFINTION Channel definition for DPRST MMN EEG data sets
%   IN:     D           - EEG data set with all channels
%           paths       - the struct that holds all general files & paths
%           options     - the struct that holds all analysis options
%   OUT:    chandef     - struct with as many fields as channel types

chandef{1}.type = 'EEG';
chandef{1}.ind = [1:19 20:64];

chandef{2}.type = 'EOG';
chandef{2}.ind = 20;
    
switch options.part
    case 'anta'
        if nchannels(D) == 65
            chandef{3}.type = 'pulse';
            chandef{3}.ind = 65;
        end
    case 'agon'
        chandef{3}.type = 'ECG';
        chandef{3}.ind = 65;

        chandef{4}.type = 'pulse';
        chandef{4}.ind = 66;
end

save(paths.channeldef, 'chandef');

end


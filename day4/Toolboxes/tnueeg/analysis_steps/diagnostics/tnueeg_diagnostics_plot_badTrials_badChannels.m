function fh = tnueeg_diagnostics_plot_badTrials_badChannels(D, options, type)
%TNUEEG_DIAGNOSTICS_PLOT_BADTRIALS_BADCHANNELS Plots data from channels and trials where the
%badtrial threshold (options.preproc.badtrialthresh) was exceeded.
%	IN:     D       - M/EEG data set with bad trials
%           options - the struct that holds all analysis options
%           type    - plot either all bad channels for every trial: badt
%                   - or all bad trials for every channel: badc
%   OUT:    fh      - handle to the figure created
% Written by S.Iglesias, 13/12/2017
% Modified 01/02/2018 to be included in TNUEEG toolbox.

%-- preparation -----------------------------------------------------------------------------------%
step = type;
channels = {'EEG'};
threshold = options.preproc.badtrialthresh;

% load M/EEG data set after rejection of remaing artifacts
if ischar(D)
    Dpath = spm_file(D, 'path');
    D = spm_eeg_load(D);
elseif isa(D, 'meeg')
    Dpath = D.path;
end

cd(Dpath)

chanIdx = D.selectchannels(channels);
chanLbl = chanlabels(D);
chanLbl = chanLbl(chanIdx);

% create empty nchannels-x-ntrials matrix
res = zeros(D.nchannels, D.ntrials);

% find channels and trials with artefacts
for i = 1:D.ntrials
    res(chanIdx, i) = squeeze(max(abs(D(chanIdx, :, i)), [], 2)) > threshold;
end

[ichannel, jtrial] = find(res == 1);

if strcmp(step, 'badt')
    %-- create plot across all bad channels for every bad trial -----------------------------------%
    for t = 1: D.ntrials
        [i, ~] = find(jtrial == t);
        if ~isempty(i)
            fh = figure;
            for s = 1:length(i)
                if length(i) < 4
                    h(t)=subplot(1, length(i), s); plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                else
                    f = factor(length(i));
                    if length(f) == 1
                        if f > 10
                            h(t) = subplot(ceil((length(i)/6)), 6, s);
                            plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                        else
                            h(t) = subplot(floor(0.5*(length(i))), ceil(0.5*(length(i))), s);
                            plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                        end
                    elseif length(f) == 2
                        h(t) = subplot(f(1),f(2),s);
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    elseif length(f) == 3
                        h(t) = subplot(f(3),f(1)*f(2),s);
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    elseif length(f) == 4
                        h(t) = subplot(f(3)*f(2),f(1)*f(4),s);
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    elseif length(f) == 5
                        h(t) = subplot(f(3)*f(2)*f(1),f(5)*f(4),s);
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    end
                end
                title(['channel: ', chanLbl{ichannel(i(s))}, ' trial: ', num2str(jtrial(i(s)))]);
                xlim([0 D.time(end)]);
                hold on; 
                plot([0 D.time(end)], [threshold threshold], 'red');
                plot([0 D.time(end)], [-threshold -threshold], 'red');
            end
            linkaxes(h);
            savefig(fh, ['trial_ ', num2str(jtrial(i(1)))])
            close(fh);
        end
    end
    
elseif strcmp(step, 'badc')
    
    %-- create plot across all bad trials for every bad channel -----------------------------------%
    for t = 1: D.nchannels
        [i, ~] = find(ichannel == t);
        if ~isempty(i)
            fh = figure;
            for s = 1: length(i)
                if length(i) < 4
                    h(t) = subplot(1,length(i),s); 
                    plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                else
                    f = factor(length(i));
                    if length(f) == 1
                        if f > 10
                            h(t) = subplot(ceil((length(i)/6)),6,s);
                            plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                        else
                            h(t) = subplot(floor(0.5*(length(i))),ceil(0.5*(length(i))),s);
                            plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                        end
                    elseif length(f) == 2
                        h(t) = subplot(f(1),f(2),s); 
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    elseif length(f) == 3
                        h(t) = subplot(f(3),f(1)*f(2),s); 
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    elseif length(f) == 4
                        h(t) = subplot(f(3)*f(2),f(1)*f(4),s); 
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    elseif length(f) == 5
                        h(t) = subplot(f(3)*f(2)*f(1),f(5)*f(4),s); 
                        plot(D.time, D(ichannel(i(s)), :, jtrial(i(s))));
                    end
                end          
                title(['Channel: ', chanLbl{ichannel(i(s))}, ' trial: ', num2str(jtrial(i(s)))]);
                xlim([0 D.time(end)]);
                hold on;
                plot([0 D.time(end)], [threshold threshold], 'red');
                plot([0 D.time(end)], [-threshold -threshold], 'red');
            end   
            linkaxes(h);
            savefig(fh, ['channel_ ', chanLbl{ichannel(i(1))}]);
            close(fh);     
        end
    end
end

end




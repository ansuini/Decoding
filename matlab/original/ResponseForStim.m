function [L, S] = ResponseForStim(Spikes,bcod,Stim,Neu,ResWin)
L = [];
S = [];
for j = 1:length(Stim)
    stimIdx = bcod.data == Stim(j);
    timeIdx = strcmp(Spikes.header, 'time');
    neuIdIdx = strcmp(Spikes.header, 'neuId');
    onset = bcod.onset(stimIdx);
    for i = 1:length(onset)
        spkResponseIdx = (Spikes.spikes(:,timeIdx) > ((onset(i)*1000) + ResWin(1))) & ...
            (Spikes.spikes(:, timeIdx) < ((onset(i)*1000) + ResWin(2))) & ...
            Spikes.spikes(:, neuIdIdx) == Neu;
        L = [L; sum(spkResponseIdx)];
    end
    S = [S ones(1,length(onset))*Stim(j)];
end
end
clear all
LoadPath = '/Users/labuser/Desktop/Experiments/SISSA/data/Virtual Cages/Acute recordings'; 
%ALESSIO: cambia questo path e lo scripts dovrebbe andare bene cosi' com'e', ti bastera' togliere quel 'sum' da dentro la funzione 'ResponseForStim'

Names = {'Sel_controls_V1_SUs.mat','Sel_controls_LL_SUs.mat','Sel_experimentals_V1_SUs.mat','Sel_experimentals_LL_SUs.mat'};
Names_MUA = {'Sel_controls_V1_MUA.mat','Sel_controls_LL_MUA.mat','Sel_experimentals_V1_MUA.mat','Sel_experimentals_LL_MUA.mat'};


%% CONTROLS V1

% SINGLE UNITS

disp('****** CONTROLS V1: Single Units *******')
load([LoadPath '/' Names{1}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end
for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Controls/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_Good.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Controls/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
end
IDRes.V1.SU = R;
save(fullfile(LoadPath,'IDResponse_controls.mat'),'IDRes')
clear R

% MULTI UNITS
disp('****** CONTROLS V1: Multi Units *******')
load([LoadPath '/' Names_MUA{1}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end

for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Controls/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_MUA.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Controls/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
    R{j}.Type = 'MUA';
end
IDRes.V1.MU = R;

save(fullfile(LoadPath,'IDResponse_controls.mat'),'IDRes')
clear R

%% Controls LL

% SINGLE UNITS
disp('****** CONTROLS LL: Single Units *******')
load([LoadPath '/' Names{2}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end
for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Controls/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_Good.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Controls/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
end
IDRes.LL.SU = R;
save(fullfile(LoadPath,'IDResponse_controls.mat'),'IDRes')
clear R

% MULTI UNITS
disp('****** CONTROLS LL: Multi Units *******')
load([LoadPath '/' Names_MUA{2}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end

for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Controls/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_MUA.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Controls/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
    R{j}.Type = 'MUA';
end
IDRes.LL.MU = R;

save(fullfile(LoadPath,'IDResponse_controls.mat'),'IDRes')
clear R



%% Experimentals V1

clear IDRes
% SINGLE UNITS
disp('****** EXPERIMENTALS V1: Single Units *******')
load([LoadPath '/' Names{3}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end
for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Experimentals/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_Good.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Experimentals/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
end
IDRes.V1.SU = R;
save(fullfile(LoadPath,'IDResponse_experimentals.mat'),'IDRes')
clear R
load('IDResponse_experimentals.mat')

%MULTI UNITS
disp('****** EXPERIMENTALS V1: Multi Units *******')
load([LoadPath '/' Names_MUA{3}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end

for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Experimentals/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_MUA.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Experimentals/V1/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
    R{j}.Type = 'MUA';
end
IDRes.V1.MU = R;

save(fullfile(LoadPath,'IDResponse_experimentals.mat'),'IDRes')
clear R

%% Experimentals LL

%SINGLE UNITS
disp('****** EXPERIMENTALS LL: Single Units *******')
load([LoadPath '/' Names{4}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end
for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Experimentals/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_Good.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Experimentals/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
end
IDRes.LL.SU = R;
save(fullfile(LoadPath,'IDResponse_experimentals.mat'),'IDRes')
clear R

% MULTI UNITS
disp('****** EXPERIMENTALS LL: Multi Units *******')
load([LoadPath '/' Names_MUA{4}])
S = unique(Neuron.Session);
for i = 1:length(S)
    ind = find(strcmp(Neuron.Session,S{i})==1);
    for j = 1:length(ind)
        Neuron.Session{ind(j)} = strrep(S{i},'/','_');
    end
end

for j = 1:size(Neuron,1)
    disp(sprintf('Neu %d',j))
    loadname = [LoadPath '/' 'Experimentals/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/' Neuron.Session{j} '_blk' num2str(Neuron.Block(j)) '_MUA.mat'];
    jNeu = load(loadname);

    loadname = [LoadPath '/' 'Experimentals/LL/' Neuron.Session{j} '/Block-' num2str(Neuron.Block(j)) '/', 'UDPB.mat'];
    bcod = load(loadname);

    jR = [];
    jSId = [];

    for k = 1:1440
        [Rtemp, Stemp] = ResponseForStim(jNeu,bcod,k,Neuron.Id(j),Neuron.Window(j,:));
        jR = [jR Rtemp'];
        jSId = [jSId Stemp];
    end
    R{j}.Stim = jSId;
    R{j}.Resp = jR;
    R{j}.Session = Neuron.Session{j};
    R{j}.Block = Neuron.Block(j);
    R{j}.Id = Neuron.Id(j);
    R{j}.Type = 'MUA';
end
IDRes.LL.MU = R;

save(fullfile(LoadPath,'IDResponse_experimentals.mat'),'IDRes')
clear R

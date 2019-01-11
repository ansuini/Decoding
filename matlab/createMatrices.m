ccc


% modifiers

SAVE       = 1;
CREATE_ALL = 1;

% paths

ROOT = 'C:\Users\aless\Dropbox\Work\Projects\Decoding';
cd(ROOT)
dataFolder = fullfile(ROOT,'data','raw');
destFolder = fullfile(ROOT,'data','processed');

% names of the experiments
names = {'Sel_controls_LL','Sel_controls_V1','Sel_experimentals_LL',...
    'Sel_experimentals_V1', 'Sel_naives_V1', 'Sel_naives_LM', ...
    'Sel_naives_LI', 'Sel_naives_LL'};
   
typeUnits = {'MUA','SUs'};

names_all = {};

%% create MUA and SU separately

for i = 1:numel(names)
    for j = 1:2
              
        filename = [names{i}, '_', typeUnits{j}, '.mat'];
        names_all{ (i-1)*2 + j} = filename;
        fprintf('Processing %s\n', filename);   
        load(fullfile(dataFolder, filename) )
        
        % session information
        S = getSessionsNumbers(Data(:,1).Variables);
                             
        % create firing rate matrix
        I = [S, Data(:,[2,3,4,7,8]).Variables];

        % psths
        %X = Data(:,2:end).Variables;
        %X = X(:,4:403);

        if SAVE    
            %save(fullfile(destFolder, ['X_',filename]),'X')
            save(fullfile(destFolder, ['I_', filename]),'I')
        end
        
    end
end
%% create MUA and SUs togheter

if CREATE_ALL
    for i = 1:numel(names)
           
        fprintf('Creating %s\n', [names{i},'_ALL.mat']);   
        
        load(fullfile(dataFolder, [names{i}, '_MUA.mat']) )             
        S1 = getSessionsNumbers(Data(:,1).Variables);        
        I1 = [S1, Data(:,[2,3,4,7,8]).Variables];
               
        %X1 = Data(:,2:end).Variables;
        %X1 = X1(:,4:403);

        load(fullfile(dataFolder, [names{i}, '_SUs.mat']) )
        S2 = getSessionsNumbers(Data(:,1).Variables);
        I2 = [S2, Data(:,[2,3,4,7,8]).Variables];
        
        %X2 = Data(:,2:end).Variables;
        %X2 = X2(:,4:403);

        I = [I1;I2];
        %X = [X1;X2];

        if SAVE
            %save(fullfile(destFolder,[names{i}, '_ALL.mat'] ),'X')
            save(fullfile(destFolder, ['I_', names{i}, '_ALL.mat']),'I')
        end
        
        
        
       
    end
end

% add names of _ALL files

names_all{17} = 'Sel_controls_LL_ALL.mat';
names_all{18} = 'Sel_controls_V1_ALL.mat';
names_all{19} = 'Sel_experimentals_LL_ALL.mat';
names_all{20} = 'Sel_experimentals_V1_ALL.mat';
names_all{21} = 'Sel_naives_V1_ALL.mat';
names_all{22} = 'Sel_naives_LM_ALL.mat';
names_all{23} = 'Sel_naives_LI_ALL.mat';
names_all{24} = 'Sel_naives_LL_ALL.mat';
 
if SAVE  
    save(fullfile(destFolder,'names'),'names_all')
end
    


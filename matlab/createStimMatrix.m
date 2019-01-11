ccc

ROOT = 'C:\Users\aless\Dropbox\Work\Projects\Decoding';
cd(ROOT)
dataFolder = fullfile(ROOT,'data','raw');
destFolder = fullfile(ROOT,'data','processed');

% imgdata
load(fullfile(dataFolder,'stimFeats_last.mat'))

X = [];

%%
X(:,1) = imgData{:,1};     % stim
X(:,2) = imgData{:,2};     % area
X(:,3:4) = imgData{:,3};   % centroid coordinates
X(:,5:8) = imgData{:,4};   % box
X(:,9) = imgData{:,6};     % maj ax
X(:,10) = imgData{:,7};    % min ax
X(:,11) = imgData{:,8};    % ecc
X(:,12) = imgData{:,9};    % ori
X(:,13) = imgData{:,12};    % convex area
X(:,14) = imgData{:,15};    % filled area
X(:,15) = imgData{:,23};    % perimeter
X(:,16) = imgData{:,25};    % rms contrast
X(:,17) = imgData{:,26};    % max lum
X(:,18) = imgData{:,27};    % mean lum
X(:,19) = imgData{:,28};    % int lum
X(:,20) = imgData{:,29};    % int obj lum
X(:,21) = imgData{:,30};    % obj id (category)


save(fullfile(destFolder,'stimFeatures.mat'),'X')






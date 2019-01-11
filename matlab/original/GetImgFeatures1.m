function [ feats ] = GetImgFeatures( folder )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

files = dir(fullfile(folder, '*.png'));
LumGray = 0.5; %To check with the real gray level... 0.5?
for i=1:length(files)
    if ~nnz(ismember(files(i).name,'_')) %skip hidden files
        [img, ~, alpha] = imread(fullfile(folder,files(i).name));
        if size(img,3) ~=3 && isempty(alpha)
            warning('Invalid image, skipping to the next one')
        end

        if isempty(alpha)
            binImg = ~((img(:,:,1) == 255) | (img(:,:,2) == 0) | (img(:,:,3) == 0));
        else
            binImg = alpha > 0;
        end

        tmpFeats = regionprops(binImg, 'all');
        [~, featsIdx] = max([tmpFeats.Area]);

        feats(i) = tmpFeats(featsIdx);                                          %#ok<AGROW>
        
        %calculate image contrast as RMS
        cont(i).RMScontrast = sqrt(mean(double(img(feats(i).PixelIdxList)).^2));
        
        %calculate luminance
        lum(i).Luminance = mean(double(img)) - LumGray;
    end
end
for i = 1:length(files)
    feats(i).RMScontrast = cont(i).RMScontrast;
    feats(i).Luminance = lum(i).Luminance;
end
end


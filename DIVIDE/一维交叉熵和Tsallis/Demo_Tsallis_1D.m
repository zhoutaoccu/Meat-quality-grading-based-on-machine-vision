addpath('images')

clc 
% img = imread('E:\Dropbox\DYM Exp. Images\BSD\train_5.jpg');
% img = imread('1.4.08.tiff'); % Brick wall
% img = rgb2gray(imread('E:\Dropbox\DYM Exp. Images\ÈéÆ·\·¢½ÍÈé¸Ë¾ú.jpg'));
% img = imread('FMI_06.bmp'); img = img(:,:,1);
% img = imread('E:\Dropbox\DYM Exp. Images\misc\7.2.01.tiff');
img = rgb2gray(imread('niurou.jpg'));
% img = imread('E:\Dropbox\DYM Exp. Images\misc\boat.512.tiff');
% img = imread('E:\Dropbox\DYM Exp. Images\misc\elaine.512.tiff');
% img = rgb2gray(imread('E:\Dropbox\DYM Exp. Images\misc\house.tiff'));
% img = imread('E:\Dropbox\DYM Exp. Images\misc\5.1.13.tiff');
sigma = 0;
img = imnoise(img, 'gaussian', 0, (sigma/255)^2);
minGray = double(min(img(:)));
maxGray = double(max(img(:)));
histVec = imhist(img);
probVec = histVec / sum(histVec);
L = 256;
SVec = -inf(L,1);

% q = 1.1;
q = 0.5;
tic
for t = minGray+1:maxGray-1
    PA = sum(probVec(1:t));
    SA = (1 - sum((probVec(1:t)/PA).^q)) / (q-1);
    PB = sum(probVec(t+1:L));
    SB = (1 - sum((probVec(t+1:L)/PB).^q)) / (q-1);
    SVec(t) = SA + SB + (1-q)*SA*SB;
%     SVec(t) = SA + SB;
end
figure; plot(SVec)
[~,bestT] = max(SVec);
toc
bestT = bestT - 1;
 figure; imshow(img>=bestT); title(['Tsallis Entropy T=', num2str(bestT)]);
% imwrite(img>=bestT, 'BrickWall_Tsallis_q_1.1_1D.bmp')
% imwrite(img>=bestT, 'FMI_Tsallis_1D.bmp')
% imwrite(img>=bestT, 'saccharomycete_Tsallis_1D.bmp')
% imwrite(img>=bestT, 'BrickWall_Tsallis_1D.bmp')
% imwrite(img>=bestT, 'FMI_Tsallis_q_1.1_1D.bmp')
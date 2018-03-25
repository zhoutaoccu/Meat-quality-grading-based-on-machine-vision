addpath('images')
% img = imread('D:\Dropbox\DYM Exp. Images\misc\4.2.04.tiff');
% img = imread('D:\Dropbox\DYM Exp. Images\Baboon.tiff');

% % img = imread('1.4.08.tiff'); % Brick wall
% img = imread('D:\Dropbox\DYM Exp. Images\misc\5.2.09.tiff'); % Brick wall
% img = imread('D:\Dropbox\DYM Exp. Images\misc\boat.512.tiff'); % Brick wall
% img = imread('D:\Dropbox\DYM Exp. Images\fvc 2002 series 2\101_5.tif');
% img = imread('D:\Dropbox\DYM Exp. Images\textures\1.4.01.tiff'); % Brick wall
% img = imread('D:\Dropbox\DYM Exp. Images\SAR River\sar.gif') ;
% img = padarray(img, [5 5]);
% img = rgb2gray(imread('D:\Dropbox\DYM Exp. Images\SAR River\SAR radar DC.jpg'));
% img = rgb2gray(imread('D:\Dropbox\DYM Exp. Images\SAR River\piperiver.jpg'));
% img = imread('D:\Dropbox\DYM Exp. Images\house.png');
% img = rgb2gray(imread('D:\Dropbox\DYM Exp. Images\乳品\发酵乳杆菌.jpg'));
% img = imread('FMI_06.bmp'); img = img(:,:,1);
% img = imread('D:\Dropbox\DYM Exp. Images\misc\7.2.01.tiff');
% img = rgb2gray(imread('D:\Dropbox\DYM Exp. Images\misc\4.1.01.tiff'));
% img = imread('D:\Dropbox\DYM Exp. Images\misc\boat.512.tiff');
% img = imread('D:\Dropbox\DYM Exp. Images\misc\elaine.512.tiff');
% img = rgb2gray(imread('D:\Dropbox\DYM Exp. Images\misc\house.tiff'));
% img = imread('D:\Dropbox\DYM Exp. Images\textures\1.4.07.tiff'); % Brick wall
% img = rgb2gray(img);
% img = imread('D:\Dropbox\DYM Exp. Images\pic\previewImg1.jpg');
% img = imread('D:\Dropbox\DYM Exp. Images\pic\课题实验测试图像（金相、海岸线、蓝藻水华、煤矿火灾、乳品细菌、Thz、文档）n\课题实验测试图像（金相、海岸线、蓝藻水华、煤矿火灾、乳品细菌、Thz、文档）\海岸线\9.jpg');
img = imread('niurou.jpg');
% img = imread('D:\Dropbox\DYM Exp. Images\Fish\sea-fish.png');
if (size(img,3) > 1)
    img = rgb2gray(img);
end
histVec = imhist(img)';
probVec = histVec / sum(histVec);
L = 256;
etaVec = -inf(L,1);
aVec = -inf(L,1);
bVec = -inf(L,1);
tic
for t = 2:L-1
    mu1 = sum(histVec(1:t).*[1:t]) / sum(histVec(1:t));
    mu2 = sum(histVec(t+1:L).*[t+1:L]) / sum(histVec(t+1:L));
%     etaVec(t) = sum([1:t].*histVec(1:t).*log((1:t)/mu1)) + ...
%                 sum([t+1:L].*histVec(t+1:L).*log((t+1:L)/mu2));
    etaVec(t) = sum([1:t].*histVec(1:t).*log((1:t)/mu1)) .* ...
                sum([t+1:L].*histVec(t+1:L).*log((t+1:L)/mu2));
    aVec(t) = sum([1:t].*histVec(1:t).*log((1:t)/mu1));
    bVec(t) = sum([t+1:L].*histVec(t+1:L).*log((t+1:L)/mu2));
end
[~,bestT] = max(etaVec);
toc
bestT = bestT - 1;
figure; imshow(img>=bestT); title(['Minimum Cross Entropy T=', num2str(bestT)]);
% figure; plot(etaVec);
% figure; plot(aVec); title('a')
% figure; plot(bVec); title('b')
% imwrite(img>=bestT, 'FMI_Cross_1D.bmp')
% imwrite(img>=bestT, 'UrbanBuilding_Cross_1D.bmp')
% imwrite(img>=bestT, 'Shoreline_Cross_1D.bmp')
imwrite(img>=bestT, 'LicensePlate_Cross_1D.bmp')
% imwrite(img>=bestT, 'saccharomycete_Cross_1D.bmp')
% imwrite(img>=bestT, 'BrickWall_Cross_1D.bmp')
% imgName = [num2str(floor(rand*10000000)) '.jpg'];
% imwrite(threshImg, 'Cross_1D-UrbanBuilding.bmp')
% imwrite(double(nimg)>bestT, imgName);
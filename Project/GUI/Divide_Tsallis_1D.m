function [ output ] = Divide_Tsallis_1D( img )
%   Divide photo by 1D Tsallis
%img = imnoise(img, 'gaussian', 0, (sigma/255)^2);
%img=rgb2gray(img);
%  img = edge(img ,'sobel');
%  figure;
%  imshow(img);
minGray = double(min(img(:)));
maxGray = double(max(img(:)));
histVec = imhist(img);
probVec = histVec / sum(histVec);
L = 256;
SVec = -inf(L,1);

% q = 1.1;
q = 0.5;
% tic
for t = minGray+1:maxGray-1
    PA = sum(probVec(1:t));
    SA = (1 - sum((probVec(1:t)/PA).^q)) / (q-1);
    PB = sum(probVec(t+1:L));
    SB = (1 - sum((probVec(t+1:L)/PB).^q)) / (q-1);
    SVec(t) = SA + SB + (1-q)*SA*SB;
%     SVec(t) = SA + SB;
end
% figure; plot(SVec)
 [~,bestT] = max(SVec);
% toc
bestT = bestT - 1;
output=img>=bestT;






function [ output ] = Demo_Cross_1D( img)

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
% figure; imshow(img>=bestT); title(['Minimum Cross Entropy T=', num2str(bestT)]);
% 
% imwrite(img>=bestT, 'LicensePlate_Cross_1D.bmp')
output=img>=bestT;

end


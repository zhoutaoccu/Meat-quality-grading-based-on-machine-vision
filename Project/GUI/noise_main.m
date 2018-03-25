

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
clc
close all
clf
colormap(gray)
sigma=5;
a = imread('rank6.jpg');
subplot(1,3,1)
imshow(a);
%aa=a;
if size(a,3) > 1
    aa = rgb2gray(a);
%     aa(:,:,1) = Gray;
%     aa(:,:,2) = Gray;
%     aa(:,:,3) = Gray;
subplot(1,3,2)
size(aa)
imshow(aa);
end
aa=double(aa);
ima=aa+sigma*randn(size(aa));


subplot(1,3,3)
size(ima)
imagesc(ima);
drawnow
%imshow(ima);
ima=uint8(ima);
imwrite(ima,'noised.jpg');
output=ima;



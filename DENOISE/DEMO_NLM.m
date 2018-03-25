clear
close all
clc
clf
colormap(gray)

% create example image
ima = imread('lenna.jpg');
if size(ima,3) > 1
    ima = rgb2gray(ima);
end
figure (1);
imshow(ima);

	
% add some noise
sigma=10;
ima=double(ima);
rima=ima+sigma*randn(size(ima));
tic;
K2=filter2(fspecial('average',3),rima)/255;
toc;
tic;
K= medfilt2(rima);
toc;
% show it
imagesc(rima)
drawnow

% denoise it
tic;
fima=NLmeansfilter(rima,5,2,sigma);
toc;
% show results

figure (2);
subplot(2,2,1),imagesc(ima),title('original');ima1=uint8(ima);imwrite(ima1,'original.jpg');
subplot(2,2,2),imagesc(rima),title('noisy');rima=uint8(rima);imwrite(rima,'noisy.jpg');
subplot(2,2,3),imagesc(fima),title('filtered');fima=uint8(fima);imwrite(fima,'ofiltered.jpg');
subplot(2,2,4),imagesc(rima-fima),title('residuals');

colormap(gray);

figure(3);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
subplot(2,2,1);imagesc(ima),title('ԭʼͼ��');
subplot(2,2,2);imagesc(K2),title('��ֵ�˲�');imwrite(K2,'��ֵ�˲�.jpg');%K2=uint8(K2);
subplot(2,2,3);imagesc(K),title('��ά��ֵ�˲�');K=uint8(K);imwrite(K,'��ά��ֵ�˲�.jpg');
subplot(2,2,4);imagesc(fima),title('�Ǿֲ���ֵ�˲�');

colormap(gray);
im0=imread('noisy.jpg');
im1=imread('original.jpg');
im2=imread('��ֵ�˲�.jpg');
im3=imread('��ά��ֵ�˲�.jpg');
im4=imread('ofiltered.jpg');
noise=Psnr( im1,im0 )
jun=Psnr( im1,im2 )
zhong=Psnr( im1,im3 )
nonlocal=Psnr( im1,im4 )

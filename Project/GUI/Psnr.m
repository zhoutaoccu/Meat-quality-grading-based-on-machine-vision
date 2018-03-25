
function [ PSNR,MSE ] = Psnr( im1,im2 )

%------------------------�����ֵ����ȳ��򡪡���������������������������-----
% im1 : the original image matrix
% im2 : the modified image matrix   

if (size(im1))~=(size(im2))
    error('������������ͼ��Ĵ�С��һ��');
end

    [m,n] = size(im1);
    A = double(im1);
    B = double(im2);
    D = sum( sum( (A-B).^2 ) );%||A-B||^2
    MSE = D / (m * n);
if  D == 0
    error('����ͼ����ȫһ��');
    PSNR = 200;
else
    PSNR = 10*log10( (255^2) / MSE );                                                        
end
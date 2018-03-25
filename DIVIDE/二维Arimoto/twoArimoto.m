%��ͼ��Ķ�άTsallis��
%˼·��1������ͼ��Ķ�άֱ��ͼ
clear all;
close all;
im=imread('niurou.jpg');
% im=imread('E:\����\�������\ȥ��(ȥ��Ƶ��,����0.008)\01.jpg');
mysize=size(im);
if numel(mysize)==3
   im=rgb2gray(im);
end
% im=imnoise(im,'gaussian',0.05);
im=double(im);
imm=im;%����ԭͼ��
q=0.8;
a=0.2;%�Ҷȡ������Ȩϵ��
%��3*3�����ݶ�ͼ��:im1,��3*3����ͼ��:im2
[M,N]=size(im);
im1=zeros(M,N);
im2=im;
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im2=conv2(im,ones(3,3),'same')/9;
im1=abs(im-im2);% im1=im1/max(max(im1))*255;
im=a*im+(1-a)*im2;%�Ҷȡ�����ֱ��ͼ
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������άֱ��ͼ:p
x=0;y=0;
im=uint8(im);
im1=uint8(im1);
p=zeros(256,256);
for i=1:M
    for j=1:N
        x=im(i,j)+1;y=im1(i,j)+1;
        p(x,y)=p(x,y)+1;
    end
end
p=p/M/N;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ʹ�÷ֽⷽ������ý��Ƶ�һάֱ��ͼpq��p
pq=p.^q;
pq=sum((pq)');
p=sum(p');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���õ��Ƽ�����������ĺ�,��Ȩ�ͣ�sump��sumpq
sump=zeros(1,256);
sumpq=zeros(1,256);
sump(1)=p(1);
sumpq(1)=p(1)^q;
for i=2:256
    sump(i)=sump(i-1)+p(i);
    sumpq(i)=sumpq(i-1)+p(i)^q;
end
t=toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������ֵ��Arimoto��
% tic
h1=zeros(256,1);h2=zeros(256,1);
H=zeros(256,1);
for s=1:255       
        if sump(s)~=0&&sump(end)-sump(s)~=0
           h1(s)=sumpq(s)^(1/q)/sump(s);
           h2(s)=(sumpq(end)-sumpq(s))^(1/q)/(sump(end)-sump(s));
        end
end
H=q/(q-1)*(1-h1.*h2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hmax=max(max(H));
[indx,indy]=find(H==hmax);
t=toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im3=zeros(size(imm));
ind=find(im<=indx(1));
im3(ind)=0;
ind=find(im>indx(1));
im3(ind)=255;

figure,imshow(uint8(imm));
figure,imshow(uint8(im));
figure,imshow(uint8(im1));
% figure,mesh([1:256],[1:256],(p*M*N));
% figure,mesh([1:256],[1:256],abs(H));
figure,imshow(uint8(im3));



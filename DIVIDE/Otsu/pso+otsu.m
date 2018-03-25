clear all
tic;
t1=clock;
I=imread('niurou.jpg');
J=rgb2gray(I);
[a,b]=size(J);
[p,x]=imhist(J,256);
L=x';
LP=p'/(a*b);

n=256
c1=2;
c2=2;
wmax=0.9;
wmin=0.4;
G=10;
M=15;
X=min(L)+fix((max(L)-min(L))*rand(1,M));
V=min(L)+(max(L)-min(L))*rand(1,M);


m=0;
for i=1:1:n
    m=m+L(i)*LP(i);
end
pbest=zeros(M,2);
gbest1=0;
gbest2=0;
GG=0;
t2=clock;
for k=1:1:G
    w(k)=wmax-(wmax-wmin)*k/G;
    for i=1:1:M
        t=length(find(X(i)>=L));
        r=0;
        s=0;
        for j=1:1:t
            r=r+LP(j);
            s=s+L(j)*LP(j);
        end
        W0(i)=r;
        W1(i)=1-r;
        U0(i)=s/r;
        U1(i)=(m-s)/(1-r);
    end
    for i0=1:1:M
        BB(i0)=W0(i0)*W1(i0)*((U1(i0)-U0(i0))^2);
    end
  
   for i=1:1:M
       if pbest(i,2)<BB(i)
           pbest(i,2)=BB(i);            
           pbest(i,1)=X(i);
       end
   end
    [MAX,CC]=max(BB);
    if MAX>=gbest2
        gbest2=MAX;
        gbest1=X(CC);
    end
    GG(k)=gbest2;
  
   for i=1:1:M
       V(i)=round(w(k)*V(i)+c1*rand*(pbest(i,1)-X(i))+c2*rand*(gbest1-X(i)));
       X(i)=V(i)+X(i);
   end
   
end
 for i=1:1:a
      for j=1:1:b
          if J(i,j)>gbest1
              J(i,j)=250;
          else J(i,j)=0;
          end
      end
  end
   kk=1:1:G;
 
  gbest1
  figure(1)
  imshow(J)
   figure(2)
   plot(kk,GG)
tt=etime(clock,t1)
toc;





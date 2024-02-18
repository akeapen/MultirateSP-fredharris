function [rts1,rts2,coef0,coef1,ff1,ff2]=tonycxx(n_ord,wo,bw,fc,k_ordr, mode)
% mode = 1 for lowpass prototype
% mode = 2 to bandwidth and center frequency of prototype
% k_ordr for filter order
% function called by tony_des_2, 
% computes paramters of two-path recursive all-pass filter
% also computes parameters when frequency transformed to two-path
% low-pass or band-pass filter

% Script file written by fred harris of UCSD. Copyright 2021

mode;
wt=4*pi*(wo-0.25);
k=tan(0.25*(pi-wt));
k=k*k;

kk=sqrt(1-k*k);

e=0.5*(1-sqrt(kk))/(1+sqrt(kk));

q=e+2*(e^5)+15*(e^9)+150*(e^13);
ww=zeros(1,(n_ord-1)/2);
aa=ww;
cc=[ww 0];
%step 2

for ii=1:(n_ord-1)/2

ww(ii)=2*(q^0.25)*(sin(pi*ii/n_ord)-(q^2)*sin(3*pi*ii/n_ord));
ww(ii)=ww(ii)/(1-2*(q*cos(2*pi*ii/n_ord)-(q^4)*cos(4*pi*ii/n_ord)));

wwsq=ww(ii)*ww(ii);
aa(ii)=sqrt(((1-wwsq*k)*(1-wwsq/k)))/(1+wwsq);
cc(ii)=(1-aa(ii))/(1+aa(ii));
end

ordr1=floor((n_ord-1)/4);
ordr2=ordr1;
if n_ord-1-4*ordr1 ~= 0 
	ordr1=ordr1+1;
end

coef0=zeros(ordr1,3);
coef1=zeros(ordr2,3);

zz=zeros(1,k_ordr-1);

for ii=1:ordr1
den0(ii,:)=[1 zz cc(2*ii-1)];
end
coef0=den0;

for ii=1:ordr2
den1(ii,:)=[1 zz cc(2*ii)];
end
coef1=den1;

h0=[1];
for ii=1:ordr1
h0=conv(h0,den0(ii,:));
end


h1=[1];
for ii=1:ordr2
h1=conv(h1,den1(ii,:));
end

zz2=zeros(1,k_ordr/2);
h1=[h1 zz2];

g0=fliplr(h0);
g1=fliplr(h1);

rts1=h0;
rts2=h1;

[tp,ww]=freqz(g0,h0,512);
[bt,ww]=freqz(g1,h1,512);

ff1=0.5*(tp+bt);
ff2=0.5*(tp-bt);

if mode==1
return   

else

tt=tan(pi*bw);
b=(1-tt)/(1+tt);

c=cos(2*pi*fc);

if fc==0
   
den0=zeros(ordr1,k_ordr+1);
den1=zeros(ordr2,k_ordr+1);
zz=zeros(1,(k_ordr/2)-1);
   for nn=1:ordr1
c00=1+cc(2*nn-1)*b*b;
c01=-2*b*(1+cc(2*nn-1));
c01=c01/c00;
c02=cc(2*nn-1)+b*b;
c02=c02/c00;
den0(nn,:)=[1 zz c01 zz c02];
   end
coef0=den0;
   
   for nn=1:ordr2
c10=1+cc(2*nn)*b*b;
c11=-2*b*(1+cc(2*nn));
c11=c11/c10;
c12=cc(2*nn)+b*b;
c12=c12/c10;
den1(nn,:)=[1 zz c11 zz c12];
end
zz2=zeros(1,k_ordr/2-1);
den1(ordr2+1,1:1+k_ordr/2)=[1 zz2 -b];   
coef1=den1;

h0=[1];
for ii=1:ordr1
   h0=conv(h0,den0(ii,:));
end

h1=[1 zz2 -b];
for ii=1:ordr2
   h1=conv(h1,den1(ii,:));
end

g0=fliplr(h0);
g1=fliplr(h1);
rts1=h0;
rts2=h1;

[tp,ww]=freqz(g0,h0,512);
[bt,ww]=freqz(g1,h1,512);

ff1=0.5*(tp+bt);
ff2=0.5*(tp-bt);

else
   
den0=zeros(ordr1,2*k_ordr+1);
den1=zeros(ordr2,2*k_ordr+1);

zz=zeros(1,(k_ordr/2)-1);

for nn=1:ordr1
c00=1+cc(2*nn-1)*b*b;
c01=-2*c*(1+b)*(1+cc(2*nn-1)*b);
c01=c01/c00;
c02=(1+cc(2*nn-1))*(c*c*(1+b*b)+2*b*(1+c*c));
c02=c02/c00;
c03=-2*c*(1+b)*(cc(2*nn-1)+b);
c03=c03/c00;
c04=cc(2*nn-1)+b*b;
c04=c04/c00;
den0(nn,:)=[1 zz c01 zz c02 zz c03 zz c04];
end 
coef0=den0;

for nn=1:ordr2
c10=1+cc(2*nn)*b*b;
c11=-2*c*(1+b)*(1+cc(2*nn)*b);
c11=c11/c10;
c12=(1+cc(2*nn))*(c*c*(1+b*b)+2*b*(1+c*c));
c12=c12/c10;
c13=-2*c*(1+b)*(cc(2*nn)+b);
c13=c13/c10;
c14=cc(2*nn)+b*b;
c14=c14/c10;
den1(nn,:)=[1 zz c11 zz c12 zz c13 zz c14];
end 
zz2=zeros(1,k_ordr/2-1);
den1(ordr2+1,1:1+k_ordr)=[1 zz2 -c*(1+b) zz2 b];
coef1=den1;


h0=[1];
for ii=1:ordr1
   h0=conv(h0,den0(ii,:));
end

h1=[1 zz -c*(1+b) zz b];
for ii=1:ordr2
   h1=conv(h1,den1(ii,:));
end

g0=fliplr(h0);
g1=fliplr(h1);
rts1=h0;
rts2=h1;

[tp,ww]=freqz(g0,h0,512);
[bt,ww]=freqz(g1,h1,512);

ff1=0.5*(tp-bt);
ff2=0.5*(tp+bt);
end

end
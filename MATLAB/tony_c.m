function tony_c(n,wo)
% function tonyc(n,wo), 
% Computes coefficients of two-path, recursive All-Pass half filter,
% n, the number of poles, must be odd (3,5,7.....), 
% wo, normalized stop band frequency, (0.25 < wo < 0.5)
% try tony_c(9,0.3)
% based on paper "Digital Signal Processing Schemes for Efficient Interpolation and Decimation"
% by Valenzuela and Constantinides, IEE Proceedings, Dec 1983
% Script file written by fred harris of ucsd. Copyright 2021

if (n-2*floor(n/2)) ==0
   disp(' Filter Order Must Be Odd, Please Change Order and Enter Again')
  return;
end;
if wo<=0.25
   disp(' Stopband Edge Must be Greater Than 0.25, Please Change and Enter Again')
  return;
end;
    
%step 1
wt=4*pi*(wo-0.25);
k=tan(0.25*(pi-wt));
k=k*k;

kk=sqrt(1-k*k);

e=0.5*(1-sqrt(kk))/(1+sqrt(kk));

q=e+2*(e^5)+15*(e^9)+150*(e^13);
ww=zeros(1,(n-1)/2);
aa=ww;
cc=ww;
%step 2
for ii=1:(n-1)/2

ww(ii)=2*(q^0.25)*(sin(pi*ii/n)-(q^2)*sin(3*pi*ii/n));
ww(ii)=ww(ii)/(1-2*(q*cos(2*pi*ii/n)-(q^4)*cos(4*pi*ii/n)));

wwsq=ww(ii)*ww(ii);
aa(ii)=sqrt(((1-wwsq*k)*(1-wwsq/k)))/(1+wwsq);
cc(ii)=(1-aa(ii))/(1+aa(ii));
end
disp(' ')
disp('Coefficients of Top Path')
disp(' ')
disp(cc(1:2:length(cc)))
disp(' ')
disp('Coefficients of Bottom Path')
disp(' ')
disp(cc(2:2:length(cc)))

ordr1=floor((n-1)/4);
ordr2=ordr1;
if n-1-4*ordr1 ~= 0 
	ordr1=ordr1+1;
end
den1=zeros(ordr1,3);
den2=zeros(ordr2,3);

for ii=1:ordr1
den1(ii,:)=[1 0 cc(2*ii-1)];
end

for ii=1:ordr2
den2(ii,:)=[1 0 cc(2*ii)];
end

h0=[1];
for ii=1:ordr1
h0=conv(h0,den1(ii,:));
end

h1=[1];
for ii=1:ordr2
h1=conv(h1,den2(ii,:));
end
h1=[h1 0];
g0=fliplr(h0);
g1=fliplr(h1);

[tp,ww]=freqz(g0,h0,512);
[bt,ww]=freqz(g1,h1,512);

hh=0.5*(tp+bt);
hh2=0.5*(tp-bt);
figure(1)
clf;
plot(0:1/1024:.5-1/1024,unwrap(angle(tp))/(pi),'b','linewidth',1.5);
hold on;
plot(0:1/1024:.5-1/1024,unwrap(angle(bt))/(pi),'r','linewidth',1.5);
axis([0 .5 -(2*ordr1+1) 0]);
plot([0 .5],[0 -2*ordr2],'--b','linewidth',1.5)
plot([0 .5],[0 -2*ordr2-1],'--r','linewidth',1.5)
hold off;
grid on;
title('Phase of Each Path in Two Path Filter');
xlabel('Normalized Frequency (f/fs)');
ylabel('Normalized Phase (theta/2\pi)');

figure(2)
subplot(2,1,1)
plot(0:1/1024:.5-1/1024,20*log10(abs(hh)+0.0000001),'b','linewidth',1.5);
hold on
plot(0:1/1024:.5-1/1024,20*log10(abs(hh2)+0.000001),'r','linewidth',1.5);
hold off
axis([0 .5 -100 10]);
grid on;
title('Magnitude Response');
xlabel('Normalized Frequency (f/f_s)');
ylabel('Log Mag (dB)');

subplot(2,1,2)
plot(0:1/1024:.5-1/1024,20*log10(abs(hh)),'b','linewidth',1.5);
b_axis=min(20*log10(abs(hh(1:(0.5-wo)*500))));
axis([0 .5 3*b_axis -b_axis]);
grid;
title('Zoom to Passband Ripple');
xlabel('Normalized Frequency (f/f_s)');
ylabel('Log Mag (dB)');


figure(3)
subplot(2,1,1)
plot(0:1/1024:.5-1/1024,unwrap(angle(hh))/(2*pi),'b','linewidth',1.5);
grid on;%axis([0 .5 -3 0]);
title('Phase response');
xlabel('Normalized Frequency (f/f_s)');
ylabel('Normalized Phase (Theta/2\pi)');

subplot(2,1,2)
gd=conv([-1 1],unwrap(angle(hh))/(2*pi));
id=find(gd<0);
gd(id)=gd(id-1);
plot(0:1/1024:.5,1024*gd,'b','linewidth',1.5);
grid;
title('Group Delay (in Samples)');
xlabel('Normalized Frequency (f/f_s)');
ylabel('Normalized Delay (T_D_e_l_a_y/T_s)');
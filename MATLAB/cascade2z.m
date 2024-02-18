function cascade2z(del);
% cascade2(del)  Routine demos arbitrary interpolator. First stage is 1-to-4 shaping
% filter. Second stage is 1-to-32 polyphase (4-taps per stage) 
% Argument "del" is step size between 32 output stages. 
% If del < 1 further interpolation (try 0.29). 
% if del > 1, down samples by del after 1-to-32 up sample
% resulting in 32/del (try 4.2)
%Script file written by fred harris of UCSD. Copyright 2021

%del=5;

figure(1)
subplot(2,1,1)
aa=remez(44,[0 .37 .63 2]/2, [1 1 0 0],[1 10]); 
stem(0:44,aa,'b','linewidth',1.0);
title('Time Response of Shaping Filter');
xlabel('Time');
ylabel('Amplitude');

axis([-5 50 -0.1 0.3]);
grid on

subplot(2,1,2)
plot((-.5:1/512:.5-1/512)*4,fftshift(20*log10(abs(fft(aa,512)))),'b','linewidth',1.0);
grid on;
axis([-2 2 -70 10])
title('Spectral Response of Shaping Filter');
xlabel('Frequency');
ylabel('Log Magnitude');
pause

figure(2)
ff=[0 .25 3.5 4.5 7.5 8.5 11.5 12.5 15.5 16.5 19.5 20.5 23.5 24.5 27.5 28.5 31.5 32.5 35.5 36.5 39.5 40.5 43.5 44.5 47.5 48.5 51.5 52.5 55.5 56.5 59.5 60.5 63.5 64];
gg=[1  1   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0  0];

bb=remez(127,ff/64,gg);
subplot(2,1,1)
stem(0:127,bb,'b','linewidth',1.0);
title('Time Response of 1-to-32 Interpolator');
xlabel('Time');
ylabel('Amplitude');
grid on
axis([-10 135 -0.01 0.04])

subplot(2,1,2)
plot((-.5:1/512:.5-1/512)*128,fftshift(20*log10(abs(fft(bb,512)))),'b','linewidth',1.0);
grid on;
axis([-64 64 -80 10]);
title('Spectral Response of 1-to-32 Interpolator');
xlabel('Frequency');
ylabel('Log Mag (dB)');

pause
figure(3)
plot(roots(bb),'ro','linewidth',1.5);
hold on;
plot(exp(j*2*pi*(0:100)/100),'b','linewidth',1.5);
axis([-1.5 1.5 -1.5 1.5]);
hold off
grid on
axis('square');
title('Zeros of 1-to-32 Interpolator');
xlabel('Real');
ylabel('Imaginary');
pause;

figure(4)

zz=zeros(size(aa));
cc=reshape([aa;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1440,1);
plot((-.5:1/4096:.5-1/4096)*128,fftshift(20*log10(abs(fft(cc,4096)))),'b','linewidth',1.0);
hold on
plot((-.5:1/1024:.5-1/1024)*128,fftshift(20*log10(abs(fft(bb,1024)))),'r','linewidth',1.0);
hold off
grid on
axis([-64 64 -80 10])
title('Spectral Response of 1-to-32 Interpolator and of 1-to-32 Upsampled Filter');
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause
axis([-10 10 -80 10]);
title('Low Frequency Detail')
pause

figure(5)
dd=conv(cc,bb);
subplot(2,1,1)
sz=size(dd);
indx=floor(1:del:sz(1));
ee=dd(indx);
stem(real(ee),'b','linewidth',1.0);
grid
axis([-10 length(ee)+10 1.2*min(ee) 1.2*max(ee)])
title('Time Response of 1-to-M Interpolated Filter: Up sample by 32 then Down Sample by Delta');
xlabel('Time');
ylabel('Amplitude');

subplot(2,1,2)
%plot((-.5:1/2048:.5-1/2048)*128,fftshift(20*log10(abs(fft(dd,2048)))));
%grid;
%axis([-64 64 -80 10]);
%title('spectral response of 1-to-32 interpolated filter');
%xlabel('frequency');
%ylabel('log magnitude');

sz=length(ee);
if sz>4096
sz=2*sz;
end
ww=kaiser(length(ee),12);
size(ee);
size(ww);
f_ee=abs(fft(ee.*ww,sz));
plot((-.5:1/sz:.5-1/sz)*128/del,fftshift(20*log10(f_ee/max(f_ee))),'b','linewidth',1.0);
grid;
axis([-64/del 64/del -90 10]);
title('Spectral Response of 1-to-M Interpolated Filter');
xlabel('Frequency');
ylabel('Log Magnitude');
pause

accum=0;
kk=1;
nn=1;
reg=zeros(1,4);
wts=reshape(bb,32,4);
aa=[aa zeros(1,4)];
while nn<=length(aa)
  reg=[aa(nn) reg(1:3)];
  
  while accum<32
    pntr=floor(accum)+1;
    qq1(kk)=pntr;
    qq2(kk)=accum;
   	yy(kk)=reg*wts(pntr,:)';
   	kk=kk+1;
   	accum=accum+del;
   end
  accum=rem(accum,32);
  nn=nn+1;
end

figure(6)
subplot(2,1,1)
yy=yy*del;
stem(yy,'b','linewidth',1.0)
grid
title('Time Response of 1-to-M Interpolated Filter: Only Computing Retained Output Samples');
xlabel('Time');
ylabel('Amplitude');

axis([-10 length(yy)+10 1.5*min(yy) 1.2*max(yy)])
subplot(2,1,2)
rr=ceil((log(length(yy)))/log(2));
n_len=2*2^rr;
plot((-0.5:1/n_len:0.5-1/n_len)*128/del,fftshift(20*log10(abs(fft(yy,n_len)))),'b','linewidth',1.0)
grid
axis([-64/del 64/del -90 10])
title('Spectral Response of 1-to-M Interpolated Filter');
xlabel('Frequency');
ylabel('Log Magnitude');
pause

figure(7)
rra=[0:length(qq1)-1];
rrb=[1:length(qq1)];
rr2=reshape([rra;rrb],1,2*length(rra));
qq1x=reshape([qq1;qq1],1,2*length(qq1));
plot(rr2,qq1x,'b','linewidth',1.0)
% hold on
% plot(rra,qq2,'r')
% hold off
grid on
axis([0 length(qq1)/2 0 35]);
title('Accumulator Address Modulo 32')
xlabel('Time Index')
ylabel('Accumulator Content')
% hh=get(gca);
%  hh=set(gca,'gridlinestyle','-')

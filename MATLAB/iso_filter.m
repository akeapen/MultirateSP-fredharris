function iso_filter
% fractional octave filter bank implemented by recursive all-pass bandpass filters
% along with recursive all-pass low-pass half band filters.
% Coefficients pre-computed by tony_des2
% Script file written by fred harris of UCSD. Copyright 2021

fc=[25 40 63 100 160 250 400 630 1000 1600 2500 4000 6300 10000 16000];
fs=48000;

alph=10^(3/30)-1;% 0.2589254

ff=20*(1+alph).^(0:30);
%    20.00     25.18     31.70
%    31.70     40.00     50.23 
%    50.23     63.24     79.61 
%    79.61    100.22    126.17 
%   126.17    158.84    200.00 
%   200.00    251.73    316.90 
%   316.90    398.95    502.24 
%   502.24    632.26    795.96 
%   795.96   1020.31   1261.46 
%  1261.46   1588.05   1999.19 
%  1999.19   2516.78   3168.38
%  3168.38   3988.67   5021.34 
%  5021.34   6321.36   7957.97 
%  7957.97  10018.28  12612.02 
% 12612.02  15877.27  19987.89

%sequence:
%       16000  10000  6300  4000  2500  1600  1000  630  400  250  160  100  63  40  25    
%48000     1     2
%24000                  3    4
%12000                             2
% 6000                                   3
% 3000                                         1     2
% 1500                                                    3   4  
%  750                                                              2
%  375                                                                  3    4
%  175.5                                                                         2
%   93.75                                                                            3


clear all
c1_0=[1.0   1.60019166547835   1.31033800600243   0.57908170134648   0.15349102771658];
c1_2=[1.0   1.73074578982430   1.74460128626437   1.17076748497058   0.53577315275172];

c1_1=[1.0   1.65351825934896   1.48771870305402   0.82076374425708   0.30963932044858];
c1_3=[1.0   1.82881909394811   2.07082334143343   1.61524658583248   0.82294654767504];
c1_5=[1.0   0.79033763562577   0.31039344084607];


c2_0=[1.0  -0.71592919512003   1.22486664484923  -0.40563172993055   0.32925029127040];
c2_2=[1.0  -0.77816796642336   1.52581133425557  -0.61895585819592   0.65584161264556];

c2_1=[1.0  -0.74235796178854   1.35265832212519  -0.49621664175684   0.46793242859149];
c2_3=[1.0  -0.81989414332126   1.72757096227670  -0.76197282537236   0.87479528032968];
c2_5=[1.0  -0.35294080954450   0.52585806691138]; 


c3_0=[1.0   0.40461778672609   0.90954875701199   0.18658495918088   0.22731533562096];
c3_2=[1.0   0.44061732874375   1.17696771912781   0.32440658231972   0.58816173413489];

c3_1=[1.0   0.41957075448815   1.02062536786217   0.24383130655659   0.37719848028392];
c3_3=[1.0   0.46635763905521   1.36817701464201   0.42295148451550   0.84617330183666];
c3_5=[1.0   0.19952834317269   0.41421356237310];
   

c4_0=[1.0  -1.63053891504835   1.90469811064872  -1.02956375032163   0.40399069100130];
c4_2=[1.0  -1.76275836477834   2.30944782698569  -1.46261802728683   0.70233972108931];

c4_1=[1.0  -1.68755816780664   2.07924524744891  -1.21631714648812   0.53265284162680];
c4_3=[1.0  -1.84752454166175   2.56893375071771  -1.74025006641806   0.89361193337787];
c4_5=[1.0  -0.80425610929347   0.59522108763333];


a0_0=[1.0   0   0.05337903696491];
a0_2=[1.0   0   0.44371079776035];

a0_1=[1.0   0   0.20558897612803];
a0_3=[1.0   0   0.77747763544555];
a0_5=[1.0 0];


xx=[1 zeros(1,500)];
yt=filter(fliplr(c1_0),c1_0,xx);
yt=filter(fliplr(c1_2),c1_2,yt);
yb=filter(fliplr(c1_1),c1_1,xx);
yb=filter(fliplr(c1_3),c1_3,yb);
yb=filter(fliplr(c1_5),c1_5,yb);
h1=(yt-yb)/2;

xx=[1 zeros(1,500)];
yt=filter(fliplr(c2_0),c2_0,xx);
yt=filter(fliplr(c2_2),c2_2,yt);
yb=filter(fliplr(c2_1),c2_1,xx);
yb=filter(fliplr(c2_3),c2_3,yb);
yb=filter(fliplr(c2_5),c2_5,yb);
h2=(yt-yb)/2;

xx=[1 zeros(1,500)];
yt=filter(fliplr(c3_0),c3_0,xx);
yt=filter(fliplr(c3_2),c3_2,yt);
yb=filter(fliplr(c3_1),c3_1,xx);
yb=filter(fliplr(c3_3),c3_3,yb);
yb=filter(fliplr(c3_5),c3_5,yb);
h3=(yt-yb)/2;

xx=[1 zeros(1,500)];
yt=filter(fliplr(c4_0),c4_0,xx);
yt=filter(fliplr(c4_2),c4_2,yt);
yb=filter(fliplr(c4_1),c4_1,xx);
yb=filter(fliplr(c4_3),c4_3,yb);
yb=filter(fliplr(c4_5),c4_5,yb);
h4=(yt-yb)/2;

xx=[1 zeros(1,500)];
yt=filter(fliplr(a0_0),a0_0,xx);
yt=filter(fliplr(a0_2),a0_2,yt);
yb=filter(fliplr(a0_1),a0_1,xx);
yb=filter(fliplr(a0_3),a0_3,yb);
yb=filter(fliplr(a0_5),a0_5,yb);
h0=(yt+yb)/2;

figure(1)
subplot(3,1,1)
semilogx((-0.5:1/1024:0.5-1/1024)*48,fftshift(20*log10(abs(fft(h1,1024)))),'linewidth',1.5)
hold on
semilogx((-0.5:1/1024:0.5-1/1024)*48 ,fftshift(20*log10(abs(fft(h2,1024)))),'linewidth',1.5)
semilogx((-0.5:1/1024:0.5-1/1024)*24 ,fftshift(20*log10(abs(fft(h3,1024)))),'linewidth',1.5)
semilogx((-0.5:1/1024:0.5-1/1024)*24 ,fftshift(20*log10(abs(fft(h4,1024)))),'linewidth',1.5)
semilogx((-0.5:1/1024:0.5-1/1024)*12 ,fftshift(20*log10(abs(fft(h2,1024)))),'linewidth',1.5)
semilogx((-0.5:1/512:0.5-1/512)*6  ,fftshift(20*log10(abs(fft(h3,512)))),'linewidth',1.5)
semilogx((-0.5:1/512:0.5-1/512)*3  ,fftshift(20*log10(abs(fft(h1,512)))),'linewidth',1.5)
semilogx((-0.5:1/512:0.5-1/512)*3  ,fftshift(20*log10(abs(fft(h2,512)))),'linewidth',1.5)
semilogx((-0.5:1/512:0.5-1/512)*1.5,fftshift(20*log10(abs(fft(h3,512)))),'linewidth',1.5)
semilogx((-0.5:1/512:0.5-1/512)*1.5,fftshift(20*log10(abs(fft(h4,512)))),'linewidth',1.5)
hold off
grid on
axis([.1 24 -100 5])
title('Frequency Responses, Recursive Proportional Band Pass Filters ')
xlabel('Logarithmic Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,2)
plot((-0.5:1/1024:0.5-1/1024)*48,fftshift(20*log10(abs(fft(h1,1024)))),'b','linewidth',1.5)
hold on
plot((-0.5:1/1024:0.5-1/1024)*48,fftshift(20*log10(abs(fft(h2,1024)))),'r','linewidth',1.5)
%plot((-0.5:1/1024:0.5-1/1024)*48,fftshift(20*log10(abs(fft(h0,1024)))),'r')
hold off
grid on
axis([0 24 -100 5])
title('Frequency Responses, Adjacent Fiters, Top Octave')
xlabel('Linear Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,3)
plot((-0.5:1/1024:0.5-1/1024)*24,fftshift(20*log10(abs(fft(h3,1024)))),'b','linewidth',1.5)
hold on
plot((-0.5:1/1024:0.5-1/1024)*24,fftshift(20*log10(abs(fft(h4,1024)))),'r','linewidth',1.5)
%plot((-0.5:1/1024:0.5-1/1024)*24,fftshift(20*log10(abs(fft(h0,1024)))),'r')
hold off
grid
axis([0 12 -100 5])
title('Frequency Responses, Adjacent Fiters, Next Octave')
xlabel('Linear Frequency')
ylabel('Log Mag (dB)')



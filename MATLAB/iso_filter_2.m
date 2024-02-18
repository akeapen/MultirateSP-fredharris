% function iso_filter_2
% fractional octave filter bank, 12 filters per octave, passband recursive 
% all-pass filter bank and recursive all-pass half band filters that 
% downsample successive octaves into 12 filter filter bank.
% Coefficients pre-computerd in tony_des2
% Script file written by fred harris of UCSD. Copyright 2021

% 2.^(1/24*(0:1:24))
% 12-th octave


c1_0=[1.0  -1.37691270264439   2.40243109712227  -1.32976356959393   0.93274676638691];
c1_1=[1.0  -0.67741514960130   0.93252161223954];

c2_0=[1.0  -1.10640963531439   2.22968791698680  -1.06617077796423   0.92865617189649];
c2_1=[1.0  -0.54382341646042   0.92840686329603];

c3_0=[1.0  -0.81416870541132   2.08454095920245  -0.78283067799204   0.92458418889291];
c3_1=[1.0  -0.39981036551344   0.92430892990172];

c4_0=[1.0  -0.50019094946688   1.97625063430817  -0.47981438956469   0.92028423786082];
c4_1=[1.0  -0.24538794919935   0.91997937670527];

c5_0=[1.0  -0.16551088683760   1.91515764044501  -0.15837569715732   0.91575642146213];
c5_1=[1.0  -0.08111519888768   0.91541779106493];

c6_0=[1.0   0.18947258280299   1.91162259960624   0.18082897643330   0.91098229715854];
c6_1=[1.0   0.09275973718022   0.91060498749878];

c7_0=[1.0   0.56284996440740   1.97595069665084   0.53568157325354   0.90595658636224];
c7_1=[1.0   0.27524691175955   0.90553493053923];

c8_0=[1.0   0.95075283980035   2.11662626725078   0.90219541273427   0.90065870119061];
c8_1=[1.0   0.46439972353981   0.90018600616487];

c9_0=[1.0   1.34982572825640   2.33989178930752   1.27689135396899   0.89508572803983];
c9_1=[1.0   0.65852876049864   0.89455427972244];

c10_0=[1.0   1.75429729431080   2.64741250575480   1.65402261907608   0.88922137299804];
c10_1=[1.0   0.85477214944818   0.88862212505277];

c11_0=[1.0   2.15461906136894   3.03219323170886   2.02433683986097   0.88304586847827];
c11_1=[1.0   1.04844139670455   0.88236816326496];

c12_0=[1.0   2.54549307058641   3.48505642326392   2.38269183959516   0.87655810472847];
c12_1=[1.0   1.23694173776033   0.87578965490499];

xx=[1 zeros(1,511)];
yt=filter(fliplr(c1_0),c1_0,xx);
yb=filter(fliplr(c1_1),c1_1,xx);
h1=(yt-yb)/2;

yt=filter(fliplr(c2_0),c2_0,xx);
yb=filter(fliplr(c2_1),c2_1,xx);
h2=(yt-yb)/2;

yt=filter(fliplr(c3_0),c3_0,xx);
yb=filter(fliplr(c3_1),c3_1,xx);
h3=(yt-yb)/2;

yt=filter(fliplr(c4_0),c4_0,xx);
yb=filter(fliplr(c4_1),c4_1,xx);
h4=(yt-yb)/2;

yt=filter(fliplr(c5_0),c5_0,xx);
yb=filter(fliplr(c5_1),c5_1,xx);
h5=(yt-yb)/2;

yt=filter(fliplr(c6_0),c6_0,xx);
yb=filter(fliplr(c6_1),c6_1,xx);
h6=(yt-yb)/2;

yt=filter(fliplr(c7_0),c7_0,xx);
yb=filter(fliplr(c7_1),c7_1,xx);
h7=(yt-yb)/2;

yt=filter(fliplr(c8_0),c8_0,xx);
yb=filter(fliplr(c8_1),c8_1,xx);
h8=(yt-yb)/2;

yt=filter(fliplr(c9_0),c9_0,xx);
yb=filter(fliplr(c9_1),c9_1,xx);
h9=(yt-yb)/2;

yt=filter(fliplr(c10_0),c10_0,xx);
yb=filter(fliplr(c10_1),c10_1,xx);
h10=(yt-yb)/2;

yt=filter(fliplr(c11_0),c11_0,xx);
yb=filter(fliplr(c11_1),c11_1,xx);
h11=(yt-yb)/2;

yt=filter(fliplr(c12_0),c12_0,xx);
yb=filter(fliplr(c12_1),c12_1,xx);
h12=(yt-yb)/2;

figure(1)
subplot(2,1,1)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h1,512)))),'linewidth',1.5)
hold on
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h2,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h3,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h4,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h5,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h6,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h7,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h8,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h9,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h10,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h11,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(h12,512)))),'linewidth',1.5)

plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h1,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h2,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h3,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h4,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h5,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h6,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h7,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h8,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h9,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h10,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h11,512)))),'--','linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(h12,512)))),'--','linewidth',1.5)
hold off
grid on
axis([0 0.5 -100 5])
title('Spectra of 12-Proportional Bandwidth Filters in Two Successive Octaves')
xlabel('Logarithmic Frequency')
ylabel('Log Mag (dB)')

a1_0=[1.0  0   0.04935699423228];
a1_2=[1.0  0   0.35832699296223];
a1_4=[1.0  0   0.72732865765128];

a1_1=[1.0  0   0.18115640791838];
a1_3=[1.0  0   0.54610757511795];
a1_5=[1.0  0   0.90552322564104];
a1_7=[1.0 0];

xx=[1 zeros(1,511)];
yt=filter(fliplr(a1_0),a1_0,xx);
yt=filter(fliplr(a1_2),a1_2,yt);
yt=filter(fliplr(a1_4),a1_4,yt);

yb=filter(fliplr(a1_1),a1_1,xx);
yb=filter(fliplr(a1_3),a1_3,yb);
yb=filter(fliplr(a1_5),a1_5,yb);
yb=filter(fliplr(a1_7),a1_7,yb);

g1=(yt+yb)/2;

subplot(2,1,2)
plot((-0.5:1/512:0.5-1/512),fftshift(20*log10(abs(fft(g1,512)))),'linewidth',1.5)
hold on
plot((-0.5:1/512:0.5-1/512)*0.5,fftshift(20*log10(abs(fft(g1,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.25,fftshift(20*log10(abs(fft(g1,512)))),'linewidth',1.5)
plot((-0.5:1/512:0.5-1/512)*0.125,fftshift(20*log10(abs(fft(g1,512)))),'linewidth',1.5)
hold off
grid
axis([0 0.5 -100 5])
title('Spectrum of Successive Half Band Filters')
xlabel('Linear Frequency')
ylabel('Log Mag (dB)')
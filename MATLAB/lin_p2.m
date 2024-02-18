function lin_p2
% Comparison of two high performance half band filters, FIR and linear phase
% recursive all-pass filter. Recursive half band designed with lineardesign_2
% Script file written by fred harris of UCSD. Copyright 2021

gg1 = [1  0  0.963531];
gg2 = [1  0 -0.832774];

hh1 = [1  0  1.702378  0  0.743752];
hh2 = [1  0  1.605635  0  0.715316];
hh3 = [1  0  1.488962  0  0.705286];
hh4 = [1  0  1.338481  0  0.700624];
hh5 = [1  0  1.153941  0  0.698228];
hh6 = [1  0  0.938532  0  0.697013];
hh7 = [1  0  0.697160  0  0.696237];
hh8 = [1  0  0.436491  0  0.695595];
hh9 = [1  0  0.163760  0  0.695228];
hh10= [1  0 -0.113767  0  0.695024];
hh11= [1  0 -0.388347  0  0.694823];
hh12= [1  0 -0.652199  0  0.694595];
hh13= [1  0 -1.642448  0  0.693555];
hh14= [1  0 -1.573817  0  0.693723];
hh15= [1  0 -1.461322  0  0.693894];
hh16= [1  0 -1.308082  0  0.693996];
hh17= [1  0 -1.118517  0  0.694147];
hh18= [1  0 -0.897849  0  0.694348];


xx=zeros(1,200);
xx(1)=1;

ff=[1 zeros(1,75)];


[h1,w1]=freqz(fliplr(ff),ff,1000);
tt1=h1;
yt=filter(fliplr(ff),ff,xx);

rr1=unwrap(angle(h1))/(2*pi);
figure(1)
plot((0:1/1000:1-1/1000)*0.5,rr1,'b','linewidth',1.5)
hold on


[h1,w1]=freqz(fliplr(gg1),gg1,1000);
yb=filter(fliplr(gg1),gg1,xx);

r1=unwrap(angle(h1))/(2*pi);
rr2=r1;
tt2=h1;

[h1,w1]=freqz(fliplr(gg2),gg2,1000);
yb=filter(fliplr(gg2),gg2,yb);

r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh1),hh1,1000);
yb=filter(fliplr(hh1),hh1,yb);

r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh2),hh2,1000);
yb=filter(fliplr(hh2),hh2,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh3),hh3,1000);
yb=filter(fliplr(hh3),hh3,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh4),hh4,1000);
yb=filter(fliplr(hh4),hh4,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh5),hh5,1000);
yb=filter(fliplr(hh5),hh5,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh6),hh6,1000);
yb=filter(fliplr(hh6),hh6,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh7),hh7,1000);
yb=filter(fliplr(hh7),hh7,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh8),hh8,1000);
yb=filter(fliplr(hh8),hh8,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh9),hh9,1000);
yb=filter(fliplr(hh9),hh9,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh10),hh10,1000);
yb=filter(fliplr(hh10),hh10,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh11),hh11,1000);
yb=filter(fliplr(hh11),hh11,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh12),hh12,1000);
yb=filter(fliplr(hh12),hh12,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh13),hh13,1000);
yb=filter(fliplr(hh13),hh13,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh14),hh14,1000);
yb=filter(fliplr(hh14),hh14,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh15),hh15,1000);
yb=filter(fliplr(hh15),hh15,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh16),hh16,1000);
yb=filter(fliplr(hh16),hh16,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh17),hh17,1000);
yb=filter(fliplr(hh17),hh17,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

[h1,w1]=freqz(fliplr(hh18),hh18,1000);
yb=filter(fliplr(hh18),hh18,yb);
r1=unwrap(angle(h1))/(2*pi);
rr2=rr2+r1;
tt2=tt2.*h1;

plot((0:1/1000:1-1/1000)*0.5,rr2,'r','linewidth',1.5)
hold off
grid on
title('Phase Slopes of Two-Path Linear Phase IIR Filter')
xlabel('Frequency')
ylabel('Normalized Phase \theta(f)/(2\pi)')

figure(2)
plot((0:1/1000:1-1/1000)*0.5,rr2-rr1,'linewidth',1.5)
grid on
title('Phase Difference of Two-Path Linear Phase IIR Filter')
xlabel('Frequency')
ylabel('Normalized Phase \theta(f)/(2\pi)')

figure(3)
plot((0:1/1000:1-1/1000)*0.5,20*log10(abs(tt1+tt2)/2),'linewidth',1.5);
grid
axis([0 0.5 -70 10])
title('Spectrum, Half-Band Linear Phase IIR Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')


phs=unwrap(angle((tt1+tt2)/2))/(2*pi);
figure(4)
plot((0:1/1000:1-1/1000)*0.5,phs+2*pi,'linewidth',1.5);
grid on
%axis([0 0.5 -90 10])
title('Phase Angle, Half-Band Linear Phase IIR Filter')
xlabel('Frequency')
ylabel('Normalized Phase \theta(f)/(2\pi)')




pp=filter([1 -1],[1 0],-phs*2000);
reg=[0 0 0];
for nn=1:length(pp);
pp_m(nn)=median(reg);
reg(2:3)=reg(1:2);
reg(1)=pp(nn);
end
pp_m(1)=pp_m(4);
pp_m(2)=pp_m(4);
pp_m(3)=pp_m(4);

figure(5)
plot((0:1/1000:1-1/1000)*0.5,pp_m,'linewidth',1.5);
grid
%axis([0 0.5 -90 10])
title('Group Delay, Half-Band Linear Phase IIR Filter')
xlabel('Frequency')
ylabel('Time Delay (Samples)')
pause
axis([0 .5 73 77]);
title('Detail of Linear Phase IIR Group Delay; IIR Ripple=0.1%')
pause

figure(6)
stem(0:199,(yt+yb)/2,'linewidth',1.5);
grid on
title('Impulse Response of Linear Phase IIR Polyphase Filter')
xlabel('Time Index')
ylabel('Amplitude')
axis([0 200 -.15 .55]);
pause
axis([60 90 -.15 .55]);
title('Detail of IIR Impulse Response')
pause

% building roots of iir
den=conv(gg1,gg2);
den=conv(den,hh1);
den=conv(den,hh2);
den=conv(den,hh3);
den=conv(den,hh4);
den=conv(den,hh5);
den=conv(den,hh6);
den=conv(den,hh7);
den=conv(den,hh8);
den=conv(den,hh9);
den=conv(den,hh10);
den=conv(den,hh11);
den=conv(den,hh12);
den=conv(den,hh13);
den=conv(den,hh14);
den=conv(den,hh15);
den=conv(den,hh16);
den=conv(den,hh17);
den=conv(den,hh18);

% den of filter is 76-th order polynomial, (77 coefficients)
% den of delay path is 75-th order polynomial Z^(-75)
num=fliplr(den);
%length(num)
num=[num zeros(1,75)]+[zeros(1,75) den];


zz1=roots(den);
figure(7)
plot(zz1,'xb','linewidth',1.5)
hold on
plot(exp(j*2*pi*(0:200)/200),'k','linewidth',1.5)
plot(0,0,'xb','linewidth',1.5)
text(-.1,.1,'75','fontsize',12)
zz2=roots(num);
plot(zz2,'or','linewidth',1.5)
hold off
axis([-1.2 1.2 -1.2 1.2]);
axis('square')
title('Roots of IIR Filter')
grid on
pause

w1=find(real(zz1)<=0.01);
wz1=zz1(w1);
w2=find(abs(zz2)>.99);
wz2=zz2(w2);

plot(wz1,'xb','linewidth',1.5)
hold on
plot(exp(j*2*pi*(0:200)/200),'k','linewidth',1.5)
plot(0,0,'xb','linewidth',1.5)
text(-.1,.1,'75','fontsize',12)

plot(wz2,'or','linewidth',1.5)
hold off
axis([-1.2 1.2 -1.2 1.2]);
axis('square')
title('Roots of IIR Filter')
grid on
pause




% 1000*hh, left half of fir filter

hh=[0.5205   -0.6181   -1.5781   -1.3140   -0.0410    0.4540   -0.2118...
   -0.4738    0.2156    0.4536   -0.2550   -0.4686    0.2893    0.4930...
   -0.3259   -0.5245    0.3639    0.5600   -0.4049   -0.5990    0.4477...
    0.6408   -0.4947   -0.6856    0.5450    0.7318   -0.5990   -0.7807...
    0.6575    0.8310   -0.7200   -0.8829    0.7880    0.9367   -0.8608...
   -0.9920    0.9387    1.0484   -1.0227   -1.1067    1.1125    1.1657...
   -1.2092   -1.2259    1.3126    1.2876   -1.4232   -1.3497    1.5416...
    1.4126   -1.6685   -1.4766    1.8038    1.5408   -1.9485   -1.6054...
    2.1034    1.6706   -2.2689   -1.7363    2.4455    1.8017   -2.6343...
   -1.8670    2.8367    1.9324   -3.0530   -1.9975    3.2847    2.0623...
   -3.5328   -2.1263    3.7990    2.1893   -4.0857   -2.2517    4.3941...
    2.3130   -4.7270   -2.3731    5.0872    2.4319   -5.4778   -2.4888...
    5.9034    2.5440   -6.3689   -2.5977    6.8801    2.6499   -7.4440...
   -2.7008    8.0687    2.7492   -8.7658   -2.7941    9.5514    2.8365...
  -10.4446   -2.8778   11.4686    2.9172  -12.6558   -2.9517   14.0561...
    2.9842  -15.7344   -3.0153   17.7854    3.0414  -20.3618   -3.0652...
   23.7033    3.0872  -28.2242   -3.1035   34.7157    3.1195  -44.8582...
   -3.1297   63.0402    3.1386 -105.3307   -3.1430  316.3906  500.2081];

gg=fliplr(hh(1:length(hh)-1));
gg=[hh gg]/1000;
figure(8)
stem(0:250,gg,'linewidth',1.5);
grid on
title('Impulse Response of 251-Tap Linear Phase FIR Filter');
xlabel('Time Index')
ylabel('Amplitude')
axis([0 250 -.15 .55]);
pause
axis([110 140 -.15 .55]);
title('Detail of FIR Impulse Response')
pause

figure(9)
plot(-.5:1/2000:.5-1/2000,fftshift(20*log10(abs(fft(gg,2000)))),'linewidth',1.5);
axis([0 .5 -90 10]);
grid on
title('Spectrum: Half-Band FIR Filter')
xlabel('Frequency')
ylabel('Log mag (dB)')
pause

figure(10)
phs=unwrap(angle(fft(gg,2000)))/(2*pi);
plot(0:1/2000:1-1/2000,phs,'linewidth',2);
axis([0 .5 -40  0]);
grid on
title('Phase: Half-Band FIR Filter')
xlabel('Frequency')
ylabel('Normalized Phase \theta(f)/(2\pi)')
pause

%pp=filter([1 -1],[1 0],-phs*2000);
%reg=[0 0 0 0 0];
%for nn=1:length(pp);
%pp_m(nn)=median(reg);
%reg(2:5)=reg(1:4);
%reg(1)=pp(nn);
%end
%pp_m(1)=pp_m(6);
%pp_m(2)=pp_m(6);
%pp_m(3)=pp_m(6);
%pp_m(4)=pp_m(6);
%pp_m(5)=pp_m(6);

%plot((0:1/2000:1-1/2000),pp_m);
%grid
%axis([0 0.5 124 126])
%title('Group Delay, Half-Band Linear Phase FIR Filter')
%pause
%axis([0 .5 115 140]);
%title('Detail of Linear Phase IIR Group Delay; FIR Ripple=0.1%')
%pause


zz=roots(gg);
figure(11)
plot(zz,'or','linewidth',1.5)
hold
plot(exp(j*2*pi*(0:200)/200),'k','linewidth',1.5);
plot(0,0,'bx','linewidth',1.5)
text(-0.1,0.1,'250','fontsize',12);
hold
title('Roots of FIR Filter')
grid
axis([-1.2 1.2 -1.2 1.2])
axis('square')
pause

% comparison of two solutions
figure(12)
subplot(2,1,1)
stem(0:199,(yt+yb)/2,'linewidth',1.5);
grid on
title('Impulse Response of 19-Stage Linear Phase IIR Polyphase Filter')
xlabel('Time Index')
ylabel('Amplitude')
axis([0 200 -.15 .55]);

subplot(2,1,2)
stem(0:250,gg,'linewidth',1.5);
grid on
title('Impulse Response of 251-tap Linear Phase FIR Filter');
xlabel('Time Index')
ylabel('Amplitude')
axis([0 250 -.15 .55]);
pause

figure(13)
subplot(2,1,1)
plot((0:1/1000:1-1/1000)*0.5,20*log10(abs(tt1+tt2)/2),'linewidth',1.5);
grid on
axis([0 0.5 -90 10])
title('Spectrum, Half-Band Linear Phase IIR Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(2,1,2)
plot(-.5:1/2000:.5-1/2000,fftshift(20*log10(abs(fft(gg,2000)))),'linewidth',1.5);
axis([0 .5 -90 10]);
grid on
title('Spectrum: Half-Band FIR Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

figure(14)
subplot(2,1,1)
plot((0:1/1000:1-1/1000)*0.5,20*log10(abs(tt1+tt2)/2),'linewidth',1.5);
grid on
axis([0 0.5 -0.00001 0.000005])
title('Spectrum, Passband Half-Band Linear Phase IIR Filter, IIR Ripple = 5 \mudB')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(2,1,2)
plot(-.5:1/2000:.5-1/2000,fftshift(20*log10(abs(fft(gg,2000)))),'linewidth',1.5);
axis([0 .5 -0.2 0.1]);
grid on
title('Spectrum: Passband Half-Band FIR Filter,FIR Ripple = 0.1 dB')
xlabel('Frequency')
ylabel('Log Mag (dB)')
% pause
% 
% axis([0 .5 -.4 .1])
% title('Detail of Amplitude Ripple, (FIR Ripple = 0.1 dB, IIR Ripple = 5 \mudB)')
% %pause
% %axis([0 .5 -.000009 .000001]);
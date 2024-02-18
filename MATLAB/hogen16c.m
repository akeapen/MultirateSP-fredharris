function hogen16c
% hoegennauer filter of order 4, differs from earlier which used order 3
% with up-sample ratio 1-to-16 from initial 1-to-4 shaping filter
% one of suite of three demontrations
% Script file written by fred harris of UCSD. Copyright 2021

% impulse response
x=zeros(1,5);
x(1)=1;

d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
d4=filter([1 -1],[1 0],d3);

figure(11)
subplot(4,2,1)
stem(0:4,d1,'b','linewidth',2);
grid on
axis([-1 5 -1.5 1.5])
title('Impulse Response, First Comb Filter')
ylabel('Amplitude')

subplot(4,2,3)
stem(0:4,d2,'b','linewidth',2);
grid on
axis([-1 5 -2.5 1.5])
title('Impulse Response, Second Comb Filter')
ylabel('Amplitude')

subplot(4,2,5)
stem(0:4,d3,'b','linewidth',2);
grid on
axis([-1 5 -4.5 4.5])
title('Impulse Response, Third Comb Filter')
ylabel('Amplitude')

subplot(4,2,7)
stem(0:4,d4,'b','linewidth',2);
grid on
axis([-1 5 -5.5 7.5])
title('Impulse Response, Fourth Comb Filter')
ylabel('Amplitude')
xlabel('Time Index')

zz=zeros(1,5);
dd4=reshape([d4;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,80);
s1=filter([1 0],[1 -1],dd4);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
s4=filter([1 0],[1 -1],s3);
ss4=s4;
subplot(4,2,2)
plot(0:79,s1,'b','linewidth',2);
grid on
axis([-1 60 -4 4])
title('Impulse Response, First Integrator')
ylabel('Amplitude')

subplot(4,2,4)
plot(0:79,s2,'b','linewidth',2);
grid on
axis([-1 60 -40 20])
title('Impulse Response, Second Integrator')
ylabel('Amplitude')

subplot(4,2,6)
plot(0:79,s3,'b','linewidth',2);
grid on
axis([-1 60 -200 200])
title('Impulse Response, Third Integrator')
ylabel('Amplitude')

subplot(4,2,8)
plot(0:79,s4,'b','linewidth',2);
grid on
axis([-1 60 -100 3000])
title('Impulse Response, Fourth Integrator')
ylabel('Amplitude')
xlabel('Time Index')

% step response
x=ones(1,6);

d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
d4=filter([1 -1],[1 0],d3);


figure(12)
subplot(4,2,1)
stem(0:5,d1,'b','linewidth',2);
grid on
axis([-1 6 -0.5 1.5])
title('Step Response, First Comb Filter')
ylabel('Amplitude')

subplot(4,2,3)
stem(0:5,d2,'b','linewidth',2);
grid on
axis([-1 6 -2.0 1.5])
title('Step Response, Second Comb Filter')
ylabel('Amplitude')

subplot(4,2,5)
stem(0:5,d3,'b','linewidth',2);
grid on
axis([-1 6 -2.5 1.5])
title('Step Response, Third Comb Filter')
ylabel('Amplitude')

subplot(4,2,7)
stem(0:5,d4,'b','linewidth',2);
grid on
axis([-1 6 -4.5 4.5])
title('Step Response, Fourth Comb Filter')
ylabel('Amplitude')
xlabel('Time Index')

zz=zeros(1,6);
d44=reshape([d4;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,96);
s1=filter([1 0],[1 -1],d44);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
s4=filter([1 0],[1 -1],s3);

subplot(4,2,2)
plot(0:95,s1,'b','linewidth',2);
grid on
axis([-1 50 -3 2])
title('Step Response, First Integrator')
ylabel('Amplitude')

subplot(4,2,4)
plot(0:95,s2,'b','linewidth',2);
grid on
axis([-1 50 -20 20])
title('Step Response, Second Integrator')
ylabel('Amplitude')

subplot(4,2,6)
plot(0:95,s3,'b','linewidth',2);
grid on
axis([-1 50 -20 220])
title('Step Response, Third Integrator')
ylabel('Amplitude')

subplot(4,2,8)
plot(0:95,s4,'b','linewidth',2);
grid on
axis([-1 50 -100 4500])
title('Step Response, Fourth Integrator')
ylabel('Amplitude')
xlabel('Time Index')

% system response

hh=remez(63,[0 0.5 0.7 2.0]/2.0,{'myfrf',[1 1 0 0]},[1 2]);
x=hh/max(hh);
figure(13)
subplot(2,1,1)
stem(-8:0.25:8-0.25,x,'b','linewidth',1.5)
grid
axis([-9 9 -0.3 1.2])
title('Impulse Response Shaped Pulse')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot([-.5:1/2048:.5-1/2048]*4,fftshift(20*log10(abs(fft(x/sum(x),2048)))),'b','linewidth',1.5);
grid
axis([-2.0 2.0 -80 10])
title('Spectra of 1-to-4 Shaped Pulse')
xlabel('Frequency')
ylabel('Log Mag (dB)')

d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
d4=filter([1 -1],[1 0],d3);

figure(14)
subplot(4,2,1)
plot(0:63,d1,'linewidth',1.5);
grid
axis([-2 65 -0.5 0.5])
title('Pulse Response First Comb')
ylabel('Amplitude')

subplot(4,2,3)
plot(0:63,d2,'linewidth',1.5);
grid
axis([-2 65 -0.3 0.3])
title('Pulse Response Second comb')
ylabel('Amplitude')

subplot(4,2,5)
plot(0:63,d3,'linewidth',1.5);
grid
axis([-2 65 -0.25 0.25])
title('Pulse Response Third Comb')
ylabel('Amplitude')

subplot(4,2,7)
plot(0:63,d4,'linewidth',1.5);
grid
axis([-2 65 -0.2 0.2])
title('Pulse Response Fourth Comb')
ylabel('Amplitude')
xlabel('Time Index')

zz=zeros(1,64);
d33=reshape([d4;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,16*64);

s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
s4=filter([1 0],[1 -1],s3);

subplot(4,2,2)
plot(s1,'linewidth',2);
grid on
axis([-30 1050 -0.25 0.25])
title('Pulse Response First Integrator')
ylabel('Amplitude')

subplot(4,2,4)
plot(s2,'linewidth',2)
grid on
axis([-30 1050 -6.0 5.0])
title('Pulse Response Second Integrator')
ylabel('Amplitude')

subplot(4,2,6)
plot(s3,'linewidth',2);
grid on
axis([-30 1050 -150 150])
title('Pulse Response Third integrator')
xlabel('Time Index')
ylabel('Amplitude')

subplot(4,2,8)
plot(s4,'linewidth',2);
grid on
axis([-30 1050 -1000 4500])
title('Pulse Response Fourth integrator')
xlabel('Time Index')
ylabel('Amplitude')

zz=zeros(1,64);
d33=reshape([d4;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,16*64);

s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
s4=filter([1 0],[1 -1],s3);

figure(15)
subplot(2,1,1)
plot([-.5:1/4096:.5-1/4096]*80,fftshift(20*log10(abs(fft(s4/sum(s4),4096)))),'b','linewidth',2);
hold on
plot([-.5:1/2048:.5-1/2048]*80,fftshift(20*log10(abs(fft(ss4/sum(ss4),2048)))),':r','linewidth',2);
hold off
grid
axis([-32 32 -100 10]);
title('Spectral Response 1-to-16 4-stage Hogenauer Filter')
ylabel('Log Mag (dB)')
xlabel('Frequency Normalized to Symbol Rate')

subplot(2,1,2)
plot([-.5:1/4096:.5-1/4096]*80,fftshift(20*log10(abs(fft(s4/sum(s4),4096)))),'b','linewidth',2);
hold on
plot([-.5:1/2048:.5-1/2048]*80,fftshift(20*log10(abs(fft(ss4/sum(ss4),2048)))),':r','linewidth',2);
hold off
grid
axis([-10 10 -100 10]);
title('Zoom')
ylabel('Log Mag (dB)')
xlabel('Frequency Normalized to Symbol Rate')


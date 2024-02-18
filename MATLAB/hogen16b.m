function hogen16b
% Hogenauer filter of order 3, with up-sample ratio 16
% with up-sample ratio 1-to-16 from initial 1-to-5 shaping filter
% one of suite of three demontrations
% Script file written by fred harris of UCSD. Copyright 2021

% impulse response
x=zeros(1,5);
x(1)=1;

d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
figure(1)
subplot(3,2,1)
stem(d1,'b','linewidth',2);
grid on
axis([0 6 -1.5 1.5]);
title('Impulse Response, First Stage Comb');
ylabel('Amplitude')

subplot(3,2,3)
stem(d2,'b','linewidth',2);
grid on
axis([0 6 -2.5 2.5]);
title('Impulse Response, Second Stage Comb');
ylabel('Amplitude')

subplot(3,2,5)
stem(d3,'b','linewidth',2);
grid on
axis([0 6 -4 4]);
title('Impulse Response of Third Stage Comb');
ylabel('Amplitude')
xlabel('Time Index')

zz=zeros(1,5);
d33=reshape([d3;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,80);
s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
ss3=s3;
subplot(3,2,2)
plot(s1,'b','linewidth',2);
grid on
axis([0 50 -3 3])
title('Impulse Response First Integrator')
ylabel('Amplitude')

subplot(3,2,4)
plot(s2,'b','linewidth',2)
grid on;
axis([0 50 -20 20]);
title('Impulse Response Second Integrator')
ylabel('Amplitude')

subplot(3,2,6)
plot(s3,'b','linewidth',2);
grid
axis([0 50 -20 220])
title('Impulse $esponse Third iIntegrator')
ylabel('Amplitude')
xlabel('Time Index')


% step response
x=ones(1,5);

d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
figure(2)
subplot(3,2,1)
stem(d1,'b','linewidth',2);
grid on
axis([0 6 -2 2]);
title('Step Response First Comb')
ylabel('Amplitude')

subplot(3,2,3);
stem(d2,'b','linewidth',2);
grid on
axis([0 6 -3 2])
title('Step Response Second Comb')
ylabel('Amplitude')

subplot(3,2,5)
stem(d3,'b','linewidth',2);
grid
axis([0 6 -4 4]);
title('Step Response Third Comb');
ylabel('Amplitude')
xlabel('Time Index')

zz=zeros(1,5);
d33=reshape([d3;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,80);
s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
subplot(3,2,2)
plot(s1,'b','linewidth',2);
grid
axis([0 50 -2.5 1.5])
title('Step Response First integrator')
subplot(3,2,4)
plot(s2,'b','linewidth',2);
grid
axis([0 50 -20 20])
title('Step Response Second Integrator')
subplot(3,2,6)
plot(s3,'b','linewidth',2);
grid
axis([0 50 -20 300])
title('Step Response Third Integrator')
ylabel('Amplitude')
xlabel('Time Index')


% system response

hh=remez(79,[0 0.5 0.7 2.5]/2.5,{'myfrf',[1 1 0 0]},[1 2]);
x=hh/max(hh);
figure(3)
subplot(2,1,1)
stem(-8:0.2:8-0.2,x,'linewidth',1.5)
grid
axis([-9 9 -0.3 1.2])
title('Impulse Response Shaped Pulse')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot([-.5:1/2048:.5-1/2048]*5,fftshift(20*log10(abs(fft(x/sum(x),2048)))),'linewidth',1.5);
grid
axis([-2.5 2.5 -80 10])
title('Spectra of 1-to-5 Shaped Pulse')
xlabel('Frequency')
ylabel('Log Mag (dB)')


d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);

figure(4)
subplot(3,2,1)
plot(d1,'linewidth',1.5);
grid
axis([0 80 -0.35 0.35])
title('Pulse Response First Comb')
ylabel('Amplitude')
subplot(3,2,3)
plot(d2,'linewidth',1.5);
grid
axis([0 80 -0.2 0.15])
title('Pulse Response Second comb')
ylabel('Amplitude')
subplot(3,2,5)
plot(d3,'linewidth',1.5);
grid
axis([0 80 -0.12 0.12])
title('Pulse Response Third Comb')
ylabel('Amplitude')
xlabel('Time Index')
zz=zeros(1,80);
d33=reshape([d3;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,16*80);

s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
subplot(3,2,2)
plot(s1,'linewidth',2);
grid on
axis([0 1300 -0.2 0.15])
title('Pulse Response First Integrator')
ylabel('Amplitude')

subplot(3,2,4)
plot(s2,'linewidth',2)
grid on
axis([0 1300 -5.7 5.7])
title('Pulse Response Second Integrator')
ylabel('Amplitude')

subplot(3,2,6)
plot(s3,'linewidth',2);
grid on
axis([0 1300 -100 300])
title('Pulse Response Third integrator')
xlabel('Time Index')
ylabel('Amplitude')

figure(5)
subplot(2,1,1)
plot([-.5:1/4096:.5-1/4096]*80,fftshift(20*log10(abs(fft(s3/sum(s3),4096)))),'b','linewidth',2);
hold on
plot([-.5:1/2048:.5-1/2048]*80,fftshift(20*log10(abs(fft(ss3/sum(ss3),2048)))),':r','linewidth',2);
hold off
grid
axis([-32 32 -100 10]);
title('Spectral Response 1-to-16 3-stage Hogenauer Filter')
ylabel('Log Mag (dB)')
xlabel('Frequency Normalized to Symbol Rate')

subplot(2,1,2)
plot([-.5:1/4096:.5-1/4096]*80,fftshift(20*log10(abs(fft(s3/sum(s3),4096)))),'b','linewidth',2);
hold on
plot([-.5:1/2048:.5-1/2048]*80,fftshift(20*log10(abs(fft(ss3/sum(ss3),2048)))),':r','linewidth',2);
hold off
grid
axis([-10 10 -100 10]);
title('Zoom')
ylabel('Log Mag (dB)')
xlabel('Frequency Normalized to Symbol Rate')


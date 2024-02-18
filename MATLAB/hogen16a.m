function hogen16a
% Hogenauer filter of order 3, with up-sample ratio 1-to-16
% one of suite of three demonstrations
% Script file written by fred harris of UCSD. Copyright 2021

% impulse response
x=zeros(1,5);
x(1)=1;

d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
figure(1)
plot(0:4,d1,'b','linewidth',2);
hold on;
plot(0:4,d2,'r','linewidth',2);
plot(0:4,d3,'k','linewidth',2);
hold off;
grid on;
axis([-1 5 -4 4]);
title('Impulse Response of Three Stage Digital Derivative');
xlabel('Time Index')
ylabel('Amplitude')
pause

figure(2)
zz=zeros(1,5);
d33=reshape([d3;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,80);
s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
plot(0:50,s1(1:51),'b','linewidth',2);
hold on;
plot(0:50,s2(1:51),'r','linewidth',2);
plot(0:50,s3(1:51),'k','linewidth',2);
hold off;
grid on
axis([0 50 -20 200])
title('Impulse Response of Three Stage CIC')
xlabel('Time Index')
ylabel('Amplitude')
pause

% step response
x=ones(1,5);

figure(3)
d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
plot(d1,'b','linewidth',2);
hold on;
plot(d2,'r','linewidth',2);
plot(d3,'k','linewidth',2);
hold off;
grid on
axis([0 6 -4 4]);
title('Step Response of Three Stage Digital Derivative');
xlabel('Time Index')
ylabel('Amplitude')
pause

figure(4)
zz=zeros(1,5);
d33=reshape([d3;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,80);
s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
plot(s1,'b','linewidth',2);
hold on;
plot(s2,'r','linewidth',2);
plot(s3,'k','linewidth',2);
hold off;
grid on
axis([0 80 -20 300])
title('Step Response of Three Stage CIC')
xlabel('Time Index')
ylabel('Amplitude')
pause

% system response
x=sinc(-8:.25:8);ww=kaiser(65,6);x=x.*ww';
figure(5)
plot([-.5:1/2048:.5-1/2048]*4,fftshift(20*log10(abs(fft(x/sum(x),2048)))),'b','linewidth',2);
grid on
title('Spectra of 1-to-4 Shaped Pulse')
xlabel('Frequency')
ylabel('Log mag (dB)')

pause
figure(6)
d1=filter([1 -1],[1 0],x);
d2=filter([1 -1],[1 0],d1);
d3=filter([1 -1],[1 0],d2);
subplot(3,1,1)
plot(0:64,d1,'b','linewidth',2);
grid on
axis([-1 65 -0.5 0.5])
title('Pulse Response of First Stage Digital Derivative')
ylabel('Amplitude')

subplot(3,1,2)
plot(0:64,d2,'r','linewidth',2);
axis([-1 65 -0.25 0.25])
grid on
title('Pulse Response of Second Stage Digital Derivative')
ylabel('Amplitude')

subplot(3,1,3)
plot(0:64, d3,'k','linewidth',2);
axis([-1 65 -0.15 0.15])
grid on
title('Pulse Response of Third Stage Digital Derivative')
xlabel('Time Index')
ylabel('Amplitude')

pause
figure(7)
zz=zeros(1,65);

d33=reshape([d3;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz],1,16*65);

s1=filter([1 0],[1 -1],d33);
s2=filter([1 0],[1 -1],s1);
s3=filter([1 0],[1 -1],s2);
plot(s1,'b','linewidth',2);
hold on;
plot(s2,'r','linewidth',2);
plot(s3,'k','linewidth',2);
hold off;
title('Pulse Response of Three Stage CIC')
xlabel('Time Index')
ylabel('Amplitude')

pause

figure(8)
plot([-.5:1/2048:.5-1/2048]*64,fftshift(20*log10(abs(fft(s3/sum(s3),2048)))),'b','linewidth',2);
grid on
axis([-32 32 -100 10]);
title('Spectral Response 1-to-16 Three Stage CIC')
xlabel('Frequency')
ylabel('Log mag (dB)')

pause
axis([-8 +8 -100 10]);

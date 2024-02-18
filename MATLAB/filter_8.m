% demo of efficient 1-to-8 upsampler
% input sample rate 8 kHz, input bandwidth 3.5 k Hz
% 12 bit dynamic range: 
% recursive polyphase model; first stage 5 coef, second stage 2-coef, third stage 2-coef
% approximately two multiplies per output point
% generate comb of sinusoids spanning input frequency span...
%  Script file written by fred harris of UCSD. Copyright 2021

x=cos(2*pi*(0:1999)*(0.5/8)+2*pi*rand(1));
x=x+cos(2*pi*(0:1999)*(1/8)+2*pi*rand(1));
x=x+cos(2*pi*(0:1999)*(1.5/8)+2*pi*rand(1));
x=x+cos(2*pi*(0:1999)*(2/8)+2*pi*rand(1));
x=x+cos(2*pi*(0:1999)*(2.5/8)+2*pi*rand(1));
x=x+cos(2*pi*(0:1999)*(3/8)+2*pi*rand(1));
x=x+cos(2*pi*(0:1999)*(3.5/8)+2*pi*rand(1));


% first stage half band filter

c_01 = 0.07294398784852;
c_02 = 0.48088374109844;
c_03 = 0.89653508312853;

c_11 = 0.25672675911256;
c_12 = 0.69620335640375;

reg_0=zeros(1,4);
reg_1=zeros(1,3);

mm=1;
for nn=1:500
    sm_01=(x(nn)-reg_0(2))*c_01+reg_0(1);
    sm_02=(sm_01-reg_0(3))*c_02+reg_0(2);
    sm_03=(sm_02-reg_0(4))*c_03+reg_0(3);
    
    sm_11=(x(nn)-reg_1(2))*c_11+reg_1(1);
    sm_12=(sm_11-reg_1(3))*c_12+reg_1(2);
    
    reg_0=[x(nn) sm_01 sm_02 sm_03];
    reg_1=[x(nn) sm_11 sm_12];
    
    y1(mm)  =sm_03;
    y1(mm+1)=sm_12;
    mm=mm+2;
end

figure(1)
subplot(2,1,1)
w1=kaiser(500,10)';
w1=w1/sum(w1);
plot((-0.5:1/1024:0.5-1/1024)*8,fftshift(20*log10(abs(fft(x(1:500).*w1,1024)))),'linewidth',1.5)
grid
axis([-4 4 -90 0])
title('Input Spectrum at 8-kHz Sample Rate')
xlabel('Frequency (kHz)')
ylabel('Log Mag (dB)')

subplot(2,1,2)
w2=kaiser(1000,10)';
w2=w2/sum(w2);
plot((-0.5:1/1024:0.5-1/1024)*16,fftshift(20*log10(abs(fft(y1(1:1000).*w2,1024)))),'linewidth',1.5)
grid
axis([-8 8 -90 0])
title('Output Spectrum, First 1-to-2 Upsample at 16-kHz Sample Rate')
xlabel('Frequency (kHz)')
ylabel('Log Mag (dB)')
     
% second stage half band filter

c_21 = 0.129456720509504;
c_31 = 0.570592731905995;
reg_2=zeros(1,2);
reg_3=zeros(1,2);

mm=1;
for nn=1:1000
    sm_21=(y1(nn)-reg_2(2))*c_21+reg_2(1);
       
    sm_31=(y1(nn)-reg_3(2))*c_31+reg_3(1);
        
    reg_2=[y1(nn) sm_21];
    reg_3=[y1(nn) sm_31];
    
    y2(mm)  =sm_21;
    y2(mm+1)=sm_31;
    mm=mm+2;
end

% third stage half band filter

c_41 = 0.12474452570860;

c_51 = 0.56258495288732;

reg_4=zeros(1,2);
reg_5=zeros(1,2);

mm=1;
for nn=1:2000
    sm_41=(y2(nn)-reg_4(2))*c_41+reg_4(1);
       
    sm_51=(y2(nn)-reg_5(2))*c_51+reg_5(1);
        
    reg_4=[y2(nn) sm_41];
    reg_5=[y2(nn) sm_51];
    
    y3(mm)  =sm_41;
    y3(mm+1)=sm_51;
    mm=mm+2;
end



figure(2)
subplot(2,1,1)
w2=kaiser(2000,10)';
w2=w2/sum(w2);
plot((-0.5:1/2048:0.5-1/2048)*32,fftshift(20*log10(abs(fft(y2(1:2000).*w2,2048)))),'linewidth',1.5)
grid
axis([-16 16 -90 0])
title('Output Spectrum, Second 1-to-2 Upsample at 32-kHz Sample Rate')
xlabel('Frequency (kHz)')
ylabel('Log Mag (dB)')

subplot(2,1,2)
w3=kaiser(2048,10)';
w3=w3/sum(w3);
plot((-0.5:1/2048:0.5-1/2048)*64,fftshift(20*log10(abs(fft(y3(1:2048).*w3,2048)))),'linewidth',1.5)
grid
axis([-32 32 -90 0])
title('Output Spectrum, Third 1-to-2 Upsample at 64-kHz sSample Rate')
xlabel('Frequency (kHz)')
ylabel('Log Mag (dB)')






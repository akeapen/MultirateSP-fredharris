function six_stage_4
% six stage half band resampling filters
% two stages 8-to-1 downsamplig filters
% one stage 64-to-1 downsampling filter
% one stage sloped stopband 32-to-1 downsampling filter
% each processing a 2-stage sigma-delta converter 64-to-1 oversampled
% Script file written by fred harris of UCSD. Copyright 2021

%first stage
figure(1)

hh1=remez(4,[0 15 1920-15 1920]/1920,[1 1 0 0],[1 1]);
plot((-.5:1/1024:.5-1/1024)*3840,fftshift(20*log10(abs(fft(hh1,1024)))),'b','linewidth',1.5);
grid on;
axis([-1920 1920 -100 10])
hold on
plot([-1920+15 -1920+15 -1920],[0 -80 -80],'r','linewidth',1.5)
plot([1920-15 1920-15 1920],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/2,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/2,[0 -100],'--r','linewidth',1.5)
hold off
title('First Stage: 5-tap Filter: Input Sample Rate = 128 f_n_y_q = 3840')
xlabel('frequency')
ylabel('Log Mag (dB)')

pause

%second stage
hh2=remez(6,[0 15 0.5*1920-15 0.5*1920]/(0.5*1920),[1 1 0 0],[1 1]);
figure(2)
plot((-.5:1/1024:.5-1/1024)*3840/2,fftshift(20*log10(abs(fft(hh2,1024)))),'b','linewidth',1.5);
grid on;
axis([-1920/2 1920/2 -100 10])
hold on
plot([-1920/2+15 -1920/2+15 -1920/2],[0 -80 -80],'r','linewidth',1.5)
plot([1920/2-15 1920/2-15 1920/2],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/4,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/4,[0 -100],'--r','linewidth',1.5)
hold off
title('Second Stage: 7-tap Filter: Input Sample Rate = 64 f_n_y_q = 1920')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause

%third stage
hh3=remez(6,[0 15 0.25*1920-15 0.25*1920]/(0.25*1920),[1 1 0 0],[1 1]);
figure(3)
plot((-.5:1/1024:.5-1/1024)*3840/4,fftshift(20*log10(abs(fft(hh3,1024)))),'b','linewidth',1.5);
grid on;
axis([-1920/4 1920/4 -100 10])
hold on
plot([-1920/4+15 -1920/4+15 -1920/4],[0 -80 -80],'r','linewidth',1.5)
plot([1920/4-15 1920/4-15 1920/4],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/8,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/8,[0 -100],'--r','linewidth',1.5)
hold off
title('Third Stage: 7-tap Filter: Input Ssample Rate = 32 f_n_y_q = 960')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
%fourth stage
figure(4)
hh4=remez(6,[0 15 0.125*1920-15 0.125*1920]/(0.125*1920),[1 1 0 0],[1 1]);
plot((-.5:1/1024:.5-1/1024)*3840/8,fftshift(20*log10(abs(fft(hh4,1024)))),'b','linewidth',1.5);
grid on;
axis([-1920/8 1920/8 -100 10])
hold on
plot([-1920/8+15 -1920/8+15 -1920/8],[0 -80 -80],'r','linewidth',1.5)
plot([1920/8-15 1920/8-15 1920/8],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/16,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/16,[0 -100],'--r','linewidth',1.5)
hold off
title('Fourth Stage: 7-tap Filter: Input Sample Rate = 16 f_n_y_q = 480')

pause
figure(5)
%fifth stage
hh5=remez(10,[0 15 0.0625*1920-15 0.0625*1920]/(0.0625*1920),[1 1 0 0],[1 4]);
plot((-.5:1/1024:.5-1/1024)*3840/16,fftshift(20*log10(abs(fft(hh5,1024)))),'b','linewidth',1.5);
grid;
axis([-1920/16 1920/16 -100 10])
hold on
plot([-1920/16+15 -1920/16+15 -1920/16],[0 -80 -80],'r','linewidth',1.5)
plot([1920/16-15 1920/16-12 1920/16],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/32,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/32,[0 -100],'--r','linewidth',1.5)
hold off
title('Fifth Stage: 8-tap Filter: Input Sample Rate = 8 f_n_y_q = 240')

pause
figure(6)
%sixth stage
hh6=remez(18,[0 15 0.03125*1920-15 0.03125*1920]/(0.03125*1920),[1 1 0 0],[1 1]);
plot((-.5:1/1024:.5-1/1024)*3840/32,fftshift(20*log10(abs(fft(hh6,1024)))),'b','linewidth',1.5);
grid on;
axis([-1920/32 1920/32 -100 10])
hold on
plot([-1920/32+15 -1920/32+15 -1920/32],[0 -80 -80],'r','linewidth',1.5)
plot([1920/32-15 1920/32-15 1920/32],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/64,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/64,[0 -100],'--r','linewidth',1.5)
hold off
title('Sixth Stage: 15-tap Filter: Input Sample Rrate = 4 f_n_y_q = 120')


pause
% building sigma-delta loop
xx=0.8*cos(2*pi*(0:19999)*10.031/3840);  % Input time series to sigma delta

reg=[0 0];
for nn=1:20000
    sm2=reg(1)+reg(2);
    sm3=reg(1)+0.1*reg(2);
    yy(nn)=sign(sm3);
    sm1=xx(nn)+reg(1)-0.000125*sm2-yy(nn);
    reg=[sm1 sm2];
end
% output of sigma delta
figure(7)
subplot(2,1,1)
plot(xx(1:1000),'r','linewidth',2.)
hold on
plot(yy(1:1000),'b','linewidth',1.0);
hold off
grid on
axis([0 1000 -1.1 1.1]);
title('Time Series; Input Sinusoid (Red), Output of Sigma-Delta Loop (Blue)')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(yy(1:4096).*ww)))),'b','linewidth',1.0);
grid;
axis([-1920 1920 -100 10])
title('Spectrum; Output of Sigma-Delta Loop')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
% output of first stage
figure(8)
y1=filter(hh1,1,yy);
subplot(2,1,1)
plot(y1(1:1000),'b','linewidth',1.0);
grid on
axis([0 1000 -1.2 1.2]);
title('Time Series; Output of 1-st Half-Band, Before 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(y1(1:4096).*ww)))),'b','linewidth',1.0);
hold on
plot([-960 -960],[0 -100],'--r','linewidth',1.5)
plot([960 960],[0 -100],'--r','linewidth',1.5)
hold off
grid on;
axis([-1920 1920 -100 10])
title('Spectrum: Output of 1-st Half Band Filter, Folding at 960')
pause

figure(9)
y1a=y1(1:2:length(y1));
subplot(2,1,1)
plot(y1a(1:500),'b','linewidth',1.0);
grid on
axis([0 500 -1.2 1.2]);
title('Time Series; Output of 1-st Half-Band Filter, After 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840/2,fftshift(20*log10(abs(fft(y1a(1:4096).*ww)))),'b','linewidth',1.0);
grid on;
axis([-1920/2 1920/2 -100 10])
title('Spectrum: Output of 1-st Half Band Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(10)
%output of second stage
y2=filter(hh2,1,y1a);
subplot(2,1,1)
plot(y2(1:500),'b','linewidth',1.0);
grid
axis([0 500 -1.2 1.2]);
title('Time Series; Output of 2-nd Half-Band Filter, Before 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')
subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840/2,fftshift(20*log10(abs(fft(y2(1:4096).*ww)))),'b','linewidth',1.0);
hold on
plot([-480 -480],[0 -100],'--r','linewidth',1.5)
plot([480 480],[0 -100],'--r','linewidth',1.5)
hold off
grid on;
axis([-1920/2 1920/2 -100 10])
title('Spectrum: Output of 2-nd Half-Band Filter, Folding at 480')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(11)
y2a=y2(1:2:length(y2));
subplot(2,1,1)
plot(y2a(1:250),'b','linewidth',1.0);
grid on
axis([0 250 -1.2 1.2]);
title('Time Series; Output of 2-nd Half-Band Filter, After 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840/4,fftshift(20*log10(abs(fft(y2a(1:4096).*ww)))),'b','linewidth',1.9);
grid on;
axis([-1920/4 1920/4 -100 10])
title('Spectrum: Output of 2-nd Half-Band Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(12)
%output of third stage
y3=filter(hh3,1,y2a);
subplot(2,1,1)
plot(y3(1:250),'b','linewidth',1.0);
grid
axis([0 250 -1.2 1.2]);
title('Time Series; Output of 3-rd Half-Band Filter, Before 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840/4,fftshift(20*log10(abs(fft(y3(1:4096).*ww)))),'b','linewidth',1.0);
hold on
plot([-240 -240],[0 -100],'--r','linewidth',1.5)
plot([240 240],[0 -100],'--r','linewidth',1.5)
hold off
grid on;
axis([-1920/4 1920/4 -100 10])
title('Spectrum: Output of 3-rd Half-Band filter, Folding at 240')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(13)
y3a=y3(1:2:length(y3));
subplot(2,1,1)
plot(y3a(1:125),'b','linewidth',1.0);
grid on
axis([0 125 -1.2 1.2]);
title('Time Series; Output of 3-rd Half-Band Filter, After 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(2048,12)';
ww=ww/sum(ww);
plot((-.5:1/2048:.5-1/2048)*3840/8,fftshift(20*log10(abs(fft(y3a(1:2048).*ww)))),'b','linewidth',1.0);
grid on;
axis([-1920/8 1920/8 -100 10])
title('Spectrum: Ooutput of 3-rd Half-Band Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(14)
%output of fourth stage
y4=filter(hh4,1,y3a);
subplot(2,1,1)
plot(y4(1:125),'b','linewidth',1.0);
grid on
axis([0 125 -1.2 1.2]);
title('Time Series; Output of 4-th Half-Band, Before 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(2048,12)';
ww=ww/sum(ww);
plot((-.5:1/2048:.5-1/2048)*3840/8,fftshift(20*log10(abs(fft(y4(1:2048).*ww)))),'b','linewidth',1.0);
hold on
plot([-120 -120],[0 -100],'--r','linewidth',1.5)
plot([120 120],[0 -100],'--r','linewidth',1.5)
hold off
grid on;
axis([-1920/8 1920/8 -100 10])
title('Spectrum: Output of 4-th Half-Band Filter, Folding at 120')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
figure(15)
y4a=y4(1:2:length(y4));
subplot(2,1,1)
plot(y4a(1:65),'b','linewidth',1.0);
grid on
axis([0 65 -1.2 1.2]);
title('Time Series; Output of 4-th Half-Band Filter, After 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(1024,12)';
ww=ww/sum(ww);
plot((-.5:1/1024:.5-1/1024)*3840/16,fftshift(20*log10(abs(fft(y4a(1:1024).*ww)))),'b','linewidth',1.50);
grid on;
axis([-1920/16 1920/16 -100 10])
title('Spectrum: Output of 4-th Half-Band Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(16)
%output of fifth stage
y5=filter(hh5,1,y4a);
subplot(2,1,1)
plot(y5(1:65),'b','linewidth',1.0);
grid on
axis([0 65 -1.2 1.2]);
title('Time Series; Output of 5-th Half-Band Filter, Before 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(1024,12)';
ww=ww/sum(ww);
plot((-.5:1/1024:.5-1/1024)*3840/16,fftshift(20*log10(abs(fft(y5(1:1024).*ww)))),'b','linewidth',1.0);
hold on
plot([-60 -60],[0 -100],'--r','linewidth',1.5)
plot([60 60],[0 -100],'--r','linewidth',1.5)
hold off
grid on;
axis([-1920/16 1920/16 -100 10])
title('Spectrum: Output of 5-th Half-Band Filter, Folding at 60')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(17)
y5a=y5(1:2:length(y5));
subplot(2,1,1)
plot(y5a(1:35),'b','linewidth',1.5);
grid on
axis([0 35 -1.2 1.2]);
title('Time Series; Output of 5-th Half-Band Filter, After 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(512,12)';
ww=ww/sum(ww);
plot((-.5:1/512:.5-1/512)*3840/32,fftshift(20*log10(abs(fft(y5a(1:512).*ww)))),'b','linewidth',1.5);
grid on;
axis([-1920/32 1920/32 -100 10])
title('Spectrum: Output of 5-th Half-Band Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(18)
%output of sixth stage
y6=filter(hh6,1,y5a);
subplot(2,1,1)
plot(y5(1:35),'b','linewidth',1.5);
grid on
axis([0 35 -1.2 1.2]);
title('Time Series;Output of 6-th Half-Band, Before 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(512,12)';
ww=ww/sum(ww);
plot((-.5:1/512:.5-1/512)*3840/32,fftshift(20*log10(abs(fft(y6(1:512).*ww)))),'b','linewidth',1.5);
hold on
plot([-30 -30],[0 -100],'--r','linewidth',1.5)
plot([30 30],[0 -100],'--r','linewidth',1.5)
hold off
grid on ;
axis([-1920/32 1920/32 -100 10])
title('Spectrum: Output of 6-th Half-Band Filter, Folding at 30')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
figure(19)
y6a=y6(1:2:length(y6));
subplot(2,1,1)
plot(y6a(1:25),'b','linewidth',1.5);
grid on
axis([0 25 -1.2 1.2]);
title('Time Series; Output of 6-th Half-Band, After 2-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(256,12)';
ww=ww/sum(ww);
plot((-.5:1/256:.5-1/256)*3840/64,fftshift(20*log10(abs(fft(y6a(1:256).*ww)))),'b','linewidth',1.5);
grid;
axis([-1920/64 1920/64 -100 10])
title('Spectrum: Output of 6-th Half-Band Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

% now repeat with two stages of 8-to-1 downsampling
figure(20)
gg1=remez(31,[0 15 3840/8-15 1920]/1920,{'myfrf',[1 1 0 0]},[1 25]);
plot((-.5:1/1024:.5-1/1024)*3840,fftshift(20*log10(abs(fft(gg1,1024)))),'b','linewidth',1.5);
grid;
axis([-1920 1920 -90 10])
hold on
plot([-3840/8+15 -3840/8+15 -1920],[0 -80 -80],'r','linewidth',1.5)
plot([3840/8-15 3840/8-15 1920],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/8,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/8,[0 -100],'--r','linewidth',1.5)
hold off
title('First Stage: 32-tap, 8-to-1 PolyphaseFfilter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
figure(21)
gg2=remez(63,[0 15 60-15 240]/240,{'myfrf',[1 1 0 0]},[1 051]);
plot((-.5:1/1024:.5-1/1024)*3840/8,fftshift(20*log10(abs(fft(gg2,1024)))),'b','linewidth',1.5);
grid on;
axis([-1920/8 1920/8 -100 10])
hold on
plot([-1920/32+15 -1920/32+15 -1920/8],[0 -80 -80],'r','linewidth',1.5)
plot([1920/32-15 1920/32-15 1920/8],[0 -80 -80],'r','linewidth',1.5)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.5)
plot([-1920 -1920]/64,[0 -100],'--r','linewidth',1.5)
plot([1920 1920]/64,[0 -100],'--r','linewidth',1.5)
hold off
title('Second Stage: 64-tap, 8-to-1 Polyphase Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
figure(22)
subplot(2,1,1)
plot(xx(1:1000),'r','linewidth',2.0)
hold
plot(yy(1:1000),'b','linewidth',1);
hold
grid
axis([0 1000 -1.1 1.1]);
title('Time Series; Output of Sigma-Delta Loop')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(yy(1:4096).*ww)))),'b','linewidth',1.0);
grid on;
axis([-1920 1920 -100 10])
title('Spectrum; Output of Sigma-Delta Loop')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

% now filter with two 8-stage filters
% output of first 8=to-1 filter stage
figure(23)
yy1=filter(gg1,1,yy);
subplot(2,1,1)
plot(yy1(1:1000),'b','linewidth',1.5);
grid
axis([0 1000 -1.2 1.2]);
title('Time Series; Output of 1-st 8-to-1 Polyphase, Before 8-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(yy1(1:4096).*ww)))),'b','linewidth',1.5);
hold on
plot([-240 -240],[0 -100],'--r')
plot([240 240],[0 -100],'--r')
hold off
grid on;
axis([-1920 1920 -100 10])
title('Spectrum: Output of 1-st 8-to-1 Polyphase Filter, Folding at 240')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(24)
yy1a=yy1(1:8:length(yy1));
subplot(2,1,1)
plot(yy1a(1:125),'b','linewidth',1.5);
grid
axis([0 125 -1.2 1.2]);
title('Time Series; Output of 1-st 8-to-1 Polyphase, After 8-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(2048,12)';
ww=ww/sum(ww);
plot((-.5:1/2048:.5-1/2048)*3840/8,fftshift(20*log10(abs(fft(yy1a(1:2048).*ww)))),'b','linewidth',1.0);
grid;
axis([-1920/8 1920/8 -100 10])
title('Spectrum: Output of 1-st 8-to-1 Polyphase Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

%output of second stage
figure(25)
yy2=filter(gg2,1,yy1a);
subplot(2,1,1)
plot(yy2(1:125),'b','linewidth',1.5);
grid on
axis([0 125 -1.2 1.2]);
title('Time Series; output of 2-nd 8-to-1 Polyphase, Before 8-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(2048,10)';
ww=ww/sum(ww);
plot((-.5:1/2048:.5-1/2048)*3840/8,fftshift(20*log10(abs(fft(yy2(1:2048).*ww)))),'b','linewidth',1.0);
hold on
plot([-30 -30],[0 -100],'--r','linewidth',1.5)
plot([30 30],[0 -100],'--r','linewidth',1.5)
hold off
grid on;
axis([-1920/8 1920/8 -100 10])
title('Spectrum: Output of 2-nd 8-to-1 Polyphase Filter, folding at 30')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(26)
yy2a=yy2(1:8:length(yy2));
subplot(2,1,1)
plot(yy2a(1:25),'b','linewidth',1.5);
grid on
axis([0 25 -1.2 1.2]);
title('Time Series; Output of 2-nd 8-to-1 Polyphase, After 8-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(256,12)';
ww=ww/sum(ww);
plot((-.5:1/256:.5-1/256)*3840/64,fftshift(20*log10(abs(fft(yy2a(1:256).*ww)))),'b','linewidth',1.5);
grid on;
axis([-1920/64 1920/64 -100 10])
title('Spectrum: Output of 2-nd 8-to-1 Polyphase Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

% now run data through single 64-stage polyphase filter
gg3=remez(511,[0 15 60-15 1920]/1920,{'myfrf',[1 1 0 0]},[1 30]);
figure(27)
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(gg3,4096)))),'b','linewidth',1.5);
grid on;
axis([-1920 1920 -100 10])
hold on
plot([-60+15 -60+15 -1920],[0 -80 -80],'r','linewidth',1.0)
plot([60-15 60-15 1920],[0 -80 -80],'r','linewidth',1.0)
plot([-15 -15 15 15],[-100 0 0 -100],'r','linewidth',1.0)
plot([-1920 -1920]/64,[0 -100],'--r','linewidth',1.0)
plot([1920 1920]/64,[0 -100],'--r','linewidth',1.0)
hold off
title('512-tap, 64-to-1 polyphase filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
figure(28)
subplot(2,1,1)
plot(xx(1:1000),'r','linewidth',2.0)
hold on
plot(yy(1:1000),'b','linewidth',1.0);
hold off
grid on
axis([0 1000 -1.1 1.1]);
title('Time Series; Output of Sigma-Delta Loop')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(yy(1:4096).*ww)))),'linewidth',1.0);
grid on;
axis([-1920 1920 -100 10])
title('Spectrum; Output of Sigma-Delta Loop')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

% now filter with one 64-stage filter
figure(29)
yy3=filter(gg3,1,yy);
subplot(2,1,1)
plot(yy3(1:1000),'b','linewidth',1.0);
grid on
axis([0 1000 -1.2 1.2]);
title('Time Series; Output of 448-tap, 64-to-1 Polyphase, Before 64-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,12)';
ww=ww/sum(ww);
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(yy3(201:4296).*ww)))),'b','linewidth',1.0);
hold on
plot([-30 -30],[0 -100],'--r','linewidth',1.5)
plot([30 30],[0 -100],'--r','linewidth',1.5)
hold off
grid on;
axis([-1920 1920 -100 10])
title('Spectrum: Output of 448-tap, 64-to-1 Polyphase Filter, Folding at 30')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause
axis([-100 100 -100 10])
pause

figure(30)
yy3a=yy3(1:64:length(yy3));
subplot(2,1,1)
plot(yy3a(1:25),'b','linewidth',1.0);
grid on
axis([0 25 -1.2 1.2]);
title('Time Series; Output of 448-tap, 64-to-1 Polyphase, After 64-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(256,10)';
plot((-.5:1/256:.5-1/256)*3840/64,fftshift(20*log10(abs(fft(yy3a(1:256).*ww)/128))),'b','linewidth',1.0);
grid;
axis([-30 30 -100 10])
title('Spectrum: Output of 448-tap, 64-to-1 Polyphase Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause

hh=[ .000217190458    .000193437245      .000119853755      .0000652997374      .00000975540434...
    -.0000381429644  -.0000858213764    -.000129999763     -.000174150172      -.000216503983...
    -.000259375409   -.000301815032     -.000345228630     -.000388708671      -.000433133323...
    -.000477919343   -.000523824319     -.000570364379     -.000617958865      -.000666074053...
    -.000714983470   -.000764243776     -.000814032386     -.000863904094      -.000913946982...
    -.000963775601   -.00101344940      -.00106256917      -.00111106385       -.00115848271...
    -.00120471249    -.00124934707      -.00129226142      -.00133304743       -.00137153983...
    -.00140734228    -.00144027870      -.00146994939      -.00149613097       -.00151840850...
    -.00153655166    -.00155017311      -.00155903842      -.00156275125       -.00156105250...
    -.00155355703    -.00154002268      -.00152009393      -.00149353788       -.00146001992...
    -.00141932853    -.00137116443      -.00131533141      -.00125154024       -.00117959804...
    -.00109924358    -.00101032038      -.000912611177     -.000805988750     -.000690268728...
    -.000565358561   -.000431121685     -.000287506990     -.000134418986      .0000281558443...
     .000200261359    .000381856263      .000572928392      .000773393244      .000983194764...
     .00120220147     .00143029826       .00166729660       .00191302623       .00216725008...
     .00242974447     .00270021954       .00297839936       .00326395111       .00355655572...
     .00385583468     .00416141466       .00447286519       .00478976488       .00511164289...
     .00543803566     .00576843026       .00610232070       .00643915913       .00677840757...
     .00711948865     .00746183267       .00780483550       .00814790625       .00849042707...
     .00883179237     .00917136902       .00950853532       .00984264886       .0101730837...
     .0104991980      .0108203664        .0111359521        .0114453391        .0117479068...
     .0120430565      .0123301856        .0126087144        .0128780664        .0131376927...
     .0133870526      .0136256324        .0138529284        .0140684666        .0142717889...
     .0144624696      .0146401008        .0148043065        .0149547332        .0150910623... 
     .0152130003      .0153202868        .0154126864        .0154899980        .0155520510...
     .0155987110      .0156298754        .0156454753];
  
 hh=[hh fliplr(hh)];
figure(31)
hh=sinc(-2:1/64:2).*kaiser(257,3)';
hh=hh/sum(hh);
ww=kaiser(4096,10)';
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(yy(1:4096).*ww)/2048))),'linewidth',1.0);
axis([-1920 1920 -100 10])
grid on
title('Spectrum; Output of Sigma-Delta Loop')
xlabel('Frequency')
ylabel('Log Mag (dB)')
hold on

pause
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(hh,4096)))),'r','linewidth',1.5);
hold off
title('Spectrum: Output of Sigma-Delta and of 256-tap Filter with Sidelobe Ddecay of 6-dB/Octave')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(32)
yy4=filter(hh,1,yy);
subplot(2,1,1)
plot(yy4(1:1000),'b','linewidth',1.0);
grid
axis([0 1000 -1.2 1.2]);
title('Time Series; Output of 256-tap, 64-to-1 Polyphase Low-Pass Filter, Before 64-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,10)';
plot((-.5:1/4096:.5-1/4096)*3840,fftshift(20*log10(abs(fft(yy4(101:4196).*ww)/2148))),'b','linewidth',1.0);
hold on
plot([-30 -30],[0 -100],'--r','linewidth',1.0)
plot([30 30],[0 -100],'--r','linewidth',1.0)
hold off
grid on;
axis([-1920 1920 -100 10])
title('Spectrum: Ooutput of 256-tap, 64-to-1 Polyphase Filter, Folding at 30')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause
axis([-100 100 -100 10])
pause

figure(33)
yy4a=yy4(1:64:length(yy4));
subplot(2,1,1)
plot(yy4a(1:25),'linewidth',1.5);
grid
axis([0 25 -1.2 1.2]);
title('Time Series; Output of 256-tap, 64-to-1 Polyphase, After 64-to-1 Downsampling')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(256,10)';
plot((-.5:1/256:.5-1/256)*3840/64,fftshift(20*log10(abs(fft(yy4a(1:256).*ww)/128))),'b','linewidth',1.0);
grid;
axis([-30 30 -100 10])
title('Spectrum: Output of 256-tap, 64-to-1 Polyphase Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

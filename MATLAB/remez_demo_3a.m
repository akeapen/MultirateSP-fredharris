% demonstration of passband and stopband spectral effects on filters designed with
% myfrf variant of remez algorithm
% Script file written by fred harris of UCSD. Copyright 2021

h1=remez(154,[0, 0.6, 3.4, 64]/64, [1 1 0 0], [1 1]);
figure(1)
plot((-0.5:1/1024:0.5-1/1024)*128,20*log10(abs(fftshift(fft(h1,1024)))),'b','linewidth',2)
axis([-64 64 -100 5])
grid on
title('Equal Ripple Remez Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

axes('position',[0.58 0.45 0.3 0.4])
plot((-0.5:1/1024:0.5-1/1024)*128,20*log10(abs(fftshift(fft(h1,1024)))),'b','linewidth',2)
grid on
axis([0 10 -80 5])
title('Zoom to Transition BW')
xlabel('Frequency')
ylabel('Log Mag (dB)')

axes('position',[0.17 0.45 0.3 0.4])
plot((-0.5:1/1024:0.5-1/1024)*128,20*log10(abs(fftshift(fft(h1,1024)))),'b','linewidth',2)
axis([-2 2 -0.25 0.25])
title('Zoom to Passband')
grid on
xlabel('Frequency')
ylabel('Log Mag (dB)')

% now give the filter a 1/f rolloff in the stopband
% myfrf is a modified version of the remezfrf function to provide the 1/f rolloff
%   in myfrf, removed linse start with "%---"
%   and new lines end with "%+++ ..."
%   to make the changes visible

h2=remez(154,[0, 0.6, 3.4, 64]/64, {'myfrf',[1 1 0 0]}, [1 1]);
figure(2)
plot((-0.5:1/1024:0.5-1/1024)*128,20*log10(abs(fftshift(fft(h2,1024)))),'b','linewidth',2)
grid on
axis([-64 64 -100 5])
title('1/f Stopband Rolloff Remez Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')

axes('position',[0.58 0.45 0.3 0.4])
plot((-0.5:1/1024:0.5-1/1024)*128,20*log10(abs(fftshift(fft(h2,1024)))),'b','linewidth',2)
grid on
axis([0 10 -80 5])
title('Zoom to Transition BW')
xlabel('Frequency')
ylabel('Log Mag (dB)')

axes('position',[0.17 0.45 0.3 0.4])
plot((-0.5:1/1024:0.5-1/1024)*128,20*log10(abs(fftshift(fft(h2,1024)))),'b','linewidth',2)
grid on
axis([-2 2 -0.25 0.25])
title('Zoom to Passband')
xlabel('Frequency')
ylabel('Log Mag (dB)')

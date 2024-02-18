% Remez filter design example to demonstrate use of my_frf to obtain 1/f ripple stopband
% Designs a low pass FIR filter with the following characteristics, with
% eqiripple and 1/f stopband ripple 
% filter length is a multiple of 30 (for polyphase filter design)
% sample rate 4.5 MHz
% passband edge 50 kHz,  passband ripple 0.10 dB
% stopband edge 100 kHz, stopband levels 60.0 dB
% penalty weights adjusted to obtain ratio of inband to stop band levels
% Script file written by fred harris of UCSD, Copyright 2021.

h1=remez(280-1,[0, 1, 2, 50]/50, [1 1 0 0], [1 10]);

figure(1)
plot((-0.5:1/4096:0.5-1/4096),20*log10(abs(fftshift(fft(h1,4096)))),'b','linewidth',1.0)
grid on
axis([-0.5 0.5 -100 5])
title('Equal Ripple Stopband Levels Remez Filter Design Example')
xlabel('Frequency')
ylabel('Log Mag (dB)')

% now give the filter a 1/f rolloff in the stopband
% myfrf is a modified version of the remezfrf function to provide the 1/f rolloff
%   in myfrf, removed lines start with "%---"
%   and new lines end with "%+++ ..."
%   to make the changes visible
% the weights are adjusted to optimize the inband vs. stopband performance

h2=remez(280-1,[0, 1, 2, 50]/50, {'myfrf', [1 1 0 0]}, [1 10]);
figure(2)
plot((-0.5:1/4096:0.5-1/4096),20*log10(abs(fftshift(fft(h2,4096)))),'b','linewidth',1.0)
grid on
axis([-0.5 0.5 -100 5])
title('1/f Stopband Rolloff Remez Filter Design Example')
xlabel('Frequency')
ylabel('Log Mag (dB)')

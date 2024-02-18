function eight_to_one
% various filters that reduce bandwidth eight-to-one for use as 8-to-1 downsampler,
% bandwidth +/- 20 kHz, transition bandwidth 5 kHz... sample rate 320 kHz, 
% filter and downsample 8-to-1. 
% Compares following options, 7-th order IIR eliptic filter, 105 tap FIR filter,
% 9-coefficient two-path allpass filter, 8-path polyphase linear phase recursive all pass,
% 8-path polyphase non-uniform phase recursive all pass, 3-elliptic half band filters, 
% 3-half band FIR filters, 3-exact half band FIR filters, and 3 non uniform phase recursive all-pass
% half band filters.
%  Script file written by fred harris of UCSD. Copyright 2021

figure(1)
% elliptic filter... 3-second order sections, 1-first order section....18 ops/input, 18 ops/output
[bb,aa]=ellip(7,0.1,72,30/320);
hh1=filter(bb,aa,[1 zeros(1,599)]);
subplot(2,1,1)
plot(hh1,'b','linewidth',1.0)
grid on
axis([0 105 -0.06 0.15])
title('7-th Order Elliptic Filter: 14 Ops/Output')
xlabel('Time Index')
ylabel('Amplitude')
subplot(2,1,2)
plot((-0.5:1/1024:.5-1/1024)*640,fftshift(20*log10(abs(fft(hh1,1024)))),'b','linewidth',1.0)
grid on
axis([0 320 -90 10])
title('Filter Frequency Response')
xlabel('Frequency')
ylabel('Log mag (dB)')

pause
figure(2)
% 105 tap fir filter
hh2=remez(104,[0 30 50 320]/320,[1 1 0 0],[1 20]);
subplot(2,1,1)
plot(hh2,'b','linewidth',1.0)
grid
axis([0 105 -0.06 0.15])
title('105 Tap FIR Filter: 105 Ops/Output')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot((-0.5:1/1024:.5-1/1024)*640,fftshift(20*log10(abs(fft(hh2,1024)))),'b','linewidth',1.0)
grid
axis([0 320 -90 10])
title('Filter Frequency Response')
xlabel('Frequency')
ylabel('Log mag (dB)')
pause

hh2b=remez(103,[0 30 50 320]/320,[1 1 0 0],[1 20]);
hh2a=zeros(8,104);
for nn=1:8
hh2a(nn,nn:8:104)=hh2b(nn:8:104);
end
figure(12)
%subplot(1,2,1)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(1,:),1024))))/(2*pi),'linewidth',1.0)
hold on
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(2,:),1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(3,:),1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(4,:),1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(5,:),1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(6,:),1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(7,:),1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(hh2a(8,:),1024))))/(2*pi),'linewidth',1.0)
hold off
grid on
axis([0 320 -30 0])
title('Phase profiles of Each Path of 8-Path Polyphase Filter')
ylabel('phase,\phi/(2\pi)')
xlabel('Frequency')
pause

figure(3)
% two-path all-pass filter...9 ops/input,,, 9 ops/output
den0=[1.0  -1.53115199990282   0.60012586349753];
den2=[1.0  -1.75642953294118   0.83555148231426];


den1=[1.0  -1.64004940135398   0.71392877042037];
den3=[1.0  -1.86211430940456   0.94599704500675];
den5=[1.0  -0.74152881307117];


h_a=filter(fliplr(den0),den0,[1 zeros(1,399)]);
h_a=filter(fliplr(den2),den2,h_a);

h_b=filter(fliplr(den1),den1,[1 zeros(1,399)]);
h_b=filter(fliplr(den3),den3,h_b);
h_b=filter(fliplr(den5),den5,h_b);

hh3=(h_a+h_b)/2;
subplot(2,1,1)
plot(hh3,'linewidth',1.0)
grid
axis([0 105 -0.06 0.15])
title('Two-Path Recursive All-Pass Filter: 9-Ops/Output')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot((-0.5:1/1024:.5-1/1024)*640,fftshift(20*log10(abs(fft(hh3,1024)))),'linewidth',1.0)
grid
axis([0 320 -90 10])
title('Filter Frequency Response')
xlabel('Frequency')
ylabel('Log mag (dB)')
pause

figure(11)
subplot(2,1,1)
plot((-0.5:1/1024:.5-1/1024)*640,fftshift(unwrap(angle(fft(h_a,1024))))/(2*pi),'linewidth',1.0)
hold on
plot((-0.5:1/1024:.5-1/1024)*640,fftshift(unwrap(angle(fft(h_b,1024))))/(2*pi),'linewidth',1.0)
hold off
grid
axis([0 320 -3 0])
title('Phase Response of Two Paths of Two-Path Filter')
ylabel('Phase Shift, \phi(f)/(2\pi)')
xlabel('Frequency')

subplot(2,1,2)
plot((-0.5:1/1024:.5-1/1024)*640,fftshift(20*log10(abs(fft(hh3,1024)))),'linewidth',1.0)
grid
axis([0 320 -90 10])
title('Frequency Response of Two-Path Recursive All-Pass Filter')
ylabel('Log Mag (dB)')
xlabel('Frequency')
pause

figure(4)
c0=[1 zeros(1,48)];
zz=zeros(1,7);
c11=[1  zz   0.50437530496548];
c12=[1  zz  -0.30546406645116];                    
c13=[1  zz   0.2665085422733524  zz  0.1191845246313624];
c14=[1  zz  -0.3457812066425924  zz  0.09760331184267365];

c21=[1  zz   0.61168203148542];                    
c22=[1  zz  -0.31073253075951];
c23=[1  zz   0.287962781085209  zz  0.1286069207639229];
c24=[1  zz  -0.3483712322448727 zz  0.1018477257905622];

c31=[1  zz   0.69292893252905];                    
c32=[1  zz  -0.30026539303100];
c33=[1  zz   0.3019511523748685  zz  0.1254910518429397];
c34=[1  zz  -0.3317868763520993  zz  0.09599199956470592];

c41=[1  zz   0.76264667953103];                    
c42=[1  zz  -0.28216859153692];
c43=[1  zz   0.3119710824492065  zz  0.1160312296951684];
c44=[1  zz  -0.3058196561077875  zz  0.08561045022551989];

c51=[1  zz   0.82607806904412];                    
c52=[1  zz  -0.25873176059135];
c53=[1  zz   0.3180610375993243  zz  0.1022200919783818];
c54=[1  zz  -0.2733196094601293  zz  0.07271299267577124];

c61=[1  zz   0.88583427159768];                    
c62=[1  zz  -0.22994074727290];
c63=[1  zz   0.3179527520253246  zz  0.08438573638786708];
c64=[1  zz  -0.2344904281912926  zz  0.05800663612084555];

c71=[1  zz   0.94346397308802];                    
c72=[1  zz  -0.19223671084777];
c73=[1  zz   0.3030892245559409  zz  0.06075833237300266];
c74=[1  zz  -0.1857165341436279  zz  0.0408878554256654];

g0=filter(fliplr(c0),c0,[1 zeros(1,999)]);

g1=filter(fliplr(c11),c11,[1 zeros(1,999)]);
g1=filter(fliplr(c12),c12,g1);
g1=filter(fliplr(c13),c13,g1);
g1=filter(fliplr(c14),c14,g1);
g1=filter([0 1],[1 0],g1);

g2=filter(fliplr(c21),c21,[1 zeros(1,999)]);
g2=filter(fliplr(c22),c22,g2);
g2=filter(fliplr(c23),c23,g2);
g2=filter(fliplr(c24),c24,g2);
g2=filter([0 0 1],[1 0 0],g2);

g3=filter(fliplr(c31),c31,[1 zeros(1,999)]);
g3=filter(fliplr(c32),c32,g3);
g3=filter(fliplr(c33),c33,g3);
g3=filter(fliplr(c34),c34,g3);
g3=filter([0 0 0 1],[1 0 0 0],g3);

g4=filter(fliplr(c41),c41,[1 zeros(1,999)]);
g4=filter(fliplr(c42),c42,g4);
g4=filter(fliplr(c43),c43,g4);
g4=filter(fliplr(c44),c44,g4);
g4=filter([0 0 0 0 1],[1 0 0 0 0],g4);

g5=filter(fliplr(c51),c51,[1 zeros(1,999)]);
g5=filter(fliplr(c52),c52,g5);
g5=filter(fliplr(c53),c53,g5);
g5=filter(fliplr(c54),c54,g5);
g5=filter([0 0 0 0 0 1],[1 0 0 0 0 0],g5);

g6=filter(fliplr(c61),c61,[1 zeros(1,999)]);
g6=filter(fliplr(c62),c62,g6);
g6=filter(fliplr(c63),c63,g6);
g6=filter(fliplr(c64),c64,g6);
g6=filter([0 0 0 0 0 0 1],[1 0 0 0 0 0 0],g6);

g7=filter(fliplr(c71),c71,[1 zeros(1,999)]);
g7=filter(fliplr(c72),c72,g7);
g7=filter(fliplr(c73),c73,g7);
g7=filter(fliplr(c74),c74,g7);
g7=filter([0 0 0 0 0 0 0 1],[1 0 0 0 0 0 0 0],g7);

hh4=(g0+g1+g2+g3+g4+g5+g6+g7)/8;

figure(4)
subplot(2,1,1)
plot(hh4,'linewidth',1.0)
grid
axis([0 105 -0.06 0.15])
title('8-Path Polyphase Recursive Linear-Phase All-Pass: 5.25-Ops/Input')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot((-0.5:1/1024:.5-1/1024)*640,fftshift(20*log10(abs(fft(hh4,1024)))),'linewidth',1.0)
grid
axis([0 320 -90 10])
title('Filter Frequency Response')
xlabel('Frequency')
ylabel('Log mag (dB)')
pause

figure(13)
subplot(2,1,1)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g0,1024))))/(2*pi),'linewidth',1.0)
hold on
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g1,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g2,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g3,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g4,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g5,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g6,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g7,1024))))/(2*pi),'linewidth',1.0)
hold off
grid
axis([0 320 -30 0])
title('Phase profiles of Each Path of 8-Path Linear Phase, All-Pass, Polyphase Filter')
ylabel('phase,\phi(f)/(2\pi)')
xlabel('Frequency')

 subplot(2,1,2)
 plot((-0.5:1/2048:.5-1/2048)*640,fftshift(20*log10(abs(fft(hh4,2048)))))
 grid
 axis([0 320 -90 10])
 ylabel('Log Mag (dB)')
pause

zz=zeros(1,7);
c01=[1  zz   0.005760];
c02=[1  zz   0.280535];
c03=[1  zz   0.807477];

c11=[1  zz   0.017672];
c12=[1  zz   0.339676];                    
c13=[1  zz   0.862465];

c21=[1  zz   0.035404];                    
c22=[1  zz   0.400097];
c23=[1  zz   0.911199];

c31=[1  zz   0.058760];                    
c32=[1  zz   0.462671];
c33=[1  zz   0.952296];

c41=[1  zz   0.087895];                    
c42=[1  zz   0.528833];
c43=[1  zz   0.983155];

c51=[1  zz   0.123507];                    
c52=[1  zz   0.600505];

c61=[1  zz   0.678523];    
c62=[1  zz   0.167207];

c71=[1  zz   0.222508];    
c72=[1  zz   0.746494];


g0=filter(fliplr(c01),c01,[1 zeros(1,1999)]);
g0=filter(fliplr(c02),c02,g0);
g0=filter(fliplr(c03),c03,g0);

g1=filter(fliplr(c11),c11,[1 zeros(1,1999)]);
g1=filter(fliplr(c12),c12,g1);
g1=filter(fliplr(c13),c13,g1);
g1=filter([0 1],[1 0],g1);

g2=filter(fliplr(c21),c21,[1 zeros(1,1999)]);
g2=filter(fliplr(c22),c22,g2);
g2=filter(fliplr(c23),c23,g2);
g2=filter([0 0 1],[1 0 0],g2);

g3=filter(fliplr(c31),c31,[1 zeros(1,1999)]);
g3=filter(fliplr(c32),c32,g3);
g3=filter(fliplr(c33),c33,g3);
g3=filter([0 0 0 1],[1 0 0 0],g3);

g4=filter(fliplr(c41),c41,[1 zeros(1,1999)]);
g4=filter(fliplr(c42),c42,g4);
g4=filter(fliplr(c43),c43,g4);
g4=filter([0 0 0 0 1],[1 0 0 0 0],g4);

g5=filter(fliplr(c51),c51,[1 zeros(1,1999)]);
g5=filter(fliplr(c52),c52,g5);
g5=filter([0 0 0 0 0 1],[1 0 0 0 0 0],g5);

g6=filter(fliplr(c61),c61,[1 zeros(1,1999)]);
g6=filter(fliplr(c62),c62,g6);
g6=filter([0 0 0 0 0 0 1],[1 0 0 0 0 0 0],g6);

g7=filter(fliplr(c71),c71,[1 zeros(1,1999)]);
g7=filter(fliplr(c72),c72,g7);
g7=filter([0 0 0 0 0 0 0 1],[1 0 0 0 0 0 0 0],g7);

hh4=(g0+g1+g2+g3+g4+g5+g6+g7)/8;

figure(5)
subplot(2,1,1)
plot(hh4,'b','linewidth',1.0)
grid
axis([0 105 -0.06 0.15])
title('8-Path Polyphase Recursive Non-Linear-Phase All-Pass: 2.625-Ops/Input')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot((-0.5:1/2048:.5-1/2048)*640,fftshift(20*log10(abs(fft(hh4,2048)))),'b','linewidth',1.0)
grid
axis([0 320 -90 10])
title('Filter Frequency Response')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(14)
subplot(2,1,1)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g0,1024))))/(2*pi),'linewidth',1.0)
hold on
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g1,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g2,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g3,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g4,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g5,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g6,1024))))/(2*pi),'linewidth',1.0)
plot((-0.5:1/1024:0.5-1/1024)*640,fftshift(unwrap(angle(fft(g7,1024))))/(2*pi),'linewidth',1.0)
hold off
grid
axis([0 320 -15 0])
title('Phase profiles of Each Path of 8-Path Linear Phase, All-Pass, Polyphase Filter')
ylabel('phase,\phi(f)/(2\pi)')
xlabel('Frequency')

 subplot(2,1,2)
 plot((-0.5:1/2048:.5-1/2048)*640,fftshift(20*log10(abs(fft(hh4,2048)))),'b','linewidth',1.0)
 grid
 axis([0 320 -90 10])
 title('Filter Frequency Response')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

%%% half band filters

figure(6)
[b6_1,a6_1]=ellip(3,0.03,72,30/320);
[b6_2,a6_2]=ellip(3,0.03,40,30/160);
[b6_3,a6_3]=ellip(5,0.03,60,30/80);

h6_3=filter(b6_3,a6_3,[1 zeros(1,199)]);

h6_2=filter(b6_2,a6_2,[1 zeros(1,99)]);

h6_1=filter(b6_1,a6_1,[1 zeros(1,99)]);

subplot(3,1,1)
h6_3a=reshape([h6_3;zeros(3,200)],1,800);
h6_2a=reshape([h6_2;zeros(1,100)],1,200);

plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h6_3a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h6_2a,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Three Half-Band Elliptic Filters: 3, 3, and 5 Poles, 11.25 Ops/Output')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,2)
hh6_a=conv(h6_3a,h6_2a);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh6_a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h6_1,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Frequency Responses Cascade of First Two Filters (Blue) and Third Filter (Red)')
xlabel('Frequency')
ylabel('Log Mag (dB)')
subplot(3,1,3)
hh6_b=conv(hh6_a,h6_1);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh6_b,2048)))),'b','linewidth',1.0)
grid
axis([0 320 -90 10])
title('Frequency Responses Cascade of al Three Filters')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

%% halband fir filters
figure(7)
h7_1=remez(7,[0 20 270 320]/320,[1 1 0 0]);
h7_2=remez(11,[0 20 120 160]/160,[1 1 0 0]);
h7_3=remez(17,[0 20 50 80]/80,[1 1 0 0],[1 20]);

subplot(3,1,1)
h7_3a=reshape([h7_3;zeros(3,18)],1,72);
h7_2a=reshape([h7_2;zeros(1,12)],1,24);

plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h7_3a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h7_2a,2048)))),'r','linewidth',1.0)
hold off
grid
axis([0 320 -90 10])
title('Three Half-Band FIR Filters: 8, 12, and 18 Taps, 9.25 Ops/Output')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,2)
hh7_a=conv(h7_3a,h7_2a);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh7_a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h7_1,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Frequency Responses Cascade of First Two Filters (Blue) and Third Filter (Red)')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,3)
hh7_b=conv(hh7_a,h7_1);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh7_b,2048)))),'b','linewidth',1.0)
grid
axis([0 320 -90 10])
title('Frequency Responses Cascade of all Three Filters')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause


figure(15)
h15_1=sinc(-3.5:0.5:3.5).*kaiser(15,7)';
h15_1=h15_1/sum(h15_1);
h15_2=sinc(-5.0:0.5:5.0).*kaiser(21,7)';
h15_2=h15_2/sum(h15_2);
h15_3=sinc(-8.0:0.5:8.0).*kaiser(33,7)';
h15_3=h15_3/sum(h15_3);

subplot(3,1,1)
h15_3a=reshape([h15_3;zeros(3,33)],1,132);
h15_2a=reshape([h15_2;zeros(1,21)],1,42);

plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h15_3a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h15_2a,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Three exact Half-Band FIR Filters: 15, 21, and 33 Taps, 8.0 Ops/Output')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,2)
hh15_a=conv(h15_3a,h15_2a);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh15_a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h15_1,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Frequency Responses Cascade of First Two Filters (Blue) and Third Filter (Red)')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,3)
hh15_b=conv(hh15_a,h15_1);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh15_b,2048)))),'b','linewidth',1.0)
grid on
axis([0 320 -90 10])
title('Frequency Responses Cascade of of all Three Filters')
xlabel('Frequency')
ylabel('Log Mag (dB)')

pause
%% halband iir non-lin-phase all=pass filters

figure(8)
den8_a0=[1.0  0   0.12474452570860];
den8_a1=[1.0  0   0.56258495288732];

zz2=zeros(1,3);
den8_b0=[1.0  zz2   0.08430115336419];
den8_b2=[1.0  zz2   0.71577118993380];
den8_b1=[1.0  zz2   0.32325000579862];

zz3=zeros(1,7);
den8_c0=[1.0  zz3   0.07076594897146];
den8_c2=[1.0  zz3   0.51316757476596];
den8_c1=[1.0  zz3   0.25785307851694];
den8_c3=[1.0  zz3   0.81731735437140];

v0_3=filter(fliplr(den8_c0),den8_c0,[1 zeros(1,399)]);
v0_3=filter(fliplr(den8_c2),den8_c2,v0_3);

v1_3=filter(fliplr(den8_c1),den8_c1,[1 zeros(1,399)]);
v1_3=filter(fliplr(den8_c3),den8_c3,v1_3);
v1_3=filter([0 0 0 0 1],[1 0 0 0 0],v1_3);

h8_3=(v0_3+v1_3)/2;

v0_2=filter(fliplr(den8_b0),den8_b0,[1 zeros(1,399)]);
v0_2=filter(fliplr(den8_b2),den8_b2,v0_2);

v1_2=filter(fliplr(den8_b1),den8_b1,[1 zeros(1,399)]);
v1_2=filter([0 0 1],[1 0 0],v1_2);

h8_2=(v0_2+v1_2)/2;

v0_1=filter(fliplr(den8_a0),den8_a0,[1 zeros(1,199)]);
v1_1=filter(fliplr(den8_a1),den8_a1,[1 zeros(1,199)]);
v1_1=filter([0 1],[1 0],v1_1);
h8_1=(v0_1+v1_1)/2;

subplot(3,1,1)

plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h8_3,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h8_2,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Three Half-Band Recursive Non-Linear Phase All-Pass Filters: 2, 3, and 4 Stages, 2.25 Ops/Output')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,2)
hh8_a=conv(h8_3,h8_2);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh8_a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h8_1,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Frequency Responses Cascade of First Two Filters (Blue) and Third Filter (Red)')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,3)
hh8_b=conv(hh8_a,h8_1);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh8_b,2048)))),'b','linewidth',1.0)
grid
axis([0 320 -90 10])
title('Frequency Responses Cascade of All Three Filters')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

%% halband iir linear-phase all-pass filters

figure(9)
den9_a1=[1.0  0    0.48649585138139];
den9_a3=[1.0  0   -0.07255468823987];

zz2=zeros(1,3);
den9_b1=[1.0  zz2    0.59000651271115];
den9_b3=[1.0  zz2   -0.1390025452008204  zz2  0.01684672388632527];

zz3=zeros(1,7);
den9_c1=[1.0  zz3   0.78536979809556];
den9_c3=[1.0  zz3   0.448187809358143  zz3  0.1472646818324347];
den9_c5=[1.0  zz3  -0.1672840192910547  zz3  0.1112009200728008];
den9_c7=[1.0  zz3  -0.5770888098937477  zz3  0.1017451331944334];

dly_3=[1 zeros(1,56)];
v0_3=filter(fliplr(dly_3),dly_3,[1 zeros(1,399)]);

v1_3=filter(fliplr(den9_c1),den9_c1,[1 zeros(1,399)]);
v1_3=filter(fliplr(den9_c3),den9_c3,v1_3);
v1_3=filter(fliplr(den9_c5),den9_c5,v1_3);
v1_3=filter(fliplr(den9_c7),den9_c7,v1_3);
v1_3=filter([0 0 0 0 1],[1 0 0 0 0],v1_3);

h9_3=(v0_3+v1_3)/2;

dly_2=[1 zeros(1,12)];
v0_2=filter(fliplr(dly_2),dly_2,[1 zeros(1,399)]);

v1_2=filter(fliplr(den9_b1),den9_b1,[1 zeros(1,399)]);
v1_2=filter(fliplr(den9_b3),den9_b3,v1_2);
v1_2=filter([0 0 1],[1 0 0],v1_2);

h9_2=(v0_2+v1_2)/2;

dly_1=[1 zeros(1,4)];
v0_1=filter(fliplr(dly_1),dly_1,[1 zeros(1,399)]);

v1_1=filter(fliplr(den9_a1),den9_a1,[1 zeros(1,399)]);
v1_1=filter(fliplr(den9_a3),den9_a3,v1_1);
v1_1=filter([0 1],[1 0],v1_1);

h9_1=(v0_1+v1_1)/2;

subplot(3,1,1)

plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h9_3,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h9_2,2048)))),'r','linewidth',1.0)
hold off
grid
axis([0 320 -90 10])
title('Three Half-Band Recursive Linear Phase All-Pass Filters: 2, 3, and 7 Coef, 2.5 Ops/Output')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,2)
hh9_a=conv(h9_3,h9_2);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh9_a,2048)))),'b','linewidth',1.0)
hold on 
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(h9_1,2048)))),'r','linewidth',1.0)
hold off
grid on
axis([0 320 -90 10])
title('Frequency Responses Cascade of First Two Filters (Blue) and Third Filter (Red)')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(3,1,3)
hh9_b=conv(hh9_a,h9_1);
plot((-0.5:1/2048:0.5-1/2048)*640, fftshift(20*log10(abs(fft(hh9_b,2048)))),'b','linewidth',1.0)
grid
axis([0 320 -90 10])
title('Frequency Responses Cascade of All Three Filters')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause

figure(10)
subplot(2,2,1)
plot(hh6_b,'b','linewidth',1.0)
grid
title('Cascade Half-Band Elliptic Filters')
xlabel('Time Index')
ylabel('Amplitude')
axis([0 150 -0.06 0.15])

subplot(2,2,2)
plot(hh7_b,'b','linewidth',1.0)
grid
title('Cascade Half-Band FIR Filters')
xlabel('Time Index')
ylabel('Amplitude')
axis([0 150 -0.06 0.15])

subplot(2,2,3)
plot(hh8_b,'b','linewidth',1.0)
grid
title('Cascade Half-Band Recursive IIR Filters')
xlabel('Time Index')
ylabel('Amplitude')
axis([0 150 -0.06 0.15])

subplot(2,2,4)
plot(hh9_b,'b','linewidth',1.0)
grid
title('Cascade Half-Band Lin-Phase Recursive IIR Filters')
xlabel('Time Index')
ylabel('Amplitude')
axis([0 150 -0.06 0.15])

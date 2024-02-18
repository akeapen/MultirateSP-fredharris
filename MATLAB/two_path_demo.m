% two path filter demo
% demonstration of two path recursive all-pass filter
% showing two-path phase responses along with resulting filter gain obtained from their sum
% for half, band, for transformed low pass, and for transformed band pass
% Script file written by fred harris of UCSD. Copyright 2021

% half band, 7-pole, 7-zero, 3-multiply Linear Phase recursive all-pass filter
% coefficients obtained from lineardesign_2, Top path is delay line

den_01 = [1 zeros(1,6)];
den_10 = [1. 0.0   -0.1563163557101381  0.0   0.02291418235416641];
den_11 = [1. 0.0   0.6158352756195699];

n_dat=400;
xx=[1 zeros(1,n_dat-1)];
reg1_tp=zeros(1,6);
reg1_bt=zeros(3,4);


for nn=1:n_dat
sm0=reg1_tp(6);

sm1=(xx(nn)-reg1_bt(2,4))*den_10(5)+(reg1_bt(1,2)-reg1_bt(2,2))*den_10(3)+reg1_bt(1,4);
sm2=(sm1   -reg1_bt(3,2))*den_11(3)+ reg1_bt(2,2);

tp(nn)=sm0;
bt(nn)=reg1_bt(3,1);
yy(nn)=(sm0+reg1_bt(3,1))/2;

reg1_tp(1,:)=[xx(nn) reg1_tp(1:5)];
reg1_bt(1,:)=[xx(nn) reg1_bt(1,1:3)];
reg1_bt(2,:)=[sm1    reg1_bt(2,1:3)];
reg1_bt(3,:)=[sm2    reg1_bt(3,1:3)];

end

figure(1)
subplot(2,1,1)
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(tp,800))))/(2*pi),'b','linewidth',1)
hold on
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(bt,800)))/(2*pi)),'r','linewidth',1)
hold off
grid on
axis([0 0.5 -3.5 0])
title('Phase: Each Path of Two-path, Linear Phase, IIR Filter')
ylabel('Normalized Phase: \theta/(2\pi)') 

subplot(2,1,2)
plot(-0.5:1/800:0.5-1/800,fftshift(20*log10(abs(fft(yy,800)))),'b','linewidth',1)
grid on
axis([0 0.5 -90 10])
title('Spectrum: Two-path IIR Filter')
ylabel('Log Mag (dB)')
xlabel('Normalized Frequency: f/f_s')


% half band, 5-pole, 5-zero, 2-multiply recursive all-pass filter
% coefficients obtained from tony_des2, Non-Uniform Phase Design, 
% Both paths are recursive all-pass filters 

den_01 = [1.  0    0.14134868113614];   
den_11 = [1.  0.   0.58999487227406];
  			
n_dat=400;
xx=[1 zeros(1,n_dat-1)];
reg1_tp=zeros(2,2);
reg1_bt=zeros(2,2);


for nn=1:n_dat
sm0=(xx(nn)-reg1_tp(2,2))*den_01(3)+reg1_tp(1,2);
sm1=(xx(nn)-reg1_bt(2,2))*den_11(3)+ reg1_bt(1,2);
tp(nn)=sm0;
bt(nn)=reg1_bt(2,1);
yy(nn)=(sm0+reg1_bt(2,1))/2;

reg1_tp(1,:)=[xx(nn) reg1_tp(1,1)];
reg1_tp(2,:)=[sm0    reg1_tp(2,1)];
reg1_bt(1,:)=[xx(nn) reg1_bt(1,1)];
reg1_bt(2,:)=[sm1    reg1_bt(2,1)];
end

figure(2)
subplot(2,1,1)
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(tp,800))))/(2*pi),'b','linewidth',1)
hold on
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(bt,800)))/(2*pi)),'r','linewidth',1)
hold off
grid on
axis([0 0.5 -1.5 0])
title('Phase: Each Path of Two-path IIR Filter')
ylabel('Normalized Phase: \theta/(2\pi)') 
xlabel('Frequency')

subplot(2,1,2)
plot(-0.5:1/800:0.5-1/800,fftshift(20*log10(abs(fft(yy,800)))),'b','linewidth',1)
grid on
axis([0 0.5 -90 10])
title('Spectrum: Two-path IIR Filter')
ylabel('Log Mag (dB)')
xlabel('Normalized Frequency: f/f_s')


% low pass, 5-pole, 5-zero, 5-multiply recursive all-pass filter

den_01 = [1.  -1.12192189900213   0.38677173261228];
den_11 = [1.  -1.40506828026801   0.73675990743999];
den_12 = [1.  -0.50952544949443];


n_dat=400;
xx=[1 zeros(1,n_dat-1)];
reg1_tp=zeros(2,2);
reg1_bt=zeros(3,2);


for nn=1:n_dat
sm0=(xx(nn)-reg1_tp(2,2))*den_01(3)+(reg1_tp(1,1)-reg1_tp(2,1))*den_01(2)+reg1_tp(1,2);
sm1=(xx(nn)-reg1_bt(2,1))*den_12(2)+ reg1_bt(1,1);
sm3=(sm1   -reg1_bt(3,2))*den_11(3)+(reg1_bt(2,1)-reg1_bt(3,1))*den_11(2)+reg1_bt(2,2);
tp(nn)=sm0;
bt(nn)=sm3;
yy(nn)=(sm0+sm3)/2;

reg1_tp(1,:)=[xx(nn) reg1_tp(1,1)];
reg1_tp(2,:)=[sm0    reg1_tp(2,1)];
reg1_bt(1,:)=[xx(nn) reg1_bt(1,1)];
reg1_bt(2,:)=[sm1    reg1_bt(2,1)];
reg1_bt(3,:)=[sm3    reg1_bt(3,1)];
end

figure(3)
subplot(2,1,1)
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(tp,800))))/(2*pi),'b','linewidth',1)
hold on
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(bt,800)))/(2*pi)),'r','linewidth',1)
hold off
grid on
axis([0 0.5 -1.5 0])
title('Phase: Each Path of Two-path IIR Filter')
ylabel('Normalized Phase: \theta/(2\pi)') 
xlabel('Frequency')

subplot(2,1,2)
plot(-0.5:1/800:0.5-1/800,fftshift(20*log10(abs(fft(yy,800)))),'b','linewidth',1)
grid on
axis([0 0.5 -90 10])
title('Spectrum: Two-path IIR Filter')
ylabel('Log Mag (dB)')
xlabel('Normalized Frequency: f/f_s')


% low pass, 5-pole, 5-zero, 5-multiply recursive all-pass filter

den_01 = [1.  -1.81325768625117   0.82766940541123];
den_11 = [1.  -1.92210850681668   0.93738536912116];
den_12 = [1.  -0.88161859236319];

n_dat=400;
xx=[1 zeros(1,n_dat-1)];
reg1_tp=zeros(2,2);
reg1_bt=zeros(3,2);

for nn=1:n_dat
sm0=(xx(nn)-reg1_tp(2,2))*den_01(3)+(reg1_tp(1,1)-reg1_tp(2,1))*den_01(2)+reg1_tp(1,2);
sm1=(xx(nn)-reg1_bt(2,1))*den_12(2)+ reg1_bt(1,1);
sm3=(sm1   -reg1_bt(3,2))*den_11(3)+(reg1_bt(2,1)-reg1_bt(3,1))*den_11(2)+reg1_bt(2,2);
tp(nn)=sm0;
bt(nn)=sm3;
yy(nn)=(sm0+sm3)/2;

reg1_tp(1,:)=[xx(nn) reg1_tp(1,1)];
reg1_tp(2,:)=[sm0    reg1_tp(2,1)];
reg1_bt(1,:)=[xx(nn) reg1_bt(1,1)];
reg1_bt(2,:)=[sm1    reg1_bt(2,1)];
reg1_bt(3,:)=[sm3    reg1_bt(3,1)];
end

figure(4)
subplot(2,1,1)
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(tp,800))))/(2*pi),'b','linewidth',1)
hold on
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(bt,800)))/(2*pi)),'r','linewidth',1)
hold off
grid on
axis([0 0.5 -1.5 0])
title('Phase: Each Path of Two-path IIR Filter')
ylabel('Normalized Phase: \theta/(2\pi)') 
xlabel('Frequency')

subplot(2,1,2)
plot(-0.5:1/800:0.5-1/800,fftshift(20*log10(abs(fft(yy,800)))),'b','linewidth',1)
grid
axis([0 0.5 -90 10])
title('Spectrum: Two-Path IIR Filter')
ylabel('Log Mag (dB)')
xlabel('Normalized Frequency: f/f_s')



% pass band, 10-pole, 10-zero, 10-multiply recursive all-pass filter

den_01 = [1.  -0.58498982946898   1.21000654032299  -0.35517479170051    0.38677173261228];
den_11 = [1.  -0.63804617061077   1.51538338830611  -0.53939362141965    0.73675990743999];
den_12 = [1.  -0.28285686312687   0.50952544949443];

n_dat=400;
xx=[1 zeros(1,n_dat-1)];
reg1_tp=zeros(2,4);
reg1_bt=zeros(3,4);


for nn=1:n_dat
sm0=(xx(nn)-reg1_tp(2,4))*den_01(5)+(reg1_tp(1,1)-reg1_tp(2,3))*den_01(4)+(reg1_tp(1,2)-reg1_tp(2,2))*den_01(3)+(reg1_tp(1,3)-reg1_tp(2,1))*den_01(2)+reg1_tp(1,4);
sm1=(xx(nn)-reg1_bt(2,2))*den_12(3)+(reg1_bt(1,1)-reg1_bt(2,1))*den_12(2)+ reg1_bt(1,2);
sm3=(sm1   -reg1_bt(3,4))*den_11(5)+(reg1_bt(2,1)-reg1_bt(3,3))*den_11(4)+(reg1_bt(2,2)-reg1_bt(3,2))*den_11(3)+(reg1_bt(2,3)-reg1_bt(3,1))*den_11(2)+reg1_bt(2,4);
tp(nn)=sm0;
bt(nn)=sm3;
yy(nn)=(-sm0+sm3)/2;

reg1_tp(1,:)=[xx(nn) reg1_tp(1,1:3)];
reg1_tp(2,:)=[sm0    reg1_tp(2,1:3)];
reg1_bt(1,:)=[xx(nn) reg1_bt(1,1:3)];
reg1_bt(2,:)=[sm1    reg1_bt(2,1:3)];
reg1_bt(3,:)=[sm3    reg1_bt(3,1:3)];
end

figure(5)
subplot(2,1,1)
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(tp,800))))/(2*pi)-0.5,'b','linewidth',1)
hold on
plot(-0.5:1/800:0.5-1/800,fftshift(unwrap(angle(fft(bt,800)))/(2*pi)),'r','linewidth',1)
hold off
grid
axis([0 0.5 -3.0 0])
title('Phase: Each Path of Two-path IIR Filter')
ylabel('Normalized Phase: \theta/(2\pi)') 
xlabel('Frequency')

subplot(2,1,2)
plot(-0.5:1/800:0.5-1/800,fftshift(20*log10(abs(fft(yy,800)))),'b','linewidth',1)
grid
axis([0 0.5 -90 10])
title('Spectrum: Two-Path IIR Filter')
ylabel('Log Mag (dB)')
xlabel('Normalized Frequency: f/f_s')





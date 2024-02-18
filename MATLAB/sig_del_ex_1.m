%example of resampling filters following a sigma-delta modulator, 
% 5-to-1, 3-stage CIC and 3-path polyphase FIR Filter
% Script file written by fred harris of UCSD. Copyright 2021

% Three stage sigma delta converter, Multi-level Quantizer
reg1=0;
reg2=0;
reg3=0;
n_dat=6000;
xx=cos(2*pi*0.0109*0.8*(1:n_dat+200)+rand(1)*2*pi);
xx=xx+cos(2*pi*0.0109*0.8*(2/3)*(1:n_dat+200)+rand(1)*2*pi);
xx=xx+cos(2*pi*0.0109*0.8*(1/3)*(1:n_dat+200)+rand(1)*2*pi);
xx=xx*0.8/3;

b1=0.03;
a3=1;
a2=1;
a1=1;

for nn=1:length(xx)

   if abs(reg3)<0.25;
       qq=0;
   elseif abs(reg3)<0.75 & abs(reg3)>=0.25
       qq=0.5*sign(reg3);
   else
       qq=sign(reg3);
   end
   
%   qq=reg3+0.5*rand(1); % Injected noise model if enabled, remove percent sign
 
   yy(nn)=qq;
   
   sm3=0.25*reg2+reg3       -qq*a3;
   sm2=0.25*reg1+reg2-sm3*b1-qq*a2;
   sm1=xx(nn)+reg1          -qq*a1;
   
   reg1=sm1;
   reg2=sm2;
   reg3=sm3;
   tst(nn,:)=[sm1 sm2 sm3];
end

figure(1)
subplot(2,1,1)
plot(xx(1:400),'r','linewidth',2)
hold on
plot(yy(1:400),'b','linewidth',1.5)
hold off
grid
axis([0 400 -1.2 1.2])
title('Time Series: Input and Output of \Sigma-\Delta Modulator')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(n_dat,14)';
ww=ww/sum(ww);
plot((-0.5:1/n_dat:0.5-1/n_dat)*57.6,fftshift(20*log10(abs(fft(yy(101:n_dat+100).*ww)))),'b','linewidth',1.5)
hold on
plot([-0.625 -0.625 0.625 0.625],[-110 0 0 -110],':r','linewidth',2)
hold off
grid
axis([-5 5 -110 10])
title('Spectrum: Output of \Sigma-\Delta Modulator, (f_s = 57.6 MHz)')
ylabel('Log Mag (dB)')
xlabel('Frequency (MHz)')

figure(2)

% three stage CIC with 5-to-1 downsampling  
reg_in=zeros(1,3);
reg_out=zeros(1,3);

mm=1;
for nn=1:5:length(yy)
    for kk=1:5
    sm1=reg_in(1)+yy(nn+kk-1);
    sm2=reg_in(2)+sm1;
    sm3=reg_in(3)+sm2;
    reg_in=[sm1 sm2 sm3];
    end
    sm4=sm3-reg_out(1);
    sm5=sm4-reg_out(2);
    sm6=sm5-reg_out(3);
    reg_out=[sm3 sm4 sm5];
    yy2(mm)=sm6/125;
    mm=mm+1;
end

subplot(2,1,1)
plot(yy2(1:180),'b','linewidth',2)
grid on
title('Time Series: Output of 5-to-1 CIC Filter')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww2=kaiser(n_dat/5,14)';
ww2=ww2/sum(ww2);
c1=ones(1,5);
c2=conv(c1,c1);
c4=conv(c2,c2);
c5=conv(c4,c1);
gain=5^5;

plot((-0.5:1/(n_dat/5):0.5-1/(n_dat/5))*57.6/5,fftshift(20*log10(abs(fft(yy2(21:n_dat/5+20).*ww2)))),'b','linewidth',1.5)
hold on
plot((-0.5:1/1024:0.5-1/1024)*57.6,fftshift(20*log10(abs(fft(c5/gain,1024)))),'r','linewidth',2)
plot((-0.5:1/1024:0.5-1/1024)*57.6,fftshift(20*log10(abs(fft(exp(j*2*pi*(-10:10)/5).*c5/gain,1024)))),':r','linewidth',2)
plot((-0.5:1/1024:0.5-1/1024)*57.6,fftshift(20*log10(abs(fft(exp(-j*2*pi*(-10:10)/5).*c5/gain,1024)))),':r','linewidth',2)
plot([-0.625 -0.625 0.625 0.625],[-110 0 0 -110],':r','linewidth',2)

hold off
grid
axis([-11.52/2 11.52/2 -110 10])
title('Spectrum: Output of 5-stage CIC Filter with CIC Gain and Folded Mainlobe and Sidelobe (f_s = 11.52 MHz)')
ylabel('Log Mag (dB)')
xlabel('Frequency (MHz)')

figure(3);
phi1=[0.00  0.1  0.11  0.2  0.21  0.3  0.31...
               0.4  0.41  0.5  0.51  0.6  0.61...
               0.7  0.71  0.8  0.81  0.9  0.91  1.0]*0.625;
%gg=(1 - (x^2/6 + x^4/120 - x^6/1540)^5; %taylor series of main lobe
f2=57.6/5;
phi=(phi1/f2)*pi;
tt=(1-(phi.^2)/6+(phi.^4)/120-(phi.^6)/1540).^5; %Sinc correction
  
hh3=remez(29,[phi1 1.6 f2/2]/(f2/2),[1./tt  0  0],[5 5 5 5 5 5 5 5 5 5 1]);
yy3=conv(yy2,hh3);
subplot(2,1,1)
plot(yy3(1:180),'b','linewidth',1.5)
grid on
title('Time Series: Output of 3-to-1 FIR Filter Prior to 3-to-1 Downsample')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot((-0.5:1/(n_dat/5):0.5-1/(n_dat/5))*57.6/5,fftshift(20*log10(abs(fft(yy3(21+9:n_dat/5+20+9).*ww2)))),'b','linewidth',1.5)
hold on
plot((-0.5:1/1024:0.5-1/1024)*57.6/5,fftshift(20*log10(abs(fft(hh3,1024)))),'r','linewidth',1.5)
plot([1.92 1.92],[-110 0],':r','linewidth',2)
plot(-[1.92 1.92],[-110 0],':r','linewidth',2)
plot([-0.625 -0.625 0.625 0.625],[-110 0 0 -110],':r','linewidth',2)
hold off
grid
axis([-11.52/2 11.52/2 -110 10])
title('Spectrum: Output of 3-to-1 FIR Filter Prior to 3-to-1 (f_s = 11.52 MHz)')
ylabel('Log Magnitude (dB)')
xlabel('Frequency in MHz')

figure(4);
yy4=yy3(1:3:length(yy3));
subplot(2,1,1)
plot(yy4(1:60),'b','linewidth',1.5)
grid on
title('Time Series: Output of 3-to-1 FIR Filter After 3-to-1 Downsample')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww4=kaiser(n_dat/15,14)';
ww4=ww4/sum(ww4);
plot((-0.5:1/(n_dat/15):0.5-1/(n_dat/15))*57.6/15,fftshift(20*log10(abs(fft(yy4(7+3:n_dat/15+6+3).*ww4)))),'b','linewidth',2)
hold on
plot((-0.5:1/1024:0.5-1/1024)*57.6/5,fftshift(20*log10(abs(fft(hh3,1024)))),'r','linewidth',2)
plot([1.92 1.92],[-110 0],':r','linewidth',2)
plot(-[1.92 1.92],[-110 0],':r','linewidth',2)
plot([-0.625 -0.625 0.625 0.625],[-110 0 0 -910],':r','linewidth',2)

hold off
grid
axis([-11.52/6 11.52/6 -110 10])
title('Spectrum: Output of 3-to-1 FIR Filter After 3-to-1 (f_s = 3.84 MHz)')
ylabel('Log Magnitude (dB)')
xlabel('Frequency in MHz')  
function filter_ten_x(flag)
% filter_ten_x(flag) flag=0 for constant sidelobes, flag=1 for falling sidelobes
%  Script file written by fred harris of UCSD. Copyright 2021

hh1=remez(169,[0 40 60 500]/500,[1 1 0 0],[1 100]);
hh2=remez(169,[0 40 60 500]/500,{'myfrf',[1 1 0 0]},[1 100]);

hh=hh1;
if flag==1
   hh=hh2;
end

figure(1)
subplot(2,1,1)
plot(0:169,hh,'b','linewidth',2)
grid
axis([-10 180 -0.05 0.1])
title('Impulse Response: Prototype Filter')
xlabel('Normalized time nT/T')
ylabel('Amplitude')
subplot(2,1,2)
plot((-0.5:1/1024:.5-1/1024)*1000,fftshift(20*log10(0.000001+abs(fft(hh,1024)))),'b','linewidth',2)
grid
axis([-500 500 -90 10])
title('Frequency Response: Prototype Filter')
xlabel('Frequency (kHz)')
ylabel('Log-Magnitude (dB)')
pause

x1=1*cos(2*pi*(0:2299)*10/1000);
x2=2+cos(2*pi*(0:2299)*15/1000);
x2=x2.*cos(2*pi*(0:2299)*100/1000);
x3=(3*cos(2*pi*(0:2299)*22/1000)+5*sin(2*pi*(0:2299)*6/1000));
x3=x3.*sin(2*pi*(0:2299)*300/1000);

xx=x1+x2+x3;
xx=[xx zeros(1,200)];

figure(2)
subplot(2,1,1)
plot(0:200,xx(1:201),'b','linewidth',2);
grid on
axis([0 200 -10 10])
title('Real Input Time Series')
xlabel('Normalized time nT/T')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(1024,8)';
ww=ww/sum(ww);
plot((-0.5:1/1024:.5-1/1024)*1000,fftshift(20*log10(abs(fft(xx(1:1024).*ww,1024)))),'b','linewidth',2)
grid on
axis([-500 500 -90 10])
title('Spectrum of Real Input Series')
xlabel('Frequency (kHz)')
ylabel('Log-Magnitude (dB)')

pause
hold on
plot((-0.5:1/1024:.5-1/1024)*1000,fftshift(20*log10(0.00001+abs(fft(hh,1024)))),'r','linewidth',2)
pause
gg1=hh.*exp(j*2*pi*(-84.5:84.5)*100/1000);
plot((-0.5:1/1024:.5-1/1024)*1000,fftshift(20*log10(abs(fft(gg1,1024)))),'r:','linewidth',2)
gg2=hh.*exp(j*2*pi*(-84.5:84.5)*200/1000);
plot((-0.5:1/1024:.5-1/1024)*1000,fftshift(20*log10(abs(fft(gg2,1024)))),'r:','linewidth',2)
gg3=hh.*exp(j*2*pi*(-84.5:84.5)*300/1000);
plot((-0.5:1/1024:.5-1/1024)*1000,fftshift(20*log10(abs(fft(gg3,1024)))),'r:','linewidth',2)
gg4=hh.*exp(j*2*pi*(-84.5:84.5)*400/1000);
plot((-0.5:1/1024:.5-1/1024)*1000,fftshift(20*log10(abs(fft(gg4,1024)))),'r:','linewidth',2)
hold off
pause

hh2=reshape(hh,10,17);

reg=zeros(10,17);
n2=1;
for nn=1:10:2500
  
   reg(:,2:17)=reg(:,1:16);
   reg(:,1)=flipud(xx(nn:nn+9)');
   for mm=1:10
      vv(mm)=reg(mm,:)*hh2(mm,:)';
   end
   yy(:,n2)=fft(vv)';
   n2=n2+1;
end


figure(3)
subplot(5,2,1)
plot(real(yy(1,:)),'b','linewidth',1.5)
grid on
title('Time Series, Channels 1-5')
axis([0 250 -1.5 1.5]);
subplot(5,2,2)
ww=kaiser(200,8)';
ww=ww/sum(ww);
plot((-0.5:1/256:.5-1/256)*100,fftshift(20*log10(abs(fft(yy(1,20:219).*ww,256)))),'b','linewidth',2)
axis([-50 50 -80 10])
grid
title('Spectra, Channels 1-5')

subplot(5,2,3)
plot(real(yy(2,:)),'b','linewidth',2)
grid on
axis([0 250 -2 2]);

subplot(5,2,4)
plot((-0.5:1/256:.5-1/256)*100,fftshift(20*log10(abs(fft(yy(2,20:219).*ww,256)))),'b','linewidth',2)
axis([-50 50 -80 10])
grid on

subplot(5,2,5)
plot(real(yy(3,:)),'b','linewidth',2)
grid on
axis([0 250 -0.5 0.5]);

subplot(5,2,6)
plot((-0.5:1/256:.5-1/256)*100,fftshift(20*log10(abs(fft(yy(3,20:219).*ww,256)))),'b','linewidth',2)
axis([-50 50 -80 10])
grid on

subplot(5,2,7)
plot(real(yy(4,:)),'b','linewidth',2)
grid
axis([0 250 -5 5]);

subplot(5,2,8)
plot((-0.5:1/256:.5-1/256)*100,fftshift(20*log10(abs(fft(yy(4,20:219).*ww,256)))),'b','linewidth',2)
axis([-50 50 -80 10])
grid on

subplot(5,2,9)
plot(real(yy(5,:)),'b','linewidth',2)
grid on
axis([0 250 -0.5 0.5]);

subplot(5,2,10)
plot((-0.5:1/256:.5-1/256)*100,fftshift(20*log10(abs(fft(yy(5,20:219).*ww,256)))),'b','linewidth',2)
axis([-50 50 -80 10])
grid on

pause
figure(4)
subplot(2,2,1)
plot(0,0)
hold on
for mm=1:10
   plot(0:1/64:1-1/64,(10*abs(fft(hh2(mm,:),64))),'linewidth',1.5)
end
hold off
grid on
title('Spectral Magnitude Response of Ten Polyphase Filters')
xlabel('Normalized Frequency')
ylabel('Amplitude')
axis([0 0.5 0.0 1.2])

subplot(2,2,3)
plot(0,0)
hold on
for mm=1:10
    plot(0:1:16,0.5*mm+10*hh2(mm,:),'linewidth',1.5)
end
plot([7.55 8.45],[5.628 1.128],'r','linewidth',1.5)
hold off
grid
title('Impulse Response of Ten Polyphase Filters')
xlabel('Normalized Time')
axis([-1 17 -0.2 6])

subplot(2,2,2)
plot(0,0)
hold on

for mm=1:10
   plot(0:1/64:1-1/64,unwrap((angle((fft(hh2(mm,:),64)))))/(2*pi),'linewidth',1.5)
end
hold off
grid on
title('Spectral Phase Response of Ten Polyphase Filters')
axis([0 0.5 -5 0])
xlabel('Normalized Frequency (f/fs)')
ylabel('Phase Shift (\theta/2\pi)')

subplot(2,2,4)
plot(0,0)
hold on
for mm=1:10
   vv=unwrap(angle(fftshift(fft(hh2(mm,:),64))))/(2*pi);
   vv2=64*filter([1 -1],1, vv);
   plot(0:1/64:1-1/64,fftshift(vv2),'linewidth',1.5)
end
hold off
grid on
title('Spectral Group Delay Response of Ten Polyphase Filters')
xlabel('Normalized Frequency (f/fs)')
ylabel('Group Delay (d\theta/d\omega) (Samples)')
axis([0 0.5 -9 -7])

% 
 pause   
figure(5)
plot(0,0)
hold on
for mm=1:10
   plot(0:1/64:1-1/64,unwrap((angle((fft(hh2(mm,:),64)))))/pi,'linewidth',2)
end
hold off
grid
title('Spectral Phase Response of 10 Polyphase Filters')
axis([0 0.5 -9 0])
xlabel('Normalized Frequency (f/fs)')
ylabel('Phase Shift (\theta/2\pi)')

axes('position',[0.6 0.6 0.3 0.3])
plot(0,0)
hold on
for mm=1:10
   plot(0:1/64:1-1/64,unwrap((angle((fft(hh2(mm,:),64)))))/pi,'linewidth',1.5)
end
hold off
grid on
axis([0.1 0.15 -2.4 -1.6])
pause

figure(6)
plot(0,0)
hold on
for mm=1:10
   vv=unwrap(angle(fftshift(fft(hh2(mm,:),64))))/(2*pi);
   vv2=64*filter([1 -1],1, vv);
   plot(0:1/64:1-1/64,fftshift(vv2),'linewidth',1.5)
end
hold off
grid on
title('Spectral Group Delay Response of 10 Polyphase Filters')
axis([0 0.5 -9 -7])
xlabel('Normalized Frequency (f/fs)')
ylabel('Group Delay (d\theta/d\omega) (Samples)')


% Michelle_6_path Study of 6-Path Non-Maximally Decimated Analysis Bank
% Figure 1. Time and Frequency Response of 6-Path Analysis filter
% Figure 2. Impulse response of 6-Path Filters Prior to 6-to-1 Downsample
% Figure 3. Phase Response of 6-Path Filters Prior to 6-to-1 Downample
% Figure 4. Impulse Response of 6-Channels of Polyphase Filter Bank 
% Figure 5. Frequency Response of 6-Channels of Polyphase Filter Bank 
% Figure 6. Sliding Tone Time Response of 6-Paths Polyphase Filter 
%           With Time Response Sum, Spectrum of Sum, and Phases of Each Path 
%           0-phase difference Nyquist Zone-0, 
%           2 pi/6 phase difference Nyquist Zone-1
%           2 pi/3 phase difference Nyquist Zone-2
%           2 pi/2 phase difference Nyquist Zone-3
% Figure 7. Sliding Tone Time Response of 6-Channels of Polyphase Filter Bank 
% Figure 8. Sliding Tone Frequency Response of 6-Channels of Polyphase Filter Bank 

% Script file written by fred harris of UCSD, Copyright 2021.


% N1=(36/2)*80/22 =65
h0=remez(64,[0 1.5 4.5 18]/18,{'myfrf',[1 1 0 0]},[1 1]);
f1=1.5;
f2=4.5;
figure(1)
subplot(3,1,1)
plot(-32:32,h0/max(h0),'linewidth',2);
grid on
axis([-35 35 -0.3 1.2])
title(['65-Tap Nyquist Filter, Windowed Sinc, 0.1-dB BW = \pm',num2str(f1),' kHZ, -80 dB BW =\pm',num2str(f2),' kHz, f_S = 36 kHz'],'fontsize',14)
xlabel('Time Index','fontsize',14)
ylabel('Amplitude','fontsize',14)
text(15,0.7,['0.1 dB BW = ',num2str(f1,'%5.1f'),' kHz'],'fontsize',14)

subplot(3,1,2)
fh0=fftshift(20*log10(abs(fft(h0,2048))));
plot((-0.5:1/2048:0.5-1/2048)*36,fh0,'linewidth',2)
hold on
plot( [-f1 -f1 +f1 +f1],[-90 -0.1 -0.1 -90],'r--','linewidth',2)
plot( [f2 f2 20],[-20 -80 -80],'r--','linewidth',2)
plot(-[f2 f2 20],[-20 -80 -80],'r--','linewidth',2)
hold off
grid on
axis([-18 18 -100 10])
title(['Spectrum; Passband 0-to-',num2str(f1),' kHz, Stopband ',num2str(f2),'-to-18 kHz, 80 db Attenuation'],'fontsize',14)
xlabel('Frequency (kHz)','fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)

subplot(3,2,5)
plot((-0.5:1/2048:0.5-1/2048)*36,fh0,'linewidth',2)
hold on
plot( [-f1 -f1 +f1 +f1],[-0.0015 -0.001 -0.001 -0.0015],'r--','linewidth',2)
plot( [-f1 -f1 +f1 +f1],[+0.015 +0.001 +0.001 +0.0015],'r--','linewidth',2)
hold off
grid on
axis([-f1-1 f1+1 -0.0015 0.0015])
title('Zoom to Passband Ripple','fontsize',14)
xlabel('Frequency (kHz)','fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)

subplot(3,2,6)
plot((-0.5:1/2048:0.5-1/2048)*36,fh0,'linewidth',2)
hold on
plot( [f1-1 +f1 +f1],[-0.1 -0.1 -90],'r--','linewidth',2)
plot( [f2 f2 20],[-20 -80 -80],'r--','linewidth',2)
hold off
grid on
axis([f1-1  f2+2 -100 5])
title('Transition BW and Stopband Detail','fontsize',14)
xlabel('Frequency (kHz)','fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)

figure(2)
for k=1:6
    subplot(2,3,k)
    vv=zeros(1,65);
    vv(k:6:65)=6*h0(k:6:65);
    stem(0:64,vv,'linewidth',2)
    hold on
    plot(k-1:6:64,vv(k:6:65),'r*','linewidth',2)
    hold off
    grid on
    axis([0 64 -0.3 1.1])
end


figure(3)
plot(0,0)
hold on
for k=1:6
    vv=zeros(1,65);
    vv(k:6:65)=6*h0(k:6:65);
    ph_vv=unwrap(angle(fftshift(fft(vv,1024))))/(2*pi);
    plot((-0.5:1/1024:0.5-1/1024)*36,ph_vv-ph_vv(513),'linewidth',2)
end
hold off
    grid on
    axis([-18 18 -18 18])
    set(gca,'xtick',[-18:3:18])
    set(gca,'fontsize',12)
    
    title('Phase Response of 6-Path Weights h(k:6:64), k=0,1,...,5, Prior to 6-to-1 Downsample','fontsize',14)
    xlabel('Frequency','fontsize',14)
    ylabel('Phase','fontsize',14)
    text(-17.5,17.8,'\Delta Phase = 180^o','fontsize',14,'rotation',-25)
    text(-14,14.5,'6-Paths, \Delta Phase = 120^o','fontsize',14,'rotation',-25)
    text(-8,+9,'6-Paths, \Delta Phase = 60^o','fontsize',14,'rotation',-25)
    text(-2,3.,'6-Paths, \Delta Phase = 0^o','fontsize',14,'rotation',-25)
    text(+4.0,-1.5,'6-Paths, \Delta Phase = 60^o','fontsize',14,'rotation',-25)
    text(+10.0,-6.5,'6-Paths, \Delta Phase = 120^o','fontsize',14,'rotation',-25)
    text(+15.0,-10.3,'\Delta Phase = 180^o','fontsize',14,'rotation',-25)

%%%%%%%%%%%%%%% 6-to-1 downsampling filter, output sample rate = 3
%%%%%%%%%%%%%%%%%%%%%%%% polyphase filter %%%%%%%%%%%%%%% 
scl=max(h0);
hh0=reshape([h0/scl 0],6,11);

reg=zeros(3,22);
v0=zeros(1,3)';
v1=zeros(1,6)';
v2=zeros(6,25);
x0=zeros(1,75);
x0(1)=1;

m=1;
flg=0;
for n=1:3:75-3
    v0=fliplr(x0(n:n+2)).';
    reg=[v0 reg(:,1:21)];
        for k=1:3
          v1(k)=reg(k,1:2:22)*hh0(k,:)';
          v1(k+3)=reg(k,2:2:22)*hh0(k+3,:)';
        end
        if flg==0
            flg=1;
        else
            flg=0;
            v1=[v1(4:6);v1(1:3)];
        end
        v2(:,m)=ifft(v1);
        m=m+1;
end

figure(4)
for k=1:6
  subplot(3,2,k)
plot(0:22,6*real(v2(k,1:23)),'linewidth',2)
hold on
plot(0:22,6*imag(v2(k,1:23)),'r','linewidth',2)
hold off
grid on
axis([0 22 -1.1 1.1])
title(['Impulse Response, Chan(',num2str(k-1),')'],'fontsize',14)
xlabel('Time Index','fontsize',14)
ylabel('Amplitude','fontsize',14)
end

figure(5)
for k=1:6
  subplot(3,2,k)
plot((-0.5:1/128:0.5-1/128)*12,fftshift(20*log10(abs(3*fft(v2(k,:),128)))),'linewidth',2)
hold on
plot([-3 -3 +3 +3],[-100 0 0 -100],'--r','linewidth',2)
hold off
grid on
axis([-6 6 -100 10])
title(['Frequency Response, Chan(',num2str(k-1),')'],'fontsize',14)
xlabel('Frequency','fontsize',14)
ylabel('Amplitude','fontsize',14)
end

scl=max(h0);
hh0=reshape([h0/scl 0],6,11);
f_h0=fftshift(abs(fft(h0,128)));
w=kaiser(256,5')';

for k=0:1:256
reg=zeros(3,22);
v0=zeros(1,3)';
v1=zeros(1,6)';
v2=zeros(6,34);
%x0=exp(j*2*pi*(0:1200)*1/256)*exp(-j*2*pi*0.365);
x0=exp(j*2*pi*(0:1200)*k/256);

x1=zeros(1,200);

m=1;
flg=0;
for n=1:3:1200-3
    v0(1:3)=fliplr(x0(n:n+2)).';
    reg=[v0 reg(:,1:21)];
        for k=1:3
          v1(k)=reg(k,1:2:22)*hh0(k,:)';
          v1(k+3)=reg(k,2:2:22)*hh0(k+3,:)';
        end
        if flg==0
            flg=1;
        else
            flg=0;
            v1=[v1(4:6);v1(1:3)];
        end
        v2(:,m)=v1;
       x1(m)=sum(v2(:,m));
        m=m+1;
end

figure(6)
subplot(4,1,1)
plot((-0.5:1/512:0.5-1/512)*36,fftshift(abs(fft(x0(1:512)/512))),'linewidth',2.5)
hold on
for zz=-3:3
plot((-0.5:1/128:0.5-1/128)*36+zz*6,f_h0,'--','linewidth',2)
end
hold off
grid on
axis([-18 18 0 1.1])
title('Channel Spectral Centers and Shifting Tone Frequency Response','fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)
xlabel('Frequency','fontsize',14)

for k=1:6
subplot(4,3,k+3)
plot(real(v2(k,:)),'linewidth',2.5)
hold on
plot(imag(v2(k,:)),'r','linewidth',2.5)
hold off
axis([0 100 -1.2 1.2])
grid on
title(['In-Band Tone Time Response, Path (',num2str(k-1),')'],'fontsize',14)
ylabel('Amplitude','fontsize',14)
xlabel('Time Index','fontsize',14)
end

subplot(4,3,10)
plot(scl*real(x1),'linewidth',2.5)
hold on
plot(scl*imag(x1),'r','linewidth',2.5)
hold off
grid on
axis([0 100 -1.2 1.2])
title('In-Band Tone Response Sum of 6-Paths','fontsize',14)
ylabel('Amplitude','fontsize',14)
xlabel('Time Index','fontsize',14)

subplot(4,3,11)
ww=kaiser(128,0)';
ww=ww/sum(ww);
fx1=fftshift(20*log10(abs(fft(scl*x1(21:148+128)/256,256))));
plot((-0.5:1/256:0.5-1/256)*6,fx1,'linewidth',2.5)
grid on
axis([-3 3 -120 10])
title('Frequency Response, Sum of 6-Paths','fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)
xlabel('Frequency (kHz)','fontsize',14)

subplot(4,3,12)
plot(0,0)
hold on
for k=1:6
    plot(fftshift((fft(v2(k,21:148+128)/256))),'-o','linewidth',2.5);
end
hold off
grid on
axis('square')
axis([-1.5 1.5 -1.5 1.5])
title('Nyquist Plot, Each of 6-Paths','fontsize',14)
ylabel('Real','fontsize',14)
xlabel('Imaginary','fontsize',14)

pause(0.2)
end



scl=max(h0);
hh0=reshape([h0/scl 0],6,11);
f_h0=fftshift(abs(fft(h0,128)));
w=kaiser(256,5')';

for k=0:1:256
reg=zeros(3,22);
v0=zeros(1,3)';
v1=zeros(1,6)';
v2=zeros(6,86);
x0=exp(j*2*pi*(0:1200)*k/256);

m=1;
flg=0;
for n=1:3:1200-3
    v0(1:3)=fliplr(x0(n:n+2)).';
    reg=[v0 reg(:,1:21)];
        for k=1:3
          v1(k)=reg(k,1:2:22)*hh0(k,:)';
          v1(k+3)=reg(k,2:2:22)*hh0(k+3,:)';
        end
        if flg==0
            flg=1;
        else
            flg=0;
            v1=[v1(4:6);v1(1:3)];
        end
        v2(:,m)=ifft(v1);
        m=m+1;
end

figure(7)
subplot(4,1,1)
plot((-0.5:1/512:0.5-1/512)*36,fftshift(abs(fft(x0(1:512)/512))),'linewidth',2.5)
hold on
for zz=-3:3
plot((-0.5:1/128:0.5-1/128)*36+zz*6,f_h0,'--','linewidth',2)
end
hold off
grid on
axis([-18 18 0 1.1])
title('Channel Spectral Centers and Shifting Tone Frequency Response','fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)
xlabel('Frequency','fontsize',14)

for k=1:6
subplot(3,3,k+3)
plot(real(v2(k,:)),'linewidth',2.5)
hold on
plot(imag(v2(k,:)),'r','linewidth',2.5)
hold off
axis([0 100 -1.2 1.2])
grid on
title(['In-Band Tone Time Response, Channel (',num2str(k-1),')'],'fontsize',14)
ylabel('Amplitude','fontsize',14)
xlabel('Time Index','fontsize',14)
end

pause(0.2)
end




scl=max(h0);
hh0=reshape([h0/scl 0],6,11);
f_h0=fftshift(abs(fft(h0,128)));
w=kaiser(256,5')';
ww=kaiser(256,10)';
ww=ww/sum(ww)';
for k=0:1:256
reg=zeros(3,22);
v0=zeros(1,3)';
v1=zeros(1,6)';
v2=zeros(6,86);
x0=exp(j*2*pi*(0:1200)*k/256);

m=1;
flg=0;
for n=1:3:1200-3
    v0(1:3)=fliplr(x0(n:n+2)).';
    reg=[v0 reg(:,1:21)];
        for k=1:3
          v1(k)=reg(k,1:2:22)*hh0(k,:)';
          v1(k+3)=reg(k,2:2:22)*hh0(k+3,:)';
        end
        if flg==0
            flg=1;
        else
            flg=0;
            v1=[v1(4:6);v1(1:3)];
        end
        v2(:,m)=ifft(v1);
        m=m+1;
end

figure(8)
subplot(4,1,1)
plot((-0.5:1/512:0.5-1/512)*36,fftshift(abs(fft(x0(1:512)/512))),'linewidth',2.5)
hold on
for zz=-3:3
plot((-0.5:1/128:0.5-1/128)*36+zz*6,f_h0,'--','linewidth',2)
end
hold off
grid on
axis([-18 18 0 1.1])
title('Channel Spectral Centers and Shifting Tone Frequency Response','fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)
xlabel('Frequency','fontsize',14)

for k=1:6
subplot(3,3,k+3)
plot((-0.5:1/256:0.5-1/256)*12,fftshift(20*log10(abs(fft(v2(k,21:276).*ww)))),'linewidth',2.5)
hold on
plot((-0.5:1/128:0.5-1/128)*36,20*log10(f_h0),'r','linewidth',2.5)
hold off
axis([-6 6 -100 10])
grid on
title(['In-Band Tone Frequency Response, Channel (',num2str(k-1),')'],'fontsize',14)
ylabel('Log Mag (dB)','fontsize',14)
xlabel('Frequency','fontsize',14)
end

pause(0.2)
end

function polyphase_30a
% script file illustrating 30 stage polyphase partition. Signal is followed through resampling steps,
% signal seen at input rate, at downsampled aliased output aliased rate in a polyphase arm, and at down
% sampled phase corrected de-aliased rate at output. Can see residual spectral levels in empty 
% spectral bands.
% Script file written by fred harris of SUCSD. Copyright 2021

hh=remez(269,[0 50 100 2250]/2250,{'myfrf',[1 1 0 0]},[1 10]);
figure(1)
subplot(2,1,1)
stem(0:269,hh,'linewidth',1)
grid on
axis([-10 280 -0.01 0.04])
title('Prototype Filter Impulse Response')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
fhh=fftshift(20*log10(0.0000001+abs(fft(hh,4096))));
plot((-0.5:1/4096:0.5-1/4096)*4500,fhh,'linewidth',1.5)
grid on
axis([-2250 2250 -80 10])
title('Frequency Response')
xlabel('Frequency')
ylabel('20 log_1_0(mag) (dB)')

axes('position',[0.26 0.22 0.171 0.19])
plot((-0.5:1/4096:0.5-1/4096)*4500,fhh,'linewidth',1.5)
grid
axis([-60 60 -0.2 0.2])
title('Passband Ripple')
xlabel('Frequency')
ylabel('Log Mag(dB)')

axes('position',[0.604 0.22 0.231 0.19])
plot((-0.5:1/4096:0.5-1/4096)*4500,fhh,'linewidth',1.5)
grid
axis([0 150 -70 10])
title('Transition Bandwidth')
xlabel('Frequency')
ylabel('Log Mag(dB)')


n_dat=6000;
xx=cos(2*pi*(1:n_dat)*10/4500)+cos(2*pi*(1:n_dat)*30/4500)+cos(2*pi*(1:n_dat)*50/4500);
xx=xx+0.5*(exp(j*2*pi*(1:n_dat)*300/4500)+exp(j*2*pi*(1:n_dat)*320/4500)+exp(j*2*pi*(1:n_dat)*340/4500));

hh2=reshape(hh,30,9);
reg=zeros(30,9);

mm=1;
for nn=1:30:n_dat
    reg(:,2:9)=reg(:,1:8);
    reg(:,1)=fliplr(xx(nn:nn+29)).';
    v=sum((reg.*hh2)');
    
%     reg=ones(5,3)
%     wts=reshape((1:15),5,3)
%     v=sum((reg.*wts)')'
vv(mm,:)=v;
r1(mm)=sum(v);
r2(mm)=conj(v)*exp(j*2*pi*(0:29)/30).';
r3(mm)=conj(v)*exp(j*2*pi*(0:29)*2/30).';
mm=mm+1;
end

figure(2)
subplot(2,1,1)
ww=kaiser(n_dat,10)';
ww=ww/sum(ww);
plot((-0.5:1/n_dat:0.5-1/n_dat)*4500,fftshift(20*log10(abs(fft(xx.*ww)))),'linewidth',1.5)
grid
axis([-500 500 -90 0])
title('Input Signal Spectrum')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(2,2,3)
m_dat=length(vv(:,1));
ww=kaiser(m_dat,10)';
ww=ww/sum(ww);
plot((-0.5:1/m_dat:0.5-1/m_dat)*150,fftshift(20*log10(abs(fft(vv(:,1)'.*ww)))),'linewidth',1.5)
grid
axis([-75 75 -90 0])
title('Polyphase Stage-0 Spectrum')
xlabel('Frequency')
ylabel('Log Mag (dB)')

subplot(2,2,4)
m_dat=length(vv(:,2));
ww=kaiser(m_dat,10)';
ww=ww/sum(ww);
plot((-0.5:1/m_dat:0.5-1/m_dat)*150,fftshift(20*log10(abs(fft(vv(:,2)'.*ww)))),'linewidth',1.5)
grid
axis([-75 75 -90 0])
title('Polyphase Stage-1 Spectrum')
xlabel('Frequency')
ylabel('Log Mag (dB)')

figure(3)

subplot(3,2,1)
plot(real(r1),'linewidth',1.5)
grid
title('Time Series. Channel-0')
ylabel('Amplitude')

subplot(3,2,3)
plot(real(r2),'linewidth',1.5)
hold on
plot(imag(r2),'r','linewidth',1.5)
hold off
grid
title('Time Series. Channel-1')
ylabel('Amplitude')

subplot(3,2,5)
plot(real(r3),'linewidth',1.5)
hold on
plot(imag(r3),'r','linewidth',1.5)
hold off
grid
title('Time Series. Channel-2')
ylabel('Amplitude')
xlabel('Time Index')

m_dat=length(r1);
ww=kaiser(m_dat,10)';
ww=ww/sum(ww);
subplot(3,2,2)
plot((-0.5:1/1024:0.5-1/1024)*150,fftshift(20*log10(abs(fft(r1.*ww,1024)))),'linewidth',1.5)
grid
axis([-75 75 -90 0])
title('Spectrum Channel-0')
ylabel('Log Mag (dB)')

subplot(3,2,4)
plot((-0.5:1/1024:0.5-1/1024)*150,fftshift(20*log10(abs(fft(r2.*ww,1024)))),'linewidth',1.5)
grid
axis([-75 75 -90 0])
title('Spectrum Channel-1')
ylabel('Log Mag (dB)')

subplot(3,2,6)
plot((-0.5:1/1024:0.5-1/1024)*150,fftshift(20*log10(abs(fft(r3.*ww,1024)))),'linewidth',1.5)
grid
axis([-75 75 -90 0])
title('Spectrum Channel-2')
xlabel('Frequency')
ylabel('Log Mag (dB)')



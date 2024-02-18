function polyphase_50a
% demonstration of 48-path resampling polyphase filter bank
% Script file written by fred harris of UCSD. Copyright 2021

hh=remez(511,[0 96 160 192*32]/(192*32),{'myfrf',[1 1 0 0]},[1 13]);

% examine prototype filter
figure(1)
subplot(2,1,1)
plot(0:511,hh,'b','linewidth',2)
title('Impulse Response, Prototype Filter')
xlabel('Time Index')
ylabel('Amplitude')
grid on
axis([-10 520 -0.005 0.022])

subplot(2,1,2)
plot((-0.5:1/2048:.5-1/2048)*64,fftshift(20*log10(abs(fft(hh,2048)))),'b','linewidth',2)
grid
axis([-32 32 -80 10])
title('Frequency Response, Prototype Filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')
pause
% zoom to passband and compare with spectral copies at output rate
subplot(2,1,2)
hold on
het1=exp(j*2*pi*(0:511)/48);
het2=exp(-j*2*pi*(0:511)/48);
plot((-0.5:1/2048:.5-1/2048)*64,fftshift(20*log10(abs(fft(hh.*het1,2048)))),'r','linewidth',2)
plot((-0.5:1/2048:.5-1/2048)*64,fftshift(20*log10(abs(fft(hh.*het2,2048)))),'r','linewidth',2)
hold off
axis([-2 2 -80 10])
title('Frequency Response, Prototype and Replicates at Output Rate')
pause

% building sample input signal: can replace with any other signal set
% channel 0 is empty
ff=[1:25]+0.02;
xx=zeros(1,4848);
for rr=1:18
   xx=xx+exp(j*2*pi*(0:4847)*ff(rr)*(1/64)+j*2*pi*rand(1));
   xx=xx+exp(-j*2*pi*(0:4847)*ff(rr)*(1/64)+j*2*pi*rand(1));
end
figure(2)
subplot(2,1,1)
plot(real(xx(1:300)),'linewidth',2)
grid
title('Input Time Series: 50 Random Phase Sinusoids Offset From Channel Center Frequencies')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4848,6)';
f_xx=abs(fft(xx.*ww,8192));
plot((-0.5:1/8192:0.5-1/8192)*192*64,fftshift(20*log10(f_xx/max(f_xx))),'linewidth',2)
grid
title('Spectrum, Input Signal: (Bin Zero Empty)')
axis([-192*32 192*32 -60 10])
xlabel('Frequency (kHz)')
ylabel('Log-Magnitude (dB)')
pause
% mapping one-dimensional prototype filter to two-dimensional filter
hh2=reshape(hh,64,8);

% defining two-dimensional array of commutated input samples
reg2=zeros(64,8);

% defining initial condition of 4-state state machine
state=1;

% filtering data

n_dat=1;
for nn=1:48:4800

% circularly roll and shift data array
temp=reg2(1:16,:);
reg2(1:48,2:8)=reg2(17:64,1:7);
reg2(49:64,:)=temp;

%load input data array
reg2(1:48,1)=xx(nn+47:-1:nn)';

% form inner products
for mm=1:64
  dd(mm)=reg2(mm,:)*hh2(mm,:)';
end

% circular shift output array dd
if state==1;
   state=2;
   dd_shift=dd;
elseif state==2;
   state=3;
   dd_shift=[dd(49:64) dd(1:48)];
elseif state==3;
   state=4;
   dd_shift=[dd(33:64) dd(1:32)];
elseif state==4;
   state=1;
   dd_shift=[dd(17:64) dd(1:16)];
end

% phase shift via fft

dd2(n_dat,:)=fftshift(fft(dd_shift));
n_dat=n_dat+1;
end

% output 60 channelized time series
figure(3)
for kk=1:12
   subplot(3,4,kk)
   plot(real(dd2(:,3+kk)),'linewidth',2)
   ss=sprintf('time series:, channel %2i ', -30+kk);
   title(ss) 
   grid
   axis([0 100 -1.1 1.1])
end
figure(4)
for kk=1:12   
   subplot(3,4,kk)
   plot(real(dd2(:,15+kk)),'linewidth',2)
   ss=sprintf('time series:, channel %2i ', -18+kk);
   title(ss)
   grid
   axis([0 100 -1.1 1.1])
end
figure(5)
for kk=1:12
   subplot(3,4,kk)
   if kk==6
      plot(real(dd2(:,27+kk)),'r','linewidth',2)
   else
     plot(real(dd2(:,27+kk)),'linewidth',2)
   end
      ss=sprintf('time series:, channel %2i ', -6+kk);
   title(ss)
   grid
   axis([0 100 -1.1 1.1])
end

figure(6)
for kk=1:12
   subplot(3,4,kk)
   plot(real(dd2(:,39+kk)),'linewidth',2)
   ss=sprintf('time series:, channel %2i ', 6+kk);
   title(ss)
   grid
   axis([0 100 -1.1 1.1])
end
figure(7)
for kk=1:12
   subplot(3,4,kk)
   plot(real(dd2(:,51+kk)),'linewidth',2)
   ss=sprintf('time series:, channel %2i ', 18+kk);
   title(ss)
   grid
   axis([0 100 -1.1 1.1])
end

figure(8)
for kk=1:48
   subplot(6,8,kk)
   if kk==25
      plot(real(dd2(:,8+kk)),'r','linewidth',2)
   else
     plot(real(dd2(:,8+kk)),'linewidth',2)
   end
   %    ss=sprintf('time series:, channel %2i ', -30+kk);
%    title(ss) 
   grid
   axis([0 100 -1.1 1.1])
end

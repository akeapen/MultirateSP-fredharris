% function receiver_40a;
% receiver_40a is a demo of a 40 channel receiver, demodulating 30 channels,
% of nominal symbol rate 20 MHz, separated by 28 MHz centers (1.4 times symbol rate) 
% input sample rate is 40*28 = 1120 MHz. 
% receiver performs a 40 point transform on the output of a 40-stage polyphase filter
% the polyphase filter operates at input rate but outputs at 2 samples/symbol or
% 40 MHz. The resampling rate is 1120/40 = 28-to-1, thus output from 40-channels are
% computed once for every 28 input samples. channelizer is not matched filter, 
% prototype filter is 10% wider than two sided bandwidth of input signal to accommodate
% frequency uncertainty of separate channel centers.
% Design and Script file written by fred harris of UCSD. Copyright 2021

% signal generator section

hh_a=rcosine(1,112,'sqrt',0.4,6);
hh_b=hh_a(2:2:1345);
hh_b2=reshape(56*hh_b,56,12);
rr2=zeros(56*5,12);

xx1=2*floor(2*rand(28,100))-1;
xx1=xx1+j*(2*floor(2*rand(28,100))-1);
rr_a=zeros(1,40);


flag=0;
for nn=1:100
   %rr_a(10:29)=xx1(:,nn)';
   rr_a(1:14)=xx1(1:14,nn)';
   rr_a(27:40)=xx1(15:28,nn);
   rr_a(38)=0;
   rr_a(39)=0;

   %rr_a=fftshift(rr_a);
   rr_b=fft(rr_a);
   rr_b_ext=[rr_b rr_b rr_b rr_b rr_b rr_b rr_b];
   rr2(:,2:12)=rr2(:,1:11);
   rr2(:,1)=rr_b_ext';
   
   
   for mm=1:56
      xx_d((nn-1)*56+mm)=rr2(mm+56*flag,:)*hh_b2(mm,:)';
   end
   
   flag=flag+1;
   if flag==5;
      flag=0;
   end
   
end
figure(1)

subplot(2,1,1)
plot(real(xx_d(1:800)));
grid
title('Real Part of Composite Time Signal')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
ww=kaiser(4096,8)';
ww=ww/sum(ww);
fxx=fftshift(20*log10(abs(fft(xx_d(1:4096).*ww))));
plot((-0.5:1/4096:.5-1/4096)*40,fxx)
hold
plot((-51/4096:1/4096:51/4096)*40,fxx(2049-51:2049+51),'r')
hold
grid
axis([-20 20 -60 10])
title('Spectrum: composite time signal')
xlabel('Frequency')
ylabel('Log Mag (dB)')
%pause

xx=xx_d;

%receiver section

ff=[0 12 17 56 57 84 85 112 113 140 141 168 169 196 197 224 225 252 253 280 281 308 309 336 337 364 365 392 393 420 421 448 449 476 477 504 505 532 533 560]/560;
gg=[1  1  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 ];  
dd=[  1     6     7     9      11      13      15      17      19      21     23      25       27      29      31      33      35      37      39      41];
hh=remez(599,ff,gg,dd);

hh2=reshape(hh,40,15);
rr=zeros(40,15);

tt=1;
flg=1;
for nn=1:28:5600-28
   temp=rr(1:12,:);
   rr(1:28,2:15)=rr(13:40,1:14);
   rr(1:28,1)=flipud(xx((nn-1)+1:(nn-1)+28)');
   rr(29:40,:)=temp;
   
   for mm=1:40
      y(mm)=rr(mm,:)*hh2(mm,:)';
   end
   
    if flg==1
      r1=fftshift(fft(y));
      flg=2;
    elseif flg==2
      r1=fftshift(fft([y(29:40) y(1:28)]));
      flg=3;
    elseif flg==3
      r1=fftshift(fft([y(17:40) y(1:16)]));
      flg=4;
    elseif flg==4
      r1=fftshift(fft([y(5:40) y(1:4)]));
      flg=5;
    elseif flg==5
      r1=fftshift(fft([y(33:40) y(1:32)]));
      flg=6;
    elseif flg==6
      r1=fftshift(fft([y(21:40) y(1:20)]));
      flg=7;
    elseif flg==7
      r1=fftshift(fft([y(9:40) y(1:8)]));
      flg=8;
    elseif flg==8
      r1=fftshift(fft([y(37:40) y(1:36)]));
      flg=9;
    elseif flg==9
      r1=fftshift(fft([y(25:40) y(1:24)]));
      flg=10;
    elseif flg==10
      r1=fftshift(fft([y(13:40) y(1:12)]));
      flg=1;
    end
      
      yy(:,tt)=r1';
      
      tt=tt+1;
end


figure(2)
for kk=1:30
   subplot(5,6,kk)
   if kk==16
      plot(real(yy(kk+5,:)),'r','linewidth',1)
   else
      plot(real(yy(kk+5,:)),'b','linewidth',1)
   end
text(70,12.5,['ch(',num2str(kk-16),')'],'fontsize',12)
   
grid on
axis([0 200 -15 15])
if rem(kk,6)==1
    ylabel('Amplitude')
end
if kk>24
    xlabel('Time Index')
end
if kk==3
    text(0,22,'Time Responses of 30 Baseband Channels','fontsize',14)
end
end

figure(3)
  
ww=kaiser(199,7)';
ww=ww/sum(ww);
for kk=1:30
   subplot(5,6,kk)
   if kk==16
plot((-0.5:1/256:.5-1/256)*2,fftshift(20*log10(abs(fft(yy(kk+5,:).*ww,256)))),'r','linewidth',1)
else
plot((-0.5:1/256:.5-1/256)*2,fftshift(20*log10(abs(fft(yy(kk+5,:).*ww,256)))),'b','linewidth',1)
   end
text(-0.25,-30,['ch(',num2str(kk-16),')'],'fontsize',12)
if rem(kk,6)==1
    ylabel('Log Mag (dB)')
end
if kk>24
    xlabel('Frequency')
end
if kk==3
    text(-0.5,20,'Spectra of 30 Baseband Channels','fontsize',14)
end

grid
axis([-1 1 -60 10])
end
subplot(5,6,16)
hold
plot([-0.95 0.95 0.95 -0.95 -0.95],[-59 -59 9 9 -59],'r')
hold

%pause
%figure(4)
%subplot(2,2,1)
%plot(hh)
%grid

%title('prototype receiver filter')

%subplot(2,2,3)
%plot((-0.5:1/2048:.5-1/2048)*40,fftshift(20*log10(abs(fft(hh,2048)))));
%grid
%axis([-20 20 -80 10])
%title('spectrum: receiver filter')

%subplot(2,2,2)
%plot(hh_b)
%grid

%title('prototype transmitter filter')

%subplot(2,2,4)
%plot((-0.5:1/2048:.5-1/2048)*40,fftshift(20*log10(abs(fft(hh_b/sum(hh_b),2048)))));
%grid
%axis([-20 20 -80 10])
%title('spectrum: transmitter filter')

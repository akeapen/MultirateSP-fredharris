% vary_bw_channelizer_120_3
% Variable bandwidth by changing binary mask between cascade analysis
% filter bank and synthesis filter bank. Animated demonstration of
% reduction in BW when binary mask turns off subset of channels used to 
% reconstruct output signal. 
% Script file written by fred harris of UCSD, Copyright 2021.

%hh=0.999*remez(840,[0 0.20507 1.0 60.0]/60.0,{'myfrf',[1 1 0 0]},[1 10]);
hh=sinc((-420:420)/120*1.1588).*kaiser(841,10)';
hh=hh/sum(hh);
figure(1)
subplot(2,1,1)
plot(0:840,hh/max(hh))
grid on
axis([-5 850 -0.3 1.2])
title('Impulse Response, prototype filter for 120-path Channelizer')

hh_x=hh.*exp(j*2*pi*(-420:420)*1/120);
subplot(2,1,2)
plot((-0.5:1/4096:0.5-1/4096)*120,fftshift(20*log10(abs(fft(hh,4096)))))
hold on
plot((-0.5:1/4096:0.5-1/4096)*120,fftshift(20*log10(abs(fft(hh_x,4096)))),'r')
plot([1 1]*0.5,[-6 0],'r')
d3=10*log10(0.5);
plot([0.25 0.75],[1 1]*d3,'r')
hold off
grid on
axis([-6.0 6.0 -110 10])
%axis([0.499 0.501 -3.02 -3.0])
% 120 channel analysis filter bank 60-to-1 down sample in 120-path filter

hh_2=120*reshape(hh(1:840),120,7);
reg_a=zeros(120,14);
v1=zeros(1,120)';
v2=zeros(1,120)';
v3=zeros(1,120)';
v4=zeros(120,20);
v5=zeros(1,120)';
reg_b=zeros(120,14);

ww=kaiser(2048,15)';
ww=ww/sum(ww);
rr=0;
x2=[1 zeros(1,4000)];
x1=0.5*ones(1,4000);
for kk=1:8
    x1=x1+cos(2*pi*(1:4000)*kk/40+2*pi*rand(1));
end
% x1=exp(j*2*pi*(0:9000)*1.1/120);

vv=[0:-1:-10 -9:+10 +9:-1:-10 -9];
rr=vv(1);

for zz=1:51
% Impulse Response
m1=1;
m2=0;
flg1=0;
flg2=0;
reg_a=zeros(120,14);
reg_b=zeros(120,14);
for nn=1:60:4000-59
    v1(1:60)=fliplr(x2(nn:nn+59)).';
    v1(61:120)=v1(1:60);
    reg_a=[v1 reg_a(:,1:13)];
    
    for kk=1:60
        v2(kk)=reg_a(kk,1:2:14)*hh_2(kk,:)';
        v2(kk+60)=reg_a(kk+60,2:2:14)*hh_2(kk+60,:)';
    end
    
    if flg1==0
        flg1=1;
    elseif flg1==1
        flg1=0;
        v2=[v2(61:120);v2(1:60)];
    end
    
    v3=ifft(v2);
    v4(:,m1)=v3;
    m1=m1+1;
    v3=v3.*[ones(1,26+rr) zeros(1,69-2*rr) ones(1,25+rr)]';
    v5=60*ifft(v3);
    
    if flg2==0
        flg2=1;
    elseif flg2==1
        flg2=0;
        v5=[v5(61:120);v5(1:60)];
    end
    
    reg_b=[v5 reg_b(:,1:13)];
    
    for kk=1:60
        p1=reg_b(kk,1:2:14)*hh_2(kk,:)';
        p2=reg_b(kk+60,2:2:14)*hh_2(kk+60,:)';
        x6(m2+kk)=p1+p2;
    end
    m2=m2+60;
end
x_imp=x6;

% Signal Response
m1=1;
m2=0;
flg1=0;
flg2=0;
reg_a=zeros(120,14);
reg_b=zeros(120,14);
for nn=1:60:4000-59
    v1(1:60)=fliplr(x1(nn:nn+59)).';
    v1(61:120)=v1(1:60);
    reg_a=[v1 reg_a(:,1:13)];
    
    for kk=1:60
        v2(kk)=reg_a(kk,1:2:14)*hh_2(kk,:)';
        v2(kk+60)=reg_a(kk+60,2:2:14)*hh_2(kk+60,:)';
    end
    
    if flg1==0
        flg1=1;
    elseif flg1==1
        flg1=0;
        v2=[v2(61:120);v2(1:60)];
    end
    
    v3=ifft(v2);
    v4(:,m1)=v3;
    m1=m1+1;
    v3=v3.*[ones(1,26+rr) zeros(1,69-2*rr) ones(1,25+rr)]';
    v5=60*ifft(v3);
    
    if flg2==0
        flg2=1;
    elseif flg2==1
        flg2=0;
        v5=[v5(61:120);v5(1:60)];
    end
    
    reg_b=[v5 reg_b(:,1:13)];
    
    for kk=1:60
        p1=reg_b(kk,1:2:14)*hh_2(kk,:)';
        p2=reg_b(kk+60,2:2:14)*hh_2(kk+60,:)';
        x6(m2+kk)=p1+p2;
    end
    m2=m2+60;
end

figure(6)

subplot(2,1,1)
% plot(real(x6(633:930)))
% grid on
% %axis([200 400 -0.2 0.7])
% title('Impulse Response')
% xlabel('Time Index')
% ylabel('Amplitude')
plot((-0.5:1/2048:0.5-1/2048)*12,fftshift(20*log10(abs(fft(x1(1025:3072).*ww)))))
hold on
plot((-0.5:1/2048:0.5-1/2048)*12,fftshift(20*log10(abs(fft(x_imp(1:2048))))),'r')

hold off
grid on
axis([-6 6 -120 10])
title('Frequency Response')
xlabel('Normalized Frequency')
ylabel('Log Magnitude (dB)')

subplot(2,1,2)
plot((-0.5:1/2048:0.5-1/2048)*12,fftshift(20*log10(abs(fft(x6(1025:3072).*ww)))))
grid on
axis([-6 6 -120 10])
title('Frequency Response')
xlabel('Normalized Frequency')
ylabel('Log Magnitude (dB)')
pause(0.1)
rr=vv(zz+1);
%end
% 
% figure(2)
% subplot(2,1,1)
% plot(real(x_imp))
% grid on
% axis([650 900 -0.1 0.3])
% title('Impulse Response')
% xlabel('Time Index')
% ylabel('Amplitude')
% 
% subplot(2,1,2)
% plot((-0.5:1/2048:0.5-1/2048)*12,fftshift(20*log10(abs(fft(x_imp(1:2048))))))
% grid on
% axis([-6 6 -120 10])
% title('Frequency Response')
% xlabel('Normalized Frequency')
% ylabel('Log Magnitude (dB)')
% 
% axes('position',[0.67 0.215 0.21 0.16])
% plot((-0.5:1/2048:0.5-1/2048)*12,fftshift(20*log10(abs(fft(x_imp(1:2048))))))
% grid on
% axis([-1.7 1.7 -0.05 +0.05])
% title('Zoom to Passband Ripple')
end
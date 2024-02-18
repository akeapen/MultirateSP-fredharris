% Channelizer_20a 
% Sequence of 20-path filters synthesizing reduced BW super filter
% 20 MHz input rate, 20 MHz output rate, 10 MHz Synthesized BW 
% Bin spacing 20MHz/20, offset 20 MHz/40
% 10-to-1 Down Sampling in Analysis Filter,
% 1-to-10 Up Sampling in Synthesis Filter

% prototype filter for 20-path analysis channelizer
g1=sinc(-3+1/20:1/20:3-1/20).*kaiser(119,4.6)';
g1x=g1.*exp(+j*2*pi*(0:118)*0.5/20);

% Prototype Filter for 20-path Synthesis Channelizer  
g2=remez(118,[0 0.75 1.25 10]/10,{'myfrf',[1 1 0 0]},[1 1]);
g2x=g2.*exp(-j*2*pi*(0:118)*0.5/20);

figure(1)
subplot(3,1,1)
plot(g1,'b','linewidth',2)
grid on
axis([-5 125 -0.3 1.2])
title('120-Tap Impulse Response, Prototype 20-Path Nyquist Analysis Filter, 6-Taps per Path')
xlabel('Time Index')
ylabel('Amplitude')

subplot(3,1,2)
f_g1=fftshift(20*log10(abs(fft(g1/20,2048))));
plot((-0.5:1/2048:0.5-1/2048)*20,f_g1,'b','linewidth',2)
hold on
plot([+1 +1],[-60 10],':k','linewidth',2)
plot([-1 -1],[-60 10],':k','linewidth',2)
plot([-1 -1 +1 +1]*0.5,[-60 0 0 -60],':r','linewidth',2)
plot([0.75 0.75 1.5],[-20 -50 -50],'r','linewidth',2)
plot(-[0.75 0.75 1.5],[-20 -50 -50],'r','linewidth',2)
hold off
grid on
axis([-1.5 1.5 -60 10])
set(gca,'XTick',[-1.5:0.25:+1.5])
title('Frequency Response, 6-dB BW = 0.50 MHz, Stop Band BW = 0.75 MHz, Stop Band Attenuation, 50 dB')
xlabel('Frequency (MHz)')
ylabel('Log Mag (dB)')

subplot(3,2,5)
plot((-0.5:1/2048:0.5-1/2048)*20,f_g1,'b','linewidth',2)
grid on
axis([-0.5 0.5 -0.1 0.1])
set(gca,'XTick',[-0.5:0.25:+0.5])
title('Zoom to In-Band Ripple')
xlabel('Frequency (MHz)')
ylabel('Log Mag (dB)')

subplot(3,2,6)
plot((-0.5:1/2048:0.5-1/2048)*20,f_g1,'b','linewidth',2)
hold on
plot([0 +1 +1]*0.5,[0 0 -60],':r','linewidth',2)
plot([0.75 0.75 1],[-20 -50 -50],'r','linewidth',2)
hold off
grid on
axis([0 1.0 -60 10])
set(gca,'XTick',[0:0.25:+1.0])
title('Zoom to Transition Bandwidth')
xlabel('Frequency (MHz)')
ylabel('Log Mag (dB)')

figure(2)
subplot(3,1,1)
plot(g2*10,'b','linewidth',2)
grid on
axis([-5 125 -0.3 1.2])
title('160-Tap Impulse Response, Prototype FIRPM 20-Path Synthesis Filter, 6-Taps per Path')
xlabel('Time Index')
ylabel('Amplitude')

subplot(3,1,2)
f_g2=fftshift(20*log10(abs(fft(g2,2048))));
plot((-0.5:1/2048:0.5-1/2048)*20,f_g2,'b','linewidth',2)
hold on
plot([+1 +1],[-60 10],':k','linewidth',2)
plot([-1 -1],[-60 10],':k','linewidth',2)
plot([-1 -1 +1 +1]*0.75,[-60 0 0 -60],':r','linewidth',2)
plot([1.25 1.25 1.5],[-20 -50 -50],'r','linewidth',2)
plot(-[1.25 1.25 1.5],[-20 -50 -50],'r','linewidth',2)
hold off
grid on
axis([-1.50 1.50 -60 10])
set(gca,'XTick',[-1.5:0.25:+1.5])
title('Frequency Response, 6-dB BW 30MHz/40 = 0.750 MHz, Stop Band Attenuation, 50 dB')
xlabel('Frequency (MHz)')
ylabel('Log Mag (dB)')

subplot(3,2,5)
plot((-0.5:1/2048:0.5-1/2048)*20,f_g2,'b','linewidth',2)
grid on
axis([-1 1 -0.1 0.1])
set(gca,'XTick',[-1:0.25:+1])
title('Zoom to In-Band Ripple')
xlabel('Frequency (MHz)')
ylabel('Log Mag (dB)')

subplot(3,2,6)
plot((-0.5:1/2048:0.5-1/2048)*20,f_g2,'b','linewidth',2)
hold on
plot([+1 +1],[-60 10],':k','linewidth',2)
plot([0 +0.75 +0.75],[0 0 -60],':r','linewidth',2)
plot([1.25 1.25 1.5],[-20 -50 -50],'r','linewidth',2)
hold off
grid on
axis([0 1.5 -60 10])
set(gca,'XTick',[-1.5:0.25:+1.5])
title('Zoom to Transition BW')
xlabel('Frequency (MHz)')
ylabel('Log Mag (dB)')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gg1=reshape([0 g1x],20,6);   % 20 path filter for inner Analysis 20-to-1 Down Sample
reg_gg1=zeros(20,12);

gg2=reshape([0 g2x],20,6);   % 20 path filter for inner Synthesis 1-to-20 Up Sample
reg_gg2=zeros(20,12);%  
    
u0=zeros(1,10)';
u1=zeros(1,20)';
u2=zeros(1,20)';
u3=zeros(20,12);
v4=zeros(1,20)';
v5=zeros(1,20)';
v6=zeros(1,20)';
x2=zeros(1,600);

% q1=cos(2*pi*(0:19)*1/2)';
% q2=cos(2*pi*(0:19)*1/2)';

flg1=0;
flg2=0;
m1=1;
m2=0;

N_dat=600;
x0=[zeros(1,9) 1 zeros(1,N_dat-1)];

for nn=1:10:600-9         % ten inputs, per 20 outputs

       u0=fliplr(x0(nn:nn+9)).';
       
       reg_gg1=[[u0;u0] reg_gg1(:,1:11)];
       
      for kk=1:10    %compute 20 analysis filter outputs 
          p1=reg_gg1(kk,1:2:12)*gg1(kk,:)';
          p2=reg_gg1(kk+10,2:2:12)*gg1(kk+10,:)';
          u1(kk)=p1;
          u1(kk+10)=p2;
      end
      
      u2=20*ifft(u1);   
%          
    if flg1==0
        flg1=1;
        u2=u2;
    elseif flg1==1
        flg1=0;
         u2=-j*u2.*q1;
    elseif flg1==2
        flg1=3;
       u2=-u2;
    elseif flg1==3
        flg1=0;
        u2=+j*u2.*q1;
    end
    u3(:,m1)=u2;
    m1=m1+1;
%          
       
       v4(6:15)=u2(6:15);
         
         if flg2==0
            flg2=1;
            v4=v4;
            elseif flg2==1
            flg2=2;
            v4=-j*v4.*q2;
            elseif flg2==2
            flg2=3;
            v4=-v4;
            elseif flg2==3
            flg2=0;
            v4=+j*v4.*q2;
         end

           v5=10*ifft(v4);
    
    reg_gg2=[v5 reg_gg2(:,1:11)];
    for kk=1:10   % compute 10 synthesis filter outputs
    p1=reg_gg2(kk,1:2:12)*gg2(kk,:)';
    p2=reg_gg2(kk+10,2:2:12)*gg2(kk+10,:)';
    x2(m2+kk)=(p1+p2);
    end
    m2=m2+10;
end
q_sv=u3(1,:);
figure(3)
for k=1:20
    subplot(4,5,k)
    plot(0:12,real(u3(k,1:13)),'-o','linewidth',2)
    hold on
    plot(0:12,imag(u3(k,1:13)),'r-o','linewidth',2)
    hold off
    grid on
    axis([-1 13 -1.2 1.2])
    if k==2
        text(0,1.6,'Impulse Responses of 10-to-1 Down Sampld Channels in 20 Channel Analysis Filter','fontsize',14)
    end
        text(1,+0.8,['Ch(',num2str(k-11),')'],'fontsize',12)
    if rem(k,5)==1
        ylabel('Amplitude','fontsize',12)
    end
    if k>15
        xlabel('Time Index','fontsize',12)
    end
end

figure(4)
for k=1:20
    subplot(4,5,k)
    plot((-0.5:1/128:0.5-1/128)*2,(20*log10(abs(fft(u3(k,:)/2,128)))),'linewidth',2)
    grid on
    axis([-1 1 -60 10])
    if k==2
        text(0.0,20,'Frequency Responses of 10-to-1 Down sampled Channels of 20 Channel Analysis Filter','fontsize',14)
    end
    text(-0.5,-40,['Bin, Ch(',num2str(k-11),')'],'fontsize',12)
    if rem(k,5)==1
        ylabel('Log Mag (dB)','fontsize',12)
    end
    if k>15
        xlabel('Frequency (MHz)','fontsize',12)
    end
end
% 
figure(5)
subplot(3,1,1)
plot(0:239,real(x2(1:240)),'linewidth',2)
hold on
plot(0:239,imag(x2(1:240)),'r','linewidth',2)
hold off
grid on
axis([-10 250 -0.5 1.4])
title('Complex Impulse Response of 20 MHz Band Sampled at 20 MHz Translated to Baseband and Resampled to 160 MHz Sample Rate')
xlabel('Time Index')
ylabel('Amplitude')

subplot(3,1,2)
plot((-0.5:1/4096:0.5-1/4096)*20,(20*log10(abs(fft(x2(1:320),4096)))),'linewidth',2.5)
hold on
fu3=(20*log10(abs(fft(u3(1,1:13)/2,64))));
for k=1:5
plot((-0.5:1/64:0.5-1/64)*2+0.5+(k-1)*1,fu3,':r','linewidth',2)
plot((-0.5:1/64:0.5-1/64)*2-0.5-(k-1)*1,fu3,':r','linewidth',2)
end
hold off
grid on
axis([-10 10 -60 10])
title('Frequency Response of 40 MHz BW Synthesized from Eight 5-MHz Channels formed by a 40-Path Odd Indexed Polyphase Filter: Also Channelizer Single Channel Frequency Response')
xlabel('Frequency (MHz)')
ylabel('Log Magnitude (dB)')

subplot(3,2,5)
plot((-0.5:1/4096:0.5-1/4096)*20,(20*log10(abs(fft(x2(1:320),4096)))),'k','linewidth',2.5)
hold on
for k=1:5
plot((-0.5:1/64:0.5-1/64)*2+0.5+(k-1)*1,fu3,':r','linewidth',2)
plot((-0.5:1/64:0.5-1/64)*2-0.5-(k-1)*1,fu3,':r','linewidth',2)
end
hold off
grid on
axis([-6 6 -0.1 0.1])

subplot(3,2,6)
plot((-0.5:1/4096:0.5-1/4096)*20,(20*log10(abs(fft(x2(1:320)/2,4096)))),'linewidth',2.5)
hold on
plot([9.6 9.6],[-60 0],':','linewidth',2)
plot([10.4 10.4],[-60 0],':','linewidth',2)
hold off
grid on
axis([4 6 -60 10])


%%%%%%%%%%%%%%%%% tone burst test %%%%%%%%%%%%%%%%%%%%%
u0=zeros(1,10)';
u1=zeros(1,20)';
u2=zeros(1,20)';
u3=zeros(20,150);
v4=zeros(1,20)';
v5=zeros(1,20)';
v6=zeros(1,20)';
x2=zeros(1,1000);

q1=cos(2*pi*(0:19)*1/2)';
q2=cos(2*pi*(0:19)*1/2)';
reg_gg1=zeros(20,12);
reg_gg2=zeros(20,12);

flg1=0;
flg2=0;
m1=1;
m2=0;

N_dat=1200;
%x0=[zeros(1,19) 1 zeros(1,N_dat-1)];
x0=exp(-j*2*pi*(1:3000)*0/20);
for nn=1:10:3000

       u0=fliplr(x0(nn:nn+9)).';
       reg_gg1=[[u0;u0] reg_gg1(:,1:11)];
       
      for kk=1:10
          u1(kk)   =reg_gg1(kk,1:2:12)*gg1(kk,:)';
          u1(kk+10)=reg_gg1(kk+10,2:2:12)*gg1(kk+10,:)';
      end
             
     u2=20*ifft(u1);   
%          
    if flg1==0
        flg1=1;
        u2=u2;
    elseif flg1==1
        flg1=2;
         u2=-j*u2.*q1;
    elseif flg1==2
        flg1=3;
       u2=-u2;
    elseif flg1==3
        flg1=0;
        u2=+j*u2.*q1;
    end
    u2_x=fftshift(u2);
    u3(:,m1)=u2_x;
    m1=m1+1;
         
       v4(5:16)=u2_x(6:17);
         
         if flg2==0
            flg2=1;
            v4=v4;
            elseif flg2==1
            flg2=2;
            v4=-j*v4.*q2;
            elseif flg2==2
            flg2=3;
            v4=-v4;
            elseif flg2==3
            flg2=0;
            v4=+j*v4.*q2;
         end

           v5=10*ifft(fftshift(v4));
    
    reg_gg2=[v5 reg_gg2(:,1:11)];
    
    for kk=1:10
    p1=reg_gg2(kk,1:2:12)*gg2(kk,:)';
    p2=reg_gg2(kk+10,2:2:12)*gg2(kk+10,:)';
    x3(m2+kk)=(p1+p2);
    end
    m2=m2+10;
end

figure(6)
for k=1:20
    subplot(4,5,k)
    plot(0:50,real(u3(k,1:51)/10),'-','linewidth',2)
    hold on
    plot(0:50,imag(u3(k,1:51)/10),'r-','linewidth',2)
    hold off
    grid on
    axis([-1 51 -1.2 1.2])
    text(5,-0.7,['Ch(',num2str(k-11),')'],'fontsize',12)
    if rem(k,5)==1
        ylabel('Amplitude','fontsize',12)
    end
    if k>15
        xlabel('Time Index','fontsize',12)
    end
end

figure(7)
w1=kaiser(128,6)';
w1=w1/sum(w1);
for k=1:20
    subplot(4,5,k)
    plot((-0.5:1/128:0.5-1/128)*20,(20*log10(abs(fft(u3(k,21:148).*w1,128)))),'linewidth',2)
    grid on
    axis([-10 10 -60 10])
    text(-8,-50,['Ch(',num2str(k-11),')'],'fontsize',12)
    if rem(k,5)==1
        ylabel('Log Mag (dB)','fontsize',12)
    end
    if k>15
        xlabel('Freq (MHz)','fontsize',12)
    end
end

figure(8)
subplot(4,1,1)
plot(0:999,real(x0(1:1000)),'linewidth',2)
hold on
plot(0:999,imag(x0(1:1000)),'r','linewidth',2)
hold off
grid on
axis([0 1000 -1.2 1.2])
title('Complex Impulse Response of 20 MHz Band Sampled at 20 MHz Translated to Baseband and Resampled to 160 MHz Sample Rate')
xlabel('Time Index')
ylabel('Amplitude')

subplot(4,1,2)
plot(0:999,real(x3(1:1000)),'linewidth',2)
hold on
plot(0:999,imag(x3(1:1000)),'r','linewidth',2)
hold off
grid on
axis([0 1000 -1.2 1.2])
title('Complex Impulse Response of 20 MHz Band Sampled at 20 MHz Translated to Baseband and Resampled to 160 MHz Sample Rate')
xlabel('Time Index')
ylabel('Amplitude')


subplot(4,1,3)
ww=kaiser(1024,6)';
ww=ww/sum(ww);
plot((-0.5:1/4096:0.5-1/4096)*20,fftshift(20*log10(abs(fft(x0(201:1224).*ww,4096)))),'linewidth',2.5)
hold on
fv3=(20*log10(abs(fft(q_sv/2,64))));
for k=1:6
plot((-0.5:1/64:0.5-1/64)*2+0.5+(k-1),fv3,':r','linewidth',2)
plot((-0.5:1/64:0.5-1/64)*2-0.5-(k-1),fv3,':r','linewidth',2)
end
hold off
grid on
axis([-15 15 -50 10])
title('Frequency Response of 40 MHz BW Synthesized from Eight 5-MHz Channels formed by a 40-Path Odd Indexed Polyphase Filter: Also Channelizer Single Channel Frequency Response')
xlabel('Frequency (MHz)')
ylabel('Log Magnitude (dB)')

subplot(4,1,4)
ww=kaiser(1024,6)';
ww=ww/sum(ww);
plot((-0.5:1/4096:0.5-1/4096)*20,fftshift(20*log10(abs(fft(x3(201:1224).*ww,4096)))),'linewidth',2.5)
hold on
fv3=(20*log10(abs(fft(q_sv/2,64))));
for k=1:6
plot((-0.5:1/64:0.5-1/64)*2+0.5+(k-1),fv3,':r','linewidth',2)
plot((-0.5:1/64:0.5-1/64)*2-0.5-(k-1),fv3,':r','linewidth',2)
end
hold off
grid on
axis([-15 15 -50 10])
title('Frequency Response of 40 MHz BW Synthesized from Eight 5-MHz Channels formed by a 40-Path Odd Indexed Polyphase Filter: Also Channelizer Single Channel Frequency Response')
xlabel('Frequency (MHz)')
ylabel('Log Magnitude (dB)')
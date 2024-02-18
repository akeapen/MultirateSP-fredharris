% function FFT_train 
% generates the FFT of a train engine, Animated humour
% Script file written by fred harris of UCSD, Copyright 2021.

x=[zeros(1,20) 2*ones(1,30) ones(1,30) 1.5*ones(1,5) ones(1,10) (1:-.1:0) zeros(1,20)];
xx=[x zeros(size(x))];

figure(1)
subplot(2,1,1);
plot(0:251,xx,'linewidth',2);
axis([0 251 -.5 2.5]);
grid on
title('TRAIN','fontsize',14);
xlabel('Time','fontsize',14);
ylabel('Amplitude','fontsize',14);

fxx=fft(xx)/252;
subplot(2,1,2);
plot(0:125,10*log10(abs(fxx(1:126))),'ro','linewidth',2);
title('Log Magnitude of Spectral Components in Train','fontsize',14);
axis([0 125 -30 0]);
grid on
xlabel('Frequency, (Cycles per Interval)','fontsize',14);
ylabel('Log Magnitude','fontsize',14);
pause


yn=zeros(1,252);
ffx=zeros(1,252);
cc=0:251;

for nn=1:126
subplot(2,1,1)
plot(0:251,xx,'r--','linewidth',2)
hold on
plot(0:251, real(yn),'linewidth',2)
hold off
axis([0 251 -.5 2.5]);
grid on
title('Building a Train as a Sum of Sinusoidal Components','fontsize',14);
xlabel('Time','fontsize',14);
ylabel('Amplitude','fontsize',14); 

subplot(2,1,2);
plot(0:125,10*log10(ffx(1:126)),'r o','linewidth',2);
axis([0 125 -30 0]);
grid on
title('Spectral Components Used to Build Train','fontsize',14);
xlabel('Frequency','fontsize',14);
ylabel('Log Magnitude','fontsize',14);
 
  scl=2;
    if nn==1
        scl=1;
    end
    
yn=yn+fxx(nn)*scl*exp(j*(2*pi*cc*(nn-1)/252));
ffx(nn)=ffx(nn)+abs(fxx(nn));	
pause(0.1)
end

qq1=exp(j*2*pi*(0:0.01:1));
qq2=5*real(qq1)+j*imag(qq1)/5;
pause(1)
subplot(2,1,1)
for nn=1:252
    yn=[yn(252) yn(1:251)];
    plot(0:251, real(yn),'linewidth',2)
    axis([0 251 -.5 2.5]);
    grid on
    title('Moving a Train as a Sum of Sinusoidal Components','fontsize',14);
    xlabel('Time','fontsize',14);
    ylabel('Amplitude','fontsize',14); 

   pause(.01);
end;


qq1=exp(j*2*pi*(0:0.01:1));
qq2=5*real(qq1)+j*imag(qq1)/5;
pause(2)
subplot(2,1,1)
mm=80;
for nn=1:252
    yn=[yn(252) yn(1:251)];
    plot(0:251, real(yn),'linewidth',2)
    hold on
    
        plot(0.5*qq2+rem(85+mm,252)+j*1.8,'k','linewidth',2) 
        plot(0.7*qq2+rem(70+mm,252)+j*2.0,'k','linewidth',2) 
        plot(0.9*qq2+rem(55+mm,252)+j*2.2,'k','linewidth',2)
        plot(qq2+rem(35+mm,252)+j*2.4,'k','linewidth',2) 
    if rem(nn,7)==1
        mm=nn;
    end
    hold off
    axis([0 251 -.5 2.5]);
    grid on
    title('Moving a Smoking Train as a Sum of Sinusoidal Components','fontsize',14);
    xlabel('Time','fontsize',14);
    ylabel('Amplitude','fontsize',14); 

   pause(.01);
end;

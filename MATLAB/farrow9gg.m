%function farrow9gg
%1-to-13 upsampling with 4-th order taylor series
figure(1)
clf
nn=159;nnp=nn+1;
hh=remez(nn,[0 .6 3.4 64]/64,[1 1 0 0],[1 4]);
plot(0:nn,hh/hh(nnp/2),'linewidth',2.0);grid on;axis([-2 nn+2 -.2 1.1]);
title('Impulse Response; Filter Waveform of Interpolator')
xlabel('Time Index')
ylabel('Amplitude')
text(135,0.1,'Note Outlier Sample','fontsize',14)
%pause
figure(2)
fhh=20*log10(fftshift(abs(fft(hh,1024))));
plot(-0.5:1/1024:0.5-1/1024,fhh,'linewidth',1.5);grid on; axis([-0.5 0.5 -90 10])
title('Frequency Response; Suppresses Spectral Replicates')
xlabel('Frequency')
ylabel('Log Mag (dB)')
text(0.05,-58,' Note Constant','fontsize',14)
text(0.05,-63,'Level Sidelobes','fontsize',14)

%pause
ax1=axis;ax2=ax1;
ax1(1)=-.1;ax1(2)=.1;axis(ax1);
title('Zoom to Main Lobe Frequency Response; Spectrum to be Resampled')

%pause

figure(3)
stem(0:31,hh(1:32)/hh(nnp/2),'linewidth',2);grid on;axis([-1 32 -0.09 0.01])
title('Impulse Response, First 32 Samples, First Column in Polyphase Filter')
xlabel('Time Index')
ylabel('Amplitude')
text(0,-0.01,'Note Outlier Sample','fontsize',14)

%pause
figure(4)
hhh=hh;
d1=hh(2);d2=hh(3);
hhh(1)=d1-(d2-d1);
hhh(nnp)=hhh(1);

fhh=20*log10(fftshift(abs(fft(hhh,1024))));
plot(-0.5:1/1024:0.5-1/1024,fhh,'linewidth',2);grid;axis(ax2);
title('Frequency Response with Shaved First Sample')
xlabel('Frequency')
ylabel('Log Mag (dB)')
text(0.05,-55,'Note 1/f Decay','fontsize',14)
text(0.05,-63,'Sidelobes Level','fontsize',14)
axis(ax1);
%pause;


hhh=hhh/hhh(nnp/2);
vv=reshape(hhh,32,5);
p1=polyfit(0:1/32:31/32,vv(:,1)',4);
q1=polyfit(0:1/32:31/32,fliplr(vv(:,1)'),4);
%pause

figure(5)
t1=polyval(p1,0:1/32:31/32);
u1=polyval(q1,fliplr(0:1/32:31/32));
stem(0:1/32:31/32,vv(:,1)','b','linewidth',2);
hold on; grid on;axis([-0.01 1 -0.09 0.01])
plot(0:1/32:31/32,t1,'r','linewidth',2)
title('Weights and Polynomial fit for h_n(1:32)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

plot(0:1/32:31/32,u1,'g','linewidth',2)
title('Weights and Polynomial fit for Time Reversed h_n(1:32)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

figure(6)
plot(0:1/32:31/32,t1-vv(:,1)','linewidth',2);
grid on
axis([-0.01 1 -0.0004 0.0004])
title('Error for Polynomial fit; h_n(1:32)') 
xlabel('Time Index')
ylabel('Amplitude')

%pause
plot(0:1/32:31/32,u1-vv(:,1)','r','linewidth',2)
grid on
axis([-0.01 1 -0.0004 0.0004])
title('Error for Polynomial fit; Time Reversed h_n(1:32)') 
xlabel('Time Index')
ylabel('Amplitude')

%pause
figure(7)
p2=polyfit(0:1/32:31/32,vv(:,2)',4);
t2=polyval(p2,0:1/32:31/32);
stem(0:1/32:31/32,vv(:,2)','linewidth',2);
hold on
plot(0:1/32:31/32,t2,'r','linewidth',2)
hold off
title('Weights and Polynomial fit for h_n(33:64)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

figure(8)
plot(0:1/32:31/32,t2-vv(:,2)','linewidth',2)
grid on
axis([-0.01 1 -0.0004 0.0004])
title('Error for Polynomial fit; h_n(33:64)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

p3=polyfit(0:1/32:31/32,vv(:,3)',4);
t3=polyval(p3,0:1/32:31/32);
figure(9)
stem(0:1/32:31/32,vv(:,3)','linewidth',2);
hold on
plot(0:1/32:31/32,t3,'r','linewidth',2)
hold off
grid on
axis([-0.03 1 0 1.0])
title('Weights and Polynomial fit for h_n(65:96)') 
xlabel('Time Index')
ylabel('Amplitude')

%pause
figure(10)
plot(0:1/32:31/32,t3-vv(:,3)','linewidth',2)
grid on
axis([-0.01 1 -0.0004 0.0004])
title('Error for Polynomial fit; h_n(65:96)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

p4=polyfit(0:1/32:31/32,vv(:,4)',4);
t4=polyval(p4,0:1/32:31/32);
figure(11)
stem(0:1/32:31/32,vv(:,4)','linewidth',2);
hold on
plot(0:1/32:31/32,t4,'r','linewidth',2)
hold off
grid on
axis([-0.03 1.0 -0.15 0.7])
title('Weights and Polynomial fit for h_n(97:128)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

figure(12)
plot(0:1/32:31/32,t4-vv(:,4)','linewidth',2)
grid on
axis([-0.01 1 -0.0004 0.0004])
title('Error for Polynomial fit; h_n(97:128)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

p5=polyfit(0:1/32:31/32,vv(:,5)',4);
t5=polyval(p5,0:1/32:31/32);
figure(13)
stem(0:1/32:31/32,vv(:,5)','linewidth',2);
hold on
plot(0:1/32:31/32,t5,'r','linewidth',2)
hold off
grid on
axis([-0.03 1.0 -0.09 0.01])
title('Weights and Polynomial fit for h_n(129:160)') 
xlabel('Time Index')
ylabel('Amplitude')
%pause

figure(14)
plot(0:1/32:31/32,t5-vv(:,5)','linewidth',2)
grid on
axis([-.03 1.0 -0.0004 0.0004])
title('Error for Polynomial fit; h_n(129:160)')
xlabel('Time Index')
ylabel('Amplitude')
%pause

pp=[p1;p2;p3;p4;p5];
figure(15)
subplot(2,3,1);stem(0:4,p1,'linewidth',2);grid on;axis([-1 5 -0.5 0.5]);title('p0');
subplot(2,3,2);stem(0:4,p2,'linewidth',2);grid on;axis([-1 5 -1.0 2.0]);title('p1');
subplot(2,3,3);stem(0:4,p3,'linewidth',2);grid on;axis([-1 5 -3.0 2.0]);title('p2');
subplot(2,3,4);stem(0:4,p4,'linewidth',2);grid on;axis([-1 5 -2.0 2.5]);title('p3');
subplot(2,3,5);stem(0:4,p5,'linewidth',2);grid on;axis([-1 5 -1.0 1.0]);title('p4');
text(9,0.3,'Column')
text(7,0,'Polynomial Coefficients')
text(8,-0.3,'(c_0,c_1,c_2,c_3,c_4)')

%pause
figure(16)
subplot(2,3,1);stem(pp(:,1),'linewidth',2);grid on;axis([-1 6 -1.5 1.5]);title('a4');
subplot(2,3,2);stem(pp(:,2),'linewidth',2);grid on;axis([-1 6 -2.5 2.5]);title('a3');
subplot(2,3,3);stem(pp(:,3),'linewidth',2);grid;axis([-1 6 -0.5 0.5]);title('a2');
subplot(2,3,4);stem(pp(:,4),'linewidth',2);grid;axis([-1 6 -2.0 2.0]);title('a1');
subplot(2,3,5);stem(pp(:,5),'linewidth',2);grid;axis([-1 6 -0.5 1.0]);title('a0');
text(8,0.8,'Row, Farrow Filter')
text(7,0.4,'Polynomial Coefficients')
text(8,0.0,'(a_4,a_3,a_2,a_1,a_0)')

%pause

ff=[-.5:1/64:.5-1/64];
figure(17)
subplot(2,3,1);plot(ff,fftshift(abs(fft(pp(:,1),64))),'linewidth',2);grid on;title('Spectrum, f_a4');
subplot(2,3,2);plot(ff,fftshift(abs(fft(pp(:,2),64))),'linewidth',2);grid on;title('Spectrum, f_a3');
subplot(2,3,3);plot(ff,fftshift(abs(fft(pp(:,3),64))),'linewidth',2);grid on;title('Spectrum, f_a2');
subplot(2,3,4);plot(ff,fftshift(abs(fft(pp(:,4),64))),'linewidth',2);grid on;title('Spectrum, f_a1');
subplot(2,3,5);plot(ff,fftshift(abs(fft(pp(:,5),64))),'linewidth',2);grid on;title('Spectrum, f_a0');
text(0.85,1.3,'Spectra')
text(0.8,1.0,'Farrow Row')
text(0.8,0.7,'Coefficients')

figure(18)
y=0.8*sin(2*pi*(0:99)*12.5/100);
y=zeros(1,100);
y(1)=1;
zz=zeros(1,5);
yy=[zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz;zz];
size(yy);
ww=zeros(1,5);
for m=1:100
ww(2:5)=ww(1:4);
ww(1)=y(m);
bb=pp'*ww';
yy(1,m)=polyval(bb,0/13);
yy(2,m)=polyval(bb,1/13);
yy(3,m)=polyval(bb,2/13);
yy(4,m)=polyval(bb,3/13);
yy(5,m)=polyval(bb,4/13);
yy(6,m)=polyval(bb,5/13);
yy(7,m)=polyval(bb,6/13);
yy(8,m)=polyval(bb,7/13);
yy(9,m)=polyval(bb,8/13);
yy(10,m)=polyval(bb,9/13);
yy(11,m)=polyval(bb,10/13);
yy(12,m)=polyval(bb,11/13);
yy(13,m)=polyval(bb,12/13);
end
size(yy);
yyy=reshape(yy,1,1300);
yt=yyy(1:70);
stem(yyy(1:70),'linewidth',2);
grid on
axis([-5 75 -0.2 1.2])
title('Impulse Response, Farrow filter for \deltan = 0, 1/13, 2/13,..., 12/13')
xlabel('Time Index')
ylabel('Amplitude')
%pause

figure(19)
yt=yt/sum(yt);
fyt=20*log10(fftshift(abs(fft(yt,512))));
plot((-.5:1/512:.5-1/512)*1,fyt,'r','linewidth',3)
axis([-.5 .5 -80 10])
hold on
plot((-.5:1/1024:.5-1/1024)*2.5,fhh,':b','linewidth',3)
hold off
grid on
axis([-0.5 0.5 -80 10])
title('Spectra; Original Prototype Low-Pass Filter (Blue), of Impulse Response of Farrow Filter Obtained from Farrow Row Coefficients')
xlabel('Frequency')
ylabel('Log Mag (dB)')


function fredfil3(a0)
%function fredfil3(a0),
% all-pass filter design called by polyz3 
% Forms [(z+a0)(z+a0)]/[(1+a0Z)(1+a0Z)] and delays smooth pulse
% Script file written by fred harris of UCSD, Copyright 2021.

aa1=conv([1  a0],[1 a0]);
%aa1=conv(aa1,aa1);
bb1=fliplr(aa1);

[h1,w]=freqz(bb1,aa1,200);
phi1=unwrap(angle(h1))*180/pi;
subplot(3,1,1);
plot(w/(2*pi),phi1,'linewidth',2);
grid on;
axis([0 .5 -360 0]);
ylabel('Phase Shift');

subplot(3,1,3); 
zd=zeros(1,20);zd(2:8)=hanning(7)';
dd=filter(bb1,aa1,zd);
zdi=0:.25:19;yi=interp1(0:19,dd,zdi,'cubic');
fyi=log10(abs(fft(zd,400)));fyi=1+(fyi-max(fyi))/2;
stem(0:19,dd,'linewidth',2);
hold on;
plot(zdi,yi,'r','linewidth',2);
hold off
grid on;
axis([0 20 -.2 1.2]);
ylabel('S(n) & S(t)')

subplot(3,1,2);
gd=(200/pi)*conv([-1 1],unwrap(angle(h1)));
id=find(gd<0);
gd(id)=gd(id-1);
plot(w/(2*pi),gd(1:200),'linewidth',2);
hold;
plot(w/(2*pi),fyi(1:200),'r','linewidth',2);hold;
grid on;
axis([0 .5 0 2]);

ylabel('Delay & |S(w)|');


function tony_des_2(action)
% tony_des_2 forms coefficients of two path recursive polyphase filter
% filter can be halfband quadrature mirror, polynomials in Z^2 
% filter can be bandwidth tuned,        Z^-1 => (1-b*z)/(z-b),       b=(1-tan(bw))/(1+tan(bw))
% filter can be center frequency tuned, z^-1 => (-1/z)*(1-cz)/(z-c), c=cos(theta_c)
% filter can be zero-packed             Z^-1 ->  z^-k,               k even      
% order of filter is odd (3,5,7.....) 
% wo is normalized band edge frequency .5>wo>.25 
%
% %%%%%%%%% this program calls tonycxx.m %%%%%%%%%%%%%
%
% based on paper "Digital Signal Processing Schemes for Efficient Interpolation and Decimation"
% by Valenzuela and Constantinides, IEE Proceedings, Dec 1983
% Script file written by fred harris of UCSD. Copyright 2021


global N_
global ws_
global wb_
global wc_
global kk_
if nargin<1

figure(1)
clf reset
set(1,'name','                Two-Path Allpass Filter Design by fred harris, UCSD','numbertitle','off');

responseplot=axes('units','normalized','position',[.05 .4 .9 .55]);

N_=uicontrol('style','edit','units','normalized','position',[0.18 0.1 0.07 0.07],'string','5');
Ntext=uicontrol('style','text','units','normalized','position',[0.04 0.1 0.13 0.065],'string','Prototype Order (Odd)');

ws_=uicontrol('style','edit','units','normalized','position',[0.18 0.17 0.07 0.07],'string','0.300');
wstext=uicontrol('style','text','units','normalized','position',[0.04 0.17 0.13 0.065],'string','Stopband Edge (0.25-0.5)');

wb_=uicontrol('style','edit','units','normalized','position',[0.42 0.17 0.07 0.07],'string','0.250');
wbtext=uicontrol('style','text','units','normalized','position',[0.28 0.17 0.13 0.065],'string','Passband Edge');

wc_=uicontrol('style','edit','units','normalized','position',[0.66 0.17 0.07 0.07],'string','0.000');
wctext=uicontrol('style','text','units','normalized','position',[0.52 0.17 0.13 0.065],'string','Center Frequency');

kk_=uicontrol('style','edit','units','normalized','position',[0.90 0.17 0.07 0.07],'string','2');
wctext=uicontrol('style','text','units','normalized','position',[0.76 0.17 0.13 0.065],'string','Order (even)');

half_=uicontrol('style','push','units','normalized','position',[0.04 0.25 0.21 0.07],'string','Half-Band Low-Pass','callback','tony_des_2(''start1'')');

tlow_=uicontrol('style','push','units','normalized','position',[0.28 0.25 0.21 0.07],'string','Tune Bandwidth','callback','tony_des_2(''start1'')');

tband_=uicontrol('style','push','units','normalized','position',[0.52 0.25 0.21 0.07],'string','Tune Center Freq','callback','tony_des_2(''start1'')');

fordr_=uicontrol('style','push','units','normalized','position',[0.76 0.25 0.21 0.07],'string','Polynomial Degree','callback','tony_des_2(''start1'')');



tprint=uicontrol('style','push','units','normalized','position',[0.30 0.1 0.65 0.05],'string','Print Coefficients','callback','tony_des_2(''start2'')');

readtext=uicontrol('style','text','units','normalized','position',[0.280 0.03 0.65 0.05],'string','(Highlight Parameter Value, Enter Desired Value, Depress Button)');
action='start1';
end

if strcmp(action,'start1')
   coef=0;
end
if strcmp(action,'start2')
   coef=1;
end

      N=str2num(get(N_,'string'));
   if rem(N,2)~=1
      N=N+1;
      N_=uicontrol('style','edit','units','normalized','position',[0.18 0.1 0.07 0.07],'string',N);
   end
   ws=str2num(get(ws_,'string'));
   if ws<0.25 
      ws=0.300;
      ws_=uicontrol('style','edit','units','normalized','position',[0.18 0.17 0.07 0.07],'string',ws);
   end
   if ws>0.5 
      ws=0.300;
      ws_=uicontrol('style','edit','units','normalized','position',[0.18 0.17 0.07 0.07],'string',ws);
   end
   wb=str2num(get(wb_,'string'));
   if wb>0.5
      wb=0.25;
      wb_=uicontrol('style','edit','units','normalized','position',[0.42 0.17 0.07 0.07],'string','0.250');
   end
   wc=str2num(get(wc_,'string'));
   if wc>0.5
      wc=0.0;
      wc_=uicontrol('style','edit','units','normalized','position',[0.66 0.17 0.07 0.07],'string','0.000');
   end 
   
   kk=str2num(get(kk_,'string'));
   if rem(kk,2)~=0;
      kk=2;
      kk_=uicontrol('style','edit','units','normalized','position',[0.90 0.17 0.07 0.07],'string','2');
   end 

   if wb==0.25 & wc==0
      mode=1;
   else 
      mode=2;
   end
   
   aa=1;
   if wc==0;
      aa=-aa;
   end
   
[rts1,rts2,coef0,coef1,ff1,ff2]=tonycxx(N,ws,wb,wc,kk,mode);

figure(2)
plot(roots(rts1),'bx','linewidth',2,'markersize',9);
hold on;
plot(roots(rts2),'bx','linewidth',2,'markersize',9);
plot(roots(conv(rts1,fliplr(rts2))-aa*conv(fliplr(rts1),rts2)),'ro','linewidth',2,'markersize',9)
plot(exp(j*2*pi*[0:.01:1]),':r','linewidth',2);
plot([-1.2 1.2],[0 0],'k','linewidth',1)
plot([0 0],[-1.2 1.2],'k','linewidth',1)

hold off;
grid
axis([-1.2 1.2 -1.2 1.2]);
axis('square')
title('Roots of Two-Path Filter (Sum of Paths)')

figure(1)
plot(0:1/1024:.5-1/1024,20*log10(abs(ff1+0.0000001)),'b','linewidth',1.5);
hold
plot(0:1/1024:.5-1/1024,20*log10(abs(ff2+0.0000001)),'r','linewidth',1.5);
axis([0 .5 -100 10]);

hold

grid;
title('Magnitude Response of Two Path Filter');
xlabel('Normalized Frequency (f/fs)');
ylabel('Log Magnitude (dB)');

% write out coefficients
format long
if coef==1
    disp(' ')
    disp('Denominator Polynomials, path-0') 
        if wc==0
        disp('   (a0 Z^2  +  a1 Z^1  +  a2)')
        else
        disp('   (a0 Z^4  +  a1 Z^3  +  a2 Z^2  +  a3 Z^1  +  a4)') 
end
   disp(' ')
   disp(coef0)
   disp(' ')
   
    disp('Denominator Polynomials, path-1') 
    if wc==0
    disp('    (b0 Z^2  +  b1 Z^1  +  b2)')
    else
    disp('    (b0 Z^4  +  b1 Z^3  +  b2 Z^2  +  b3 Z^1  +  b4)') 
end
   disp(' ')   
   disp(coef1)
end

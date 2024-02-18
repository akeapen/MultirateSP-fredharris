% timing recovery with 32 matched filters Each with offset between peak and
% clock sample positions:

% Script file written by fred harris of UCSD. Copyright 2021

% modulator shaping filter, 8-samples per symbol, when down sampled to 
% 2-samples/symbol can include timing offset for timing loop to resolve
h=rcosine(1,8,'sqrt',0.5,6);    % 97 taps, 
h=h/max(h);                    

% demodulator matched filter, partioned to 32 different time offsts
g=rcosine(1,64,'sqrt',0.5,6);   % 769 Taps
g=g/(h(1:4:97)*g(1:32:769)');

dgx=conv(g,[1 0 -1]*64/2);   % derivative filter to form y-dot 
dg=dgx(2:770);

h2=reshape(h(1:96),8,12);    
g2=reshape(g(1:768),32,24);    % polyphase matched filter
dg2=reshape(dg(1:768),32,24);  % polyphase derivative matched filter


figure(1)
subplot(2,1,1)
plot(-6:1/8:6,h,'b','linewidth',1.5)            
grid on
axis([-7 7 -0.3 1.2])
title('Impulse Response, Shaping Filter, 8-Samples per Symbol')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot((-0.5:1/1024:0.5-1/1024)*8,fftshift(20*log10(abs(fft(h/sum(h),1024)))),'b','linewidth',1.5)
grid on
axis([-4 4 -80 10])
title('Frequency Response')
xlabel('Frequency')
ylabel('Log Mag (dB)')

figure(2)
subplot(2,1,1)
plot(-6:1/64:6,g/max(g),'b','linewidth',1.5)
grid on
axis([-7 7 -0.3 1.2])
title('Impulse Response, Prototype Matched Filter, 64-Samples per Symbol')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
plot((-0.5:1/4096:0.5-1/4096)*64,fftshift(20*log10(abs(fft(g/sum(g),4096)))),'b','linewidth',1.5)
grid on
axis([-4 4 -80 10])
title('Frequency Response')
xlabel('Frequency')
ylabel('Log Mag (dB)')

figure(3)
subplot(2,1,1)
plot(-6:1/64:6,dg,'b','linewidth',2)
grid on
axis([-7 7 -1.23 1.2])
title('Impulse Response, Prototype Derivative Matched Filter, 64-Samples per Symbol')
xlabel('Time Index')
ylabel('Amplitude')

subplot(2,1,2)
f_dg=zeros(1,4096);
f_dg(2049+(-384:384))=dg/65;
f_dg=fftshift(fft(fftshift(f_dg)));
plot((-0.5:1/4096:0.5-1/4096)*64,imag(f_dg),'b','linewidth',2)
grid on
axis([-4 4 -2 2])
title('Frequency Response, (Band Liited Derivative)')
xlabel('Frequency')
ylabel('Amplitude')

N_dat=4000;
x0=(floor(2*rand(1,N_dat))-0.5)/0.5 + j*(floor(2*rand(1,N_dat))-0.5)/0.5; 

reg=zeros(1,12);
x1=zeros(1,N_dat*8);
m=1;
for n=1:N_dat
    reg=[x0(n) reg(1:11)];
    for k=1:8
        x1(m)=reg*h2(k,:)';
        m=m+1;
    end
end

x2=x1(2:4:N_dat*8);
figure(4)
for k=1:32
    y=conv(x2,g2(k,:));
  subplot(4,8,k)
  plot(y(2:2:N_dat*2),'rx')
  grid on
  axis([-2 2 -2 2])
  text(-0.9,2.4,['filter(',num2str(k),')'],'fontsize',14)
end
subplot(4,8,2)
text(-0.5,+3.2,'Constellation Diagrams From Successive Polyphase Matched Filters, Loop has to Identify Correct one (filter-25)','fontsize',14)

figure(5)
for k=1:32
     y=conv(x2, g2(k,:));
    dy=conv(x2,dg2(k,:));
    yy=real(y(2:2:N_dat)).*real(dy(2:2:N_dat));
    yy_av=filter(0.005,[1 -0.995],yy);
  subplot(4,8,k)
  plot(yy,'b.')
  hold on
   plot(4*yy_av,'r','linewidth',3)
  hold off
  grid on
  text(100,2.6,['filter(',num2str(k),')'],'fontsize',14)
  if rem(k,8)==1;
      ylabel('Amplitude','fontsize',12)
  end
  if k>=25
      xlabel('Time Index','fontsize',12)
  end
  axis([0 1000 -2.2 2.2])
end
subplot(4,8,1)
text(0,3.5,'y y_d_o_t Prod (Blue) and 4 Times Avg of Prod (Red) from Successive Matched Filters: if avg prod > 0 move to later filter if avg prod < 0 move to earlier filter ','fontsize',14)

%%%%%%%%%%%%%%% timing recovery loop %%%%%%%%%%%%%%%
g=rcosine(1,64,'sqrt',0.5,6);   % 769 Taps
g=g/(h(1:4:97)*g(1:32:769)');

dgx=conv(g,[1 0 -1]*64/2);
dg=dgx(2:770);

h2=reshape(h(1:96),8,12);
g2=reshape(g(1:768),32,24);
dg2=reshape(dg(1:768),32,24);
accum=15;  % output phase accumulator
int=0;     % Integrator in loop filter
reg=zeros(1,24);

theta_0=2*pi/400;         % change BW Here, try 2*pi/100 and 2*pi/200 then 2*pi/400 
eta=sqrt(2)/2;
eta=4*eta;
k_i= (4*theta_0*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);
k_p= (4*eta*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);
m=1;
for n=1:2:N_dat*2-2
    reg=[x2(n) reg(1:23)];
    pntr=floor(accum);
    pntr_sv(m)=pntr;
    y2(n)=reg*g2(pntr,:)';
    dy2(n)=reg*dg2(pntr,:)';
    
    reg=[x2(n+1) reg(1:23)];
    y2(n+1)=reg*g2(pntr,:)';
    dy2(n+1)=reg*dg2(pntr,:)';
    
    y_det(m)=real(y2(n+1))*real(dy2(n+1));
    int=int+y_det(m)*k_i;
    fltr(m)=int+y_det(m)*k_p;
    
    accum_sv(m)=accum;
    accum=accum+fltr(m);
    if accum>=33
        accum=accum-1;
    end
    m=m+1;
end

figure(6)
subplot(4,1,1)
plot(accum_sv,'b','linewidth',1.5)
hold on
plot(floor(accum_sv),'r','linewidth',1.5)
hold off
grid on
title('Phase Accumulator and Polyphase Pointer','fontsize',14)
xlabel('Time Index','fontsize',12)
ylabel('Amplitude','fontsize',12)

fltr_avg=filter([0.5],[1 -0.95],fltr);
subplot(4,1,2)
plot(fltr,'b','linewidth',1.0)
hold on
plot(fltr_avg,'r','linewidth',1.0)

hold off
grid on
title('Loop Filter Output and 10 times Running Average, Input to Phase accumulator','fontsize',14)
xlabel('Time Index','fontsize',12)
ylabel('Amplitude','fontsize',12)

subplot(2,3,4)
plot(y2(2:2:N_dat),'bx')
hold on
plot(y2(2+N_dat/2:2:N_dat),'rx')
hold off
grid on
axis('equal')
axis([-1.5 1.5 -1.5 1.5])
title('Constellation Diagram During Timing Acquisition','fontsize',14)

subplot(2,3,5)
plot(0,0)
hold on
for n=2+48:4:N_dat-4
    plot(-1:1/2:1,real(y2(n:n+4)))
end
hold off
grid on
title('Eye Diagram During Acquisition','fontsize',14)
xlabel('Time Index','fontsize',12)
ylabel('Amplitude','fontsize',12)

subplot(2,3,6)
plot(0,0)
hold on
for n=2+N_dat/2:4:N_dat-4
    plot(-1:1/2:1,real(y2(n:n+4)),'r')
end
hold off
grid on
title('Eye Diagram After Acquisition','fontsize',14)
xlabel('Time Index','fontsize',12)
ylabel('Amplitude','fontsize',12)

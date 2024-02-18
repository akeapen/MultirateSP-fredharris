function filter_ten_a_call(freq,flag1,flag2)
% Script file called by filter_ten_a to animate 
% time and spectral representation of input and output of 
% 10-channel channelizers.
% Script file written by fred harris of UCSD. Copyright 2021

if flag1==1
    n_dat=1200;
xx= exp(j*2*pi*(0:n_dat-1)*freq);
ww1=kaiser(100,6)';
ww1=ww1/sum(ww1);
nn_dat=100;


else
    n_dat=10000;
    frq=[0:1/2500:1 1-1/2500:-1/2500:-1 -1+1/2500:1/2500:-1/2500];
    phs=filter([1 0],[1 -1],frq);
    xx=exp(j*2*pi*phs*0.45);

ww1=kaiser(100,6)';
ww1=ww1/sum(ww1);
nn_dat=12;
end

if flag2==1
    
    subplot(6,2,1)
    plt0=plot(0:99,real(xx(1:100)),'linewidth',1.5);
    grid
    axis([0 100 -1.1 1.1])
    title('Input Time Series')
    
    mm=0;
    txt=text(105,0.0,['Sample # ',num2str(mm,3)]);

   
    subplot(6,2,3)
    plt1=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1])
    text(10.6, 0.3, 'bin(-1)')
     text(10.2, -0.3, '-0.15 -0.05')
     
    subplot(6,2,4)
    plt2=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1])
    text(10.6, 0.3, 'bin(0)')
     text(10.2, -0.3, '-0.05 +0.05')
     
    subplot(6,2,5)
    plt3=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1]) 
     text(10.6, 0.3, 'bin(-2)')
      text(10.2, -0.3, '-0.25 -0.15')
     
    subplot(6,2,6)
    plt4=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1])
     text(10.6, 0.3, 'bin(+1)')
      text(10.2, -0.3, '+0.05 +0.15')
     
    subplot(6,2,7)
    plt5=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1])
     text(10.6, 0.3, 'bin(-3)')
      text(10.2, -0.3, '-0.35 -0.25')
    
    subplot(6,2,8)
    plt6=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1]) 
     text(10.6, 0.3, 'bin(+2)')
      text(10.2, -0.3, '+0.15 +0.25')
     
    subplot(6,2,9)
    plt7=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1]) 
     text(10.6, 0.3, 'bin(-4)')
     text(10.2, -0.3, '-0.45 -0.35')
     
    subplot(6,2,10)
    plt8=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1])
     text(10.6, 0.3, 'bin(+3)')
     text(10.2, -0.3, '+0.25 +0.35')
     
     subplot(6,2,11)
    plt9=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1])
     text(10.6, 0.3, 'bin(-5)')
      text(10.2, -0.3, '-0.45 +0.45')
    
    subplot(6,2,12)
    plt10=plot(0:99,zeros(1,100),'linewidth',1.5);
    grid
    axis([0 10 -1.1 1.1]) 
     text(10.6, 0.3, 'bin(+4)')
      text(10.2, -0.3, '+0.35 +0.45')
else
    ww=kaiser(100,6)';
    ww=ww/sum(ww);
    hp=remez(99,[0 40 60 500]/500,[1 1 0 0],[1 1]);
   
    fhp=fftshift(abs(fft(hp,100)));
    subplot(6,2,1)
    plt0=plot(-0.5:1/100:0.5-1/100,fftshift(abs(fft(xx(1:100).*ww))),'linewidth',3);
     
    hold on
    plot(-0.5:1/100:.5-1/100,fhp,'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(11:100) fhp(1:10)],'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(21:100) fhp(1:20)],'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(31:100) fhp(1:30)],'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(41:100) fhp(1:40)],'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(61:100) fhp(1:60)],'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(71:100) fhp(1:70)],'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(81:100) fhp(1:80)],'r--')
    plot(-0.5:1/100:.5-1/100,[fhp(91:100) fhp(1:90)],'r--')
         cc=get(gca,'children');
         set(cc,'linewidth',1.5)
    hold off
    grid
    axis([-0.5 0.5 0 1.1])
    title('Input Spectrum and Channel Bandwidths')
    mm=0;
    txt=text(0.55,0.5,['Sample # ',num2str(mm,3)]);
    
    subplot(6,2,3)
    plt1=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([-0.1501 -0.0499 0  1.1])
    text(-0.043, 0.65, 'bin(-1)')
    text(-0.048, 0.35, '-0.15 -0.05')
    
    subplot(6,2,4)
    plt2=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([-0.05 0.05 0  1.1])
    text(0.057, 0.65, 'bin(0)')
     text(0.052, 0.35, '-0.05 +0.05')
     
    subplot(6,2,5)
    plt3=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([-0.25 -0.15 0  1.1]) 
     text(-0.143, 0.65, 'bin(-2)')
     text(-0.148, 0.35, '-0.25 -0.15')
    
     subplot(6,2,6)
    plt4=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([0.05 0.15 0  1.1])
    text(0.157, 0.65, 'bin(+1)')
    text(0.152, 0.35, '+0.05 +0.15')
    
    subplot(6,2,7)
    plt5=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([-0.3501 -0.2499 0  1.1])
    text(-0.243, 0.65, 'bin(-3)')
    text(-0.248, 0.35, '-0.35 -0.25')
    
    subplot(6,2,8)
    plt6=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([0.15 0.25 0  1.1])
    text(0.257, 0.65, 'bin(+2)')
    text(0.252, 0.35, '+0.15 +0.25')

    subplot(6,2,9)
    plt7=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([-0.45 -0.35 0  1.1]) 
    text(-0.343, 0.65, 'bin(-4)')
    text(-0.348, 0.35, '-0.45 -0.35')
    
    subplot(6,2,10)
    plt8=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([0.25 0.35 0  1.1])
    text(0.357, 0.65, 'bin(+3)')
    text(0.352, 0.35, '+0.25 +0.35')
    
    subplot(6,2,11)
    plt9=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([-0.55 -0.45 0  1.1])
    text(-0.443, 0.65, 'bin(-5)')
    text(-0.448, 0.35, '-0.45 +0.45')
    
    subplot(6,2,12)
    plt10=plot((-0.5:1/100:0.5-1/100)/10,zeros(1,100),'linewidth',1.5);
    grid
    axis([0.35 0.4501 0  1.1]) 
    text(0.457, 0.65, 'bin(+4)')
    text(0.452, 0.35, '+0.35 +0.45')
end  
    
    
    
%hh=remez(169,[0 40 60 500]/500,[1 1 0 0],[1 100]);
frq=[0 40 60 99 100 149 150 199 200 249 250 299 300 349 350 399 400 449 450 500]/500;
gn= [1  1  0  0  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
pn= [  1   100    140     180     220     260     300     340     380     420];
hh=remez(169,frq,gn,pn);
hh2=reshape(hh,10,17);

reg=zeros(10,17);
n2=1;
rr=zeros(1,100);
yy=zeros(10,n_dat/10);
yy2=zeros(10,100);

ww2=ones(1,100)/100;
ww1=kaiser(100,6)';
ww1=ww1/sum(ww1);
    
for nn=1:10:n_dat-10
  rr=[fliplr(xx(nn:nn+9)) rr(1:90)];
   reg(:,2:17)=reg(:,1:16);
   reg(:,1)=flipud(xx(nn:nn+9)');
   for mm=1:10
      vv(mm)=reg(mm,:)*hh2(mm,:)';
   end
   yy(:,n2)=fft(vv).';
   n2=n2+1;
    yy2=[fft(vv).' yy2(:,1:99)];
   if flag2==1

  set(plt0,'xdata',0:99,'ydata',real(rr));
  set(plt1,'xdata',0:0.1:9.9,'ydata',real(yy2(10,:)));
  set(plt2,'xdata',0:0.1:9.9,'ydata',real(yy2(1,:)));
  set(plt3,'xdata',0:0.1:9.9,'ydata',real(yy2(9,:)));
  set(plt4,'xdata',0:0.1:9.9,'ydata',real(yy2(2,:)));
  set(plt5,'xdata',0:0.1:9.9,'ydata',real(yy2(8,:)));
  set(plt6,'xdata',0:0.1:9.9,'ydata',real(yy2(3,:)));
  set(plt7,'xdata',0:0.1:9.9,'ydata',real(yy2(7,:)));
  set(plt8,'xdata',0:0.1:9.9,'ydata',real(yy2(4,:)));
  set(plt9,'xdata',0:0.1:9.9,'ydata',real(yy2(6,:)));
  set(plt10,'xdata',0:0.1:9.9,'ydata',real(yy2(5,:)));
  
else
 
  set(plt0,'xdata',(-0.5:1/100:0.5-1/100),'ydata',fftshift(abs(fft((rr.*ww1)'))));
  set(plt1,'xdata',-0.1+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(10,1:nn_dat)/nn_dat,100))));
  set(plt2,'xdata',(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(1,1:nn_dat)/nn_dat,100))));
  set(plt3,'xdata',-0.2+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(9,1:nn_dat)/nn_dat,100))));
  set(plt4,'xdata',+0.1+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(2,1:nn_dat)/nn_dat,100))));
  set(plt5,'xdata',-0.3+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(8,1:nn_dat)/nn_dat,100))));
  set(plt6,'xdata',+0.2+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(3,1:nn_dat)/nn_dat,100))));
  set(plt7,'xdata',-0.4+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(7,1:nn_dat)/nn_dat,100))));
  set(plt8,'xdata',+0.3+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(4,1:nn_dat)/nn_dat,100))));
  set(plt9,'xdata',-0.5+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(6,1:nn_dat)/nn_dat,100))));
  set(plt10,'xdata',+0.4+(-0.5:1/100:0.5-1/100)/10,'ydata',fftshift(abs(fft(yy2(5,1:nn_dat)/nn_dat,100))));   

end    
 set(txt,'string',['Sample #  ',num2str(n2-1)]) 
pause(0.05)
end

% gg=get(gca);
% set(gca,'gridlinestyle','-')
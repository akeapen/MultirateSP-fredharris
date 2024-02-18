% sunflower_x, sequence of sunflower figures
% programmed by two nested for loops, 
% bad programming style... very slow
% see sunflower, programmed by vector products, 
% better programming style, significantly faster
% Script file written by fred harris of UCSD, Copyright 2021.

figure(3);
set(3,'color',[1 1 1])
phi=137.0*1;
for k=1:40
plot(0,0)
hold on
for n=1:1000
    r=sqrt(n);
    aa=phi*n;
    plot(r*exp(j*aa*pi/180),'r-o')
end
text(28,32,['Pattern # ',num2str(k)],'fontsize',14)
hold off

axis('square')
axis off
pause(.001)
phi=phi+0.01;
end

    
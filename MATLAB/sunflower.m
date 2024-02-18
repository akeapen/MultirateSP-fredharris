% sunflower, sequence of sunflower figures
% Animated display builds sunflower with 
% vector programming of sunflower petals
% compare with sunflower_x that uses two nested for loops
% significantly slower
% Script file written by fred harris of UCSD, Copyright 2021.

phi=135.0*1;
NN=1000;
rr=sqrt(1:NN);
figure(2);
set(2,'color',[1 1 1])
for k=1:400
plot(rr.*exp(j*phi*(1:NN)*pi/180),'ro')
text(28,32,['Pattern # ',num2str(k)],'fontsize',14)
axis('square')
axis([-40 40 -40 40])
axis off
pause(.05)
phi=phi+0.01;
end

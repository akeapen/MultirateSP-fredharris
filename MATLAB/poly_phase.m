% poly_phase offers an illustration of how Nyquist zone spectra in a 10-to-1 
% down sampled time series aquire unique phase profiles as a function of input
% time delay. An animated view of phase rotating Nyquist zones!
% Script file written by fred harris of UCSD. Copyright 2021

gg=[zeros(1,180) 0:0.1:0.9 ones(1,20) 0.9:-0.1:0.0 zeros(1,180)];

plot3(zeros(1,400), [-0.5:1/400:0.5-1/400],gg,'r')
grid
line([0 0],[0 0],[-1.2 1.2]);
line([0 0],[-.5 .5],[0 0]);
line([-1.2 1.2],[0 0],[0 0]);

line([0 0 0 0 0],[.5 .5 .55 .5 .5],[0 .025 0 -.025 0]);
line([0 0 0 0 0],[0 .01 0 -.01 0],[1.2 1.2  1.3  1.2  1.2]);
line([1.2 1.2  1.3  1.2  1.2],[0 .01 0 -.01 0],[0 0 0 0 0]);
 cc=get(gca,'children');
set(cc,'linewidth',2.5)

axis([-1.1 1.1 -0.5 0.5  -1.1 1.1])
view([130,30])

xlabel('imaginary part')
ylabel('frequency')
zlabel('real part')

pause
    
v0=[0:0.1:0.9 ones(1,20) 0.9:-0.1:0.0];
u0=[0 ones(1,9) 0.9:-0.1:0.0];
w0=[0:0.1:0.9 ones(1,9) 0];
g0=[u0 v0 v0 v0 v0 v0 v0 v0 v0 v0 w0];

plt1=plot3(imag(g0), [-0.5:1/400:0.5-1/400],real(g0),'r');

grid
line([0 0],[0 0],[-1.2 1.2]);
line([0 0],[-.5 .5],[0 0]);
line([-1.2 1.2],[0 0],[0 0]);

line([0 0 0 0 0],[.5 .5 .55 .5 .5],[0 .025 0 -.025 0]);
line([0 0 0 0 0],[0 .01 0 -.01 0],[1.2 1.2  1.3  1.2  1.2]);
line([1.2 1.2  1.3  1.2  1.2],[0 .01 0 -.01 0],[0 0 0 0 0]);
 cc=get(gca,'children');
set(cc,'linewidth',2.5)

axis([-1.1 1.1 -0.5 0.5  -1.1 1.1])

view([130,30])

xlabel('imaginary part')
ylabel('frequency')
zlabel('real part')
pause
for nn=1:1001
phi=[exp(j*2*pi*0.005*(nn-1)) exp(j*2*pi*0.004*(nn-1)) exp(j*2*pi*0.003*(nn-1)) exp(j*2*pi*0.002*(nn-1)) exp(j*2*pi*0.001*(nn-1))...
     1 exp(-j*2*pi*0.001*(nn-1)) exp(-j*2*pi*0.002*(nn-1)) exp(-j*2*pi*0.003*(nn-1)) exp(-j*2*pi*0.004*(nn-1)) exp(-j*2*pi*0.005*(nn-1))];   
g0=[u0*phi(1) v0*phi(2) v0*phi(3) v0*phi(4) v0*phi(5) v0*phi(6) v0*phi(7) v0*phi(8) v0*phi(9) v0*phi(10) w0*phi(11)];

   set(plt1,'xdata', imag(g0),'ydata',[-0.5:1/400:0.5-1/400],'zdata',real(g0));
pause(0.01)
end

pause
for nn=1:10:1001
phi=[exp(j*2*pi*0.005*(nn-1)) exp(j*2*pi*0.004*(nn-1)) exp(j*2*pi*0.003*(nn-1)) exp(j*2*pi*0.002*(nn-1)) exp(j*2*pi*0.001*(nn-1))...
     1 exp(-j*2*pi*0.001*(nn-1)) exp(-j*2*pi*0.002*(nn-1)) exp(-j*2*pi*0.003*(nn-1)) exp(-j*2*pi*0.004*(nn-1)) exp(-j*2*pi*0.005*(nn-1))];   
g0=[u0*phi(1) v0*phi(2) v0*phi(3) v0*phi(4) v0*phi(5) v0*phi(6) v0*phi(7) v0*phi(8) v0*phi(9) v0*phi(10) w0*phi(11)];

   set(plt1,'xdata', imag(g0),'ydata',[-0.5:1/400:0.5-1/400],'zdata',real(g0));
pause
end


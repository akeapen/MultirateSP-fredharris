function sm=add_2(n1,n2,b)
% forms sum using 2-compl arithmetic with b bits of precision
% Script file written by fred harris of SDSU. Copyright 2002

nmax=2^b;
posm=(nmax/2)-1;
negm=-(nmax)/2;
sm=rem(n1+n2,nmax);
if sm>posm
sm=sm-nmax;
end
if sm<negm
sm=sm+nmax;
end

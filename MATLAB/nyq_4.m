function yy=nyq_2aa(f_sym,f_smpl,alpha)
% function yy=nyq_4(f_sym,f_smpl,alpha);...
% try yy=nyq_4(1,8,0.25);...respond to prompt with 20, then repeat with 12
% function designs a Square-Root Nyquist pulse using Remez algorithm; 
% Significantly improves Out-of-Band Spectral Levels 
% Relative to Cosine Tapered Square Root Nyquist Filter  
% Script file written by fred harris of UCSD. Copyright 2021

wt=1.4;

OS=f_smpl/f_sym;

NN=1.6*3*f_smpl/(alpha*f_sym);
NN=ceil(NN/OS)*OS;
n_sym=NN/OS;

fprintf('Suggested Number of Symbols in Filter  = %3.0f',n_sym)
fprintf(' \n')
m_sym=input('Enter Your Choice of Number of Symbols =  ');

if isempty(m_sym)==1
    m_sym=n_sym;
end

NN=n_sym*f_smpl/f_sym;
disp(' ')
disp(' # # # # # # Stopband Sidelobes # # # # # ')
q_ans=input('for (1/f) enter 1, for Equiripple enter 0 => '); 
beta=1;

n_trans=OS*250;
zz=zeros(1,n_trans);
xx=(-0.5:1/n_trans:.5-1/n_trans)*f_smpl;
mm=1;
r1=0.1;

f1=0.5*(1-alpha)*f_sym;
f2=0.5*(1+alpha)*f_sym;
f3=0.5*f_smpl;

 freqv=[0 f1 f2 f3]/f3;
if q_ans==1
hh=remez(NN-1,freqv,{'myfrf',[1 1 0 0]},[1 wt]);
else
hh=remez(NN-1,freqv,[1 1 0 0],[1 wt]);
end
while abs(r1)>0.0001; 
freq_v=[0 beta*f1 f2 f3]/f3;
if q_ans==1
hh=remez(NN-1,freq_v,{'myfrf',[1 1 0 0]},[1 wt]);
else
hh=remez(NN-1,freq_v,[1 1 0 0],[1 wt]);
end
fhh=20*log10(abs(fft(hh,n_trans))+0.000001);
r1=-3.01-fhh(floor(1+0.5*n_trans*f_sym/f_smpl));
beta=beta+r1/40;

mm=mm+1;
if mm==500
    r1=0;
end

end
yy=hh;

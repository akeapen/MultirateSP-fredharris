% function time_10a
% function to determine coefficients of linear time delay paths of 10-path filter
% Coefficients pre-computed by lineardesign_2
% Script file written by fred harris of UCSD. Copyright 2021


aa(1,1)= 0.45875767974089;
aa(1,2)=-0.27682046601055;
aa(1,3)= 0.2336034361585625;
aa(1,4)= 0.1008493243772475;
aa(1,5)=-0.3205499354002768;
aa(1,6)= 0.08073617044526525;

aa(2,1)= 0.55679004288640;  
aa(2,2)=-0.28725474344800;
aa(2,3)= 0.2521519318113853;    
aa(2,4)= 0.112364152192137;
aa(2,5)=-0.3307820695343059;
aa(2,6)= 0.08748907318970313;

aa(3,1)= 0.63081736679921; 
aa(3,2)=-0.28416837902027;
aa(3,3)= 0.2651703229838471;
aa(3,4)= 0.1137679372391476;
aa(3,5)=-0.3240125991589438;
aa(3,6)= 0.08621779942664723;

aa(4,1)= 0.69399173272643;
aa(4,2)=-0.27473114751378;
aa(4,3)= 0.2757035263092209;
aa(4,4)= 0.1101274185389524;
aa(4,5)=-0.3092013288442129;
aa(4,6)= 0.08118488768446955;

aa(5,1)= 0.75102498883390;
aa(5,2)=-0.26126389781255;
aa(5,3)= 0.2843592313114721;    
aa(5,4)= 0.1032368099775435;    
aa(5,5)=-0.2892752255267356;
aa(5,6)= 0.07398766478606436;

aa(6,1)= 0.80423724324102;  
aa(6,2)=-0.24464568488983;
aa(6,3)= 0.2909252081854546;    
aa(6,4)= 0.09385664044174276;    
aa(6,5)=-0.2653868051399744;
aa(6,6)= 0.06538603533207302;

aa(7,1)= 0.85498071752955;  
aa(7,2)=-0.22496140116550;
aa(7,3)= 0.2944243555943947;    
aa(7,4)= 0.08218736249290677;    
aa(7,5)=-0.2377450904267895;
aa(7,6)= 0.05572041654635748;

aa(8,1)= 0.90413492821212;  
aa(8,2)=-0.20133829419209;
aa(8,3)= 0.2923231465907871;    
aa(8,4)= 0.06783921332516456;    
aa(8,5)=-0.2054823754951208;
aa(8,6)= 0.04495976952332849;

aa(9,1)= 0.95231963571901;  
aa(9,2)=-0.17010442011758;
aa(9,3)= 0.2765230794662025;    
aa(9,4)= 0.04899704079131299;    
aa(9,5)=-0.1646997903967725;
aa(9,6)= 0.03226377213505002;

zz=zeros(1,9);


figure(1)
subplot(2,1,1)
% pp is phase data
% dd is delay data
% mm is transform data
% path 0
den00=[1 zeros(1,60)]; 
[m0,w0]=freqz(fliplr(den00),den00,1000);
mm0=m0;
pp0=unwrap(angle(m0))/(2*pi);
dd0=pp0;
plot((0:1/1000:1-1/1000),pp0,'linewidth',1.0)
hold on

% path 1
den1=[1 zz aa(1,1)];
den2=[1 zz aa(1,2)];
den3=[1 zz aa(1,3) zz aa(1,4)];
den4=[1 zz aa(1,5) zz aa(1,6)];

[m1,w1]=freqz(fliplr(den1),den1,1000);
mm1=m1;
pp1=unwrap(angle(m1))/(2*pi);

[m1,w1]=freqz(fliplr(den2),den2,1000);
p1=unwrap(angle(m1))/(2*pi);
pp1=pp1+p1;
mm1=mm1.*m1;

[m1,w1]=freqz(fliplr(den3),den3,1000);
p1=unwrap(angle(m1))/(2*pi);
pp1=pp1+p1;
mm1=mm1.*m1;

[m1,w1]=freqz(fliplr(den4),den4,1000);
p1=unwrap(angle(m1))/(2*pi);
pp1=pp1+p1;
mm1=mm1.*m1;

dd1=pp1;
dly1=[1 0];
[m1,w1]=freqz(fliplr(dly1),dly1,1000);
p1=unwrap(angle(m1))/(2*pi);
pp1=pp1+p1;
mm1=mm1.*m1;

plot((0:1/1000:1-1/1000),pp1,'linewidth',1.0)

%path 2
den1=[1 zz aa(2,1)];
den2=[1 zz aa(2,2)];
den3=[1 zz aa(2,3) zz aa(2,4)];
den4=[1 zz aa(2,5) zz aa(2,6)];

[m2,w2]=freqz(fliplr(den1),den1,1000);
mm2=m2;
pp2=unwrap(angle(m2))/(2*pi);

[m2,w2]=freqz(fliplr(den2),den2,1000);
p2=unwrap(angle(m2))/(2*pi);
pp2=pp2+p2;
mm2=mm2.*m2;

[m2,w2]=freqz(fliplr(den3),den3,1000);
p2=unwrap(angle(m2))/(2*pi);
pp2=pp2+p2;
mm2=mm2.*m2;

[m2,w2]=freqz(fliplr(den4),den4,1000);
p2=unwrap(angle(m2))/(2*pi);
pp2=pp2+p2;
mm2=mm2.*m2;

dd2=pp2;
dly2=[1 0 0];
[m2,w2]=freqz(fliplr(dly2),dly2,1000);
p2=unwrap(angle(m2))/(2*pi);
pp2=pp2+p2;
mm2=mm2.*m2;

plot((0:1/1000:1-1/1000),pp2,'linewidth',1.0)

%path 3
den1=[1 zz aa(3,1)];
den2=[1 zz aa(3,2)];
den3=[1 zz aa(3,3) zz aa(3,4)];
den4=[1 zz aa(3,5) zz aa(3,6)];

[m3,w3]=freqz(fliplr(den1),den1,1000);
mm3=m3;
pp3=unwrap(angle(m3))/(2*pi);

[m3,w3]=freqz(fliplr(den2),den2,1000);
p3=unwrap(angle(m3))/(2*pi);
pp3=pp3+p3;
mm3=mm3.*m3;

[m3,w3]=freqz(fliplr(den3),den3,1000);
p3=unwrap(angle(m3))/(2*pi);
pp3=pp3+p3;
mm3=mm3.*m3;

[m3,w3]=freqz(fliplr(den4),den4,1000);
p3=unwrap(angle(m3))/(2*pi);
pp3=pp3+p3;
mm3=mm3.*m3;

dd3=pp3;
dly3=[1 0 0 0];
[m3,w3]=freqz(fliplr(dly3),dly3,1000);
p3=unwrap(angle(m3))/(2*pi);
pp3=pp3+p3;
mm3=mm3.*m3;

plot((0:1/1000:1-1/1000),pp3,'linewidth',1.0)

%path 4
den1=[1 zz aa(4,1)];
den2=[1 zz aa(4,2)];
den3=[1 zz aa(4,3) zz aa(4,4)];
den4=[1 zz aa(4,5) zz aa(4,6)];

[m4,w4]=freqz(fliplr(den1),den1,1000);
mm4=m4;
pp4=unwrap(angle(m4))/(2*pi);

[m4,w4]=freqz(fliplr(den2),den2,1000);
p4=unwrap(angle(m4))/(2*pi);
pp4=pp4+p4;
mm4=mm4.*m4;

[m4,w4]=freqz(fliplr(den3),den3,1000);
p4=unwrap(angle(m4))/(2*pi);
pp4=pp4+p4;
mm4=mm4.*m4;

[m4,w4]=freqz(fliplr(den4),den4,1000);
p4=unwrap(angle(m4))/(2*pi);
pp4=pp4+p4;
mm4=mm4.*m4;

dd4=pp4;
dly4=[1 0 0 0 0];
[m4,w4]=freqz(fliplr(dly4),dly4,1000);
p4=unwrap(angle(m4))/(2*pi);
pp4=pp4+p4;
mm4=mm4.*m4;

plot((0:1/1000:1-1/1000),pp4,'linewidth',1.0)

%path 5
den1=[1 zz aa(5,1)];
den2=[1 zz aa(5,2)];
den3=[1 zz aa(5,3) zz aa(5,4)];
den4=[1 zz aa(5,5) zz aa(5,6)];

[m5,w5]=freqz(fliplr(den1),den1,1000);
mm5=m5;
pp5=unwrap(angle(m5))/(2*pi);

[m5,w5]=freqz(fliplr(den2),den2,1000);
p5=unwrap(angle(m5))/(2*pi);
pp5=pp5+p5;
mm5=mm5.*m5;

[m5,w5]=freqz(fliplr(den3),den3,1000);
p5=unwrap(angle(m5))/(2*pi);
pp5=pp5+p5;
mm5=mm5.*m5;

[m5,w5]=freqz(fliplr(den4),den4,1000);
p5=unwrap(angle(m5))/(2*pi);
pp5=pp5+p5;
mm5=mm5.*m5;

dd5=pp5;
dly5=[1 0 0 0 0 0];
[m5,w5]=freqz(fliplr(dly5),dly5,1000);
p5=unwrap(angle(m5))/(2*pi);
pp5=pp5+p5;
mm5=mm5.*m5;

plot((0:1/1000:1-1/1000),pp5,'linewidth',1.0)

%path 6
den1=[1 zz aa(6,1)];
den2=[1 zz aa(6,2)];
den3=[1 zz aa(6,3) zz aa(6,4)];
den4=[1 zz aa(6,5) zz aa(6,6)];

[m6,w6]=freqz(fliplr(den1),den1,1000);
mm6=m6;
pp6=unwrap(angle(m6))/(2*pi);

[m6,w6]=freqz(fliplr(den2),den2,1000);
p6=unwrap(angle(m6))/(2*pi);
pp6=pp6+p6;
mm6=mm6.*m6;

[m6,w6]=freqz(fliplr(den3),den3,1000);
p6=unwrap(angle(m6))/(2*pi);
pp6=pp6+p6;
mm6=mm6.*m6;

[m6,w6]=freqz(fliplr(den4),den4,1000);
p6=unwrap(angle(m6))/(2*pi);
pp6=pp6+p6;
mm6=mm6.*m6;

dd6=pp6;
dly6=[1 0 0 0 0 0 0];
[m6,w6]=freqz(fliplr(dly6),dly6,1000);
p6=unwrap(angle(m6))/(2*pi);
pp6=pp6+p6;
mm6=mm6.*m6;

plot((0:1/1000:1-1/1000),pp6,'linewidth',1.0)

%path 7
den1=[1 zz aa(7,1)];
den2=[1 zz aa(7,2)];
den3=[1 zz aa(7,3) zz aa(7,4)];
den4=[1 zz aa(7,5) zz aa(7,6)];

[m7,w7]=freqz(fliplr(den1),den1,1000);
mm7=m7;
pp7=unwrap(angle(m7))/(2*pi);

[m7,w7]=freqz(fliplr(den2),den2,1000);
p7=unwrap(angle(m7))/(2*pi);
pp7=pp7+p7;
mm7=mm7.*m7;

[m7,w7]=freqz(fliplr(den3),den3,1000);
p7=unwrap(angle(m7))/(2*pi);
pp7=pp7+p7;
mm7=mm7.*m7;

[m7,w7]=freqz(fliplr(den4),den4,1000);
p7=unwrap(angle(m7))/(2*pi);
pp7=pp7+p7;
mm7=mm7.*m7;

dd7=pp7;
dly7=[1 0 0 0 0 0 0 0];
[m7,w7]=freqz(fliplr(dly7),dly7,1000);
p7=unwrap(angle(m7))/(2*pi);
pp7=pp7+p7;
mm7=mm7.*m7;

plot((0:1/1000:1-1/1000),pp7,'linewidth',1.0)

%path 8
den1=[1 zz aa(8,1)];
den2=[1 zz aa(8,2)];
den3=[1 zz aa(8,3) zz aa(8,4)];
den4=[1 zz aa(8,5) zz aa(8,6)];

[m8,w8]=freqz(fliplr(den1),den1,1000);
mm8=m8;
pp8=unwrap(angle(m8))/(2*pi);

[m8,w8]=freqz(fliplr(den2),den2,1000);
p8=unwrap(angle(m8))/(2*pi);
pp8=pp8+p8;
mm8=mm8.*m8;

[m8,w8]=freqz(fliplr(den3),den3,1000);
p8=unwrap(angle(m8))/(2*pi);
pp8=pp8+p8;
mm8=mm8.*m8;

[m8,w8]=freqz(fliplr(den4),den4,1000);
p8=unwrap(angle(m8))/(2*pi);
pp8=pp8+p8;
mm8=mm8.*m8;

dd8=pp8;
dly8=[1 0 0 0 0 0 0 0 0];
[m8,w8]=freqz(fliplr(dly8),dly8,1000);
p8=unwrap(angle(m8))/(2*pi);
pp8=pp8+p8;
mm8=mm8.*m8;

plot((0:1/1000:1-1/1000),pp8,'linewidth',1.0)

%path 9
den1=[1 zz aa(9,1)];
den2=[1 zz aa(9,2)];
den3=[1 zz aa(9,3) zz aa(9,4)];
den4=[1 zz aa(9,5) zz aa(9,6)];

[m9,w9]=freqz(fliplr(den1),den1,1000);
mm9=m9;
pp9=unwrap(angle(m9))/(2*pi);

[m9,w9]=freqz(fliplr(den2),den2,1000);
p9=unwrap(angle(m9))/(2*pi);
pp9=pp9+p9;
mm9=mm9.*m9;

[m9,w9]=freqz(fliplr(den3),den3,1000);
p9=unwrap(angle(m9))/(2*pi);
pp9=pp9+p9;
mm9=mm9.*m9;

[m9,w9]=freqz(fliplr(den4),den4,1000);
p9=unwrap(angle(m9))/(2*pi);
pp9=pp9+p9;
mm9=mm9.*m9;

dd9=pp9;
dly9=[1 0 0 0 0 0 0 0 0 0];
[m9,w9]=freqz(fliplr(dly9),dly9,1000);
p9=unwrap(angle(m9))/(2*pi);
pp9=pp9+p9;
mm9=mm9.*m9;

plot((0:1/1000:1-1/1000),pp9,'linewidth',1.0)

hold off
grid on
%axis([0 f_smpl/2 -22 0])
title('Phase Response: 10-Paths')
xlabel('Frequency')
ylabel('Phase \theta(f)/(2\pi)')

subplot(2,1,2)

mm_sum=mm0+mm1+mm2+mm3+mm4+mm5+mm6+mm7+mm8+mm9;
plot((0:1/1000:1-1/1000),20*log10(abs(mm_sum/10)),'b','linewidth',1.0)
axis([0 1 -110 10])
grid
title('Log Magnitude Response, 10 path filter')
xlabel('Frequency')
ylabel('Log Mag (dB)')


figure(2)

plot((0:1/1000:1-1/1000)*5,1*dd0(1:1000),'r','linewidth',1.0)
hold on
plot((0:1/1000:1-1/1000)*5,1*dd1(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd2(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd3(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd4(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd5(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd6(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd7(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd8(1:1000),'linewidth',1.0)
plot((0:1/1000:1-1/1000)*5,1*dd9(1:1000),'linewidth',1.0)

hold off
grid
axis([0 .5 -3 0])
xlabel('Normalized Frequency')
ylabel('Phase Shift (\phi/2\pi)')
title('Phase Shift of Each Path in 10-Path, Linear Phase Recursive All-pass Filter Bank')

figure(3)

d0=conv(dd0,[1 0 -1]*100);
d1=conv(dd1,[1 0 -1]*100);
d2=conv(dd2,[1 0 -1]*100);
d3=conv(dd3,[1 0 -1]*100);
d4=conv(dd4,[1 0 -1]*100);
d5=conv(dd5,[1 0 -1]*100);
d6=conv(dd6,[1 0 -1]*100);
d7=conv(dd7,[1 0 -1]*100);
d8=conv(dd8,[1 0 -1]*100);
d9=conv(dd9,[1 0 -1]*100);

plot((1/1000:1/1000:1-1/1000)*5,d0(3:1001),'r','linewidth',1.0)
hold
plot((1/1000:1/1000:1-1/1000)*5,d1(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d2(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d3(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d4(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d5(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d6(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d7(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d8(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d9(3:1001),'linewidth',1.0)
hold on
grid on
axis([0 .5 -6.2 -5])
xlabel('Normalized Frequency')
ylabel('Delay (input Samples)')
title('Group Delay of Ten Paths in Linear Phase Recursive All Pass Filter Bank ')

figure(4)

plot(0:.1:.9,[0 aa(:,1)'],'xr','markersize',8,'linewidth',2)
hold
plot(0:.1:.9,[0 aa(:,2)'],'xr','markersize',8,'linewidth',2)
plot(0:.1:.9,[0 aa(:,3)'],'xr','markersize',8,'linewidth',2)
plot(0:.1:.9,[0 aa(:,4)'],'xr','markersize',8,'linewidth',2)
plot(0:.1:.9,[0 aa(:,5)'],'xr','markersize',8,'linewidth',2)
plot(0:.1:.9,[0 aa(:,6)'],'xr','markersize',8,'linewidth',2)

p1=polyfit(0.1:.1:.9,[aa(:,1)'],6);
p2=polyfit(0.1:.1:.9,[aa(:,2)'],6);
p3=polyfit(0.1:.1:.9,[aa(:,3)'],6);
p4=polyfit(0.1:.1:.9,[aa(:,4)'],6);
p5=polyfit(0.1:.1:.9,[aa(:,5)'],6);
p6=polyfit(0.1:.1:.9,[aa(:,6)'],6);

y1=polyval(p1,(0:.01:1));
y2=polyval(p2,(0:.01:1));
y3=polyval(p3,(0:.01:1));
y4=polyval(p4,(0:.01:1));
y5=polyval(p5,(0:.01:1));
y6=polyval(p6,(0:.01:1));

plot((0:.01:1),y1,'linewidth',1.0)
plot((0:.01:1),y2,'linewidth',1.0)
plot((0:.01:1),y3,'linewidth',1.0)
plot((0:.01:1),y4,'linewidth',1.0)
plot((0:.01:1),y5,'linewidth',1.0)
plot((0:.01:1),y6,'linewidth',1.0)
hold on
grid on

title('Polynomial Fit to 6-Weights of Recursive Filters in 9-Paths of Linear Phase Filter')
xlabel('Filter Delay (Fraction of Output Sample Rate)')
ylabel('Coefficient Values')

% down sample to desired coefficient set

bb(:,1)=y1(6:10:98)';
bb(:,2)=y2(6:10:98)';
bb(:,3)=y3(6:10:98)';
bb(:,4)=y4(6:10:98)';
bb(:,5)=y5(6:10:98)';
bb(:,6)=y6(6:10:98)';

% now construct delay profile for new coefficient sets

[n0,w0]=freqz(fliplr(den00),den00,1000);
nn0=n0;
xpp0=unwrap(angle(n0))/(2*pi);
xdd0=xpp0;

% path 1
den1=[1 zz bb(1,1)];
den2=[1 zz bb(1,2)];
den3=[1 zz bb(1,3) zz bb(1,4)];
den4=[1 zz bb(1,5) zz bb(1,6)];

[n1,w1]=freqz(fliplr(den1),den1,1000);
nn1=n1;
xpp1=unwrap(angle(n1))/(2*pi);

[n1,w1]=freqz(fliplr(den2),den2,1000);
xp1=unwrap(angle(n1))/(2*pi);
xpp1=xpp1+xp1;
nn1=nn1.*n1;

[n1,w1]=freqz(fliplr(den3),den3,1000);
xp1=unwrap(angle(n1))/(2*pi);
xpp1=xpp1+xp1;
nn1=nn1.*n1;

[n1,w1]=freqz(fliplr(den4),den4,1000);
xp1=unwrap(angle(n1))/(2*pi);
xpp1=xpp1+xp1;
nn1=nn1.*n1;

xdd1=xpp1;
dly1=[1 0];
[n1,w1]=freqz(fliplr(dly1),dly1,1000);
xp1=unwrap(angle(n1))/(2*pi);
xpp1=xpp1+xp1;
nn1=nn1.*xp1;

%path 2
den1=[1 zz bb(2,1)];
den2=[1 zz bb(2,2)];
den3=[1 zz bb(2,3) zz bb(2,4)];
den4=[1 zz bb(2,5) zz bb(2,6)];

[n2,w2]=freqz(fliplr(den1),den1,1000);
nn2=n2;
xpp2=unwrap(angle(n2))/(2*pi);

[n2,w2]=freqz(fliplr(den2),den2,1000);
xp2=unwrap(angle(n2))/(2*pi);
xpp2=xpp2+xp2;
nn2=nn2.*n2;

[n2,w2]=freqz(fliplr(den3),den3,1000);
xp2=unwrap(angle(n2))/(2*pi);
xpp2=xpp2+xp2;
nn2=nn2.*n2;

[n2,w2]=freqz(fliplr(den4),den4,1000);
xp2=unwrap(angle(n2))/(2*pi);
xpp2=xpp2+xp2;
nn2=nn2.*n2;

xdd2=xpp2;
dly2=[1 0 0];
[n2,w2]=freqz(fliplr(dly2),dly2,1000);
xp2=unwrap(angle(n2))/(2*pi);
xpp2=xpp2+xp2;
nn2=nn2.*n2;

%path 3
den1=[1 zz bb(3,1)];
den2=[1 zz bb(3,2)];
den3=[1 zz bb(3,3) zz bb(3,4)];
den4=[1 zz bb(3,5) zz bb(3,6)];

[n3,w3]=freqz(fliplr(den1),den1,1000);
nn3=n3;
xpp3=unwrap(angle(n3))/(2*pi);

[n3,w3]=freqz(fliplr(den2),den2,1000);
xp3=unwrap(angle(n3))/(2*pi);
xpp3=xpp3+xp3;
nn3=nn3.*n3;

[n3,w3]=freqz(fliplr(den3),den3,1000);
xp3=unwrap(angle(n3))/(2*pi);
xpp3=xpp3+xp3;
nn3=nn3.*n3;

[n3,w3]=freqz(fliplr(den4),den4,1000);
xp3=unwrap(angle(n3))/(2*pi);
xpp3=xpp3+xp3;
nn3=nn3.*n3;

xdd3=xpp3;
dly3=[1 0 0 0];
[n3,w3]=freqz(fliplr(dly3),dly3,1000);
xp3=unwrap(angle(n3))/(2*pi);
xpp3=xpp3+xp3;
nn3=nn3.*n3;

%path 4
den1=[1 zz bb(4,1)];
den2=[1 zz bb(4,2)];
den3=[1 zz bb(4,3) zz bb(4,4)];
den4=[1 zz bb(4,5) zz bb(4,6)];

[n4,w4]=freqz(fliplr(den1),den1,1000);
nn4=n4;
xpp4=unwrap(angle(n4))/(2*pi);

[n4,w4]=freqz(fliplr(den2),den2,1000);
xp4=unwrap(angle(n4))/(2*pi);
xpp4=xpp4+xp4;
nn4=nn4.*n4;

[n4,w4]=freqz(fliplr(den3),den3,1000);
xp4=unwrap(angle(n4))/(2*pi);
xpp4=xpp4+xp4;
nn4=nn4.*n4;

[n4,w4]=freqz(fliplr(den4),den4,1000);
xp4=unwrap(angle(n4))/(2*pi);
xpp4=xpp4+xp4;
nn4=nn4.*n4;

xdd4=xpp4;
dly4=[1 0 0 0 0];
[n4,w4]=freqz(fliplr(dly4),dly4,1000);
xp4=unwrap(angle(n4))/(2*pi);
xpp4=xpp4+xp4;
nn4=nn4.*n4;

%path 5
den1=[1 zz bb(5,1)];
den2=[1 zz bb(5,2)];
den3=[1 zz bb(5,3) zz bb(5,4)];
den4=[1 zz bb(5,5) zz bb(5,6)];

[n5,w5]=freqz(fliplr(den1),den1,1000);
nn5=n5;
xpp5=unwrap(angle(n5))/(2*pi);

[n5,w5]=freqz(fliplr(den2),den2,1000);
xp5=unwrap(angle(n5))/(2*pi);
xpp5=xpp5+xp5;
nn5=nn5.*n5;

[n5,w5]=freqz(fliplr(den3),den3,1000);
xp5=unwrap(angle(n5))/(2*pi);
xpp5=xpp5+xp5;
nn5=nn5.*n5;

[n5,w5]=freqz(fliplr(den4),den4,1000);
xp5=unwrap(angle(n5))/(2*pi);
xpp5=xpp5+xp5;
nn5=nn5.*n5;

xdd5=xpp5;
dly5=[1 0 0 0 0 0];
[n5,w5]=freqz(fliplr(dly5),dly5,1000);
xp5=unwrap(angle(n5))/(2*pi);
xpp5=xpp5+xp5;
nn5=nn5.*n5;

%path 6
den1=[1 zz bb(6,1)];
den2=[1 zz bb(6,2)];
den3=[1 zz bb(6,3) zz bb(6,4)];
den4=[1 zz bb(6,5) zz bb(6,6)];

[n6,w6]=freqz(fliplr(den1),den1,1000);
nn6=n6;
xpp6=unwrap(angle(n6))/(2*pi);

[n6,w6]=freqz(fliplr(den2),den2,1000);
xp6=unwrap(angle(n6))/(2*pi);
xpp6=xpp6+xp6;
nn6=nn6.*n6;

[n6,w6]=freqz(fliplr(den3),den3,1000);
xp6=unwrap(angle(n6))/(2*pi);
xpp6=xpp6+xp6;
nn6=nn6.*n6;

[n6,w6]=freqz(fliplr(den4),den4,1000);
xp6=unwrap(angle(n6))/(2*pi);
xpp6=xpp6+xp6;
nn6=nn6.*n6;

xdd6=xpp6;
dly6=[1 0 0 0 0 0 0];
[h6,w6]=freqz(fliplr(dly6),dly6,1000);
xp6=unwrap(angle(n6))/(2*pi);
xpp6=xpp6+xp6;
nn6=nn6.*n6;

%path 7
den1=[1 zz bb(7,1)];
den2=[1 zz bb(7,2)];
den3=[1 zz bb(7,3) zz bb(7,4)];
den4=[1 zz bb(7,5) zz bb(7,6)];

[n7,w7]=freqz(fliplr(den1),den1,1000);
nn7=n7;
xpp7=unwrap(angle(n7))/(2*pi);

[n7,w7]=freqz(fliplr(den2),den2,1000);
xp7=unwrap(angle(n7))/(2*pi);
xpp7=xpp7+xp7;
nn7=nn7.*n7;

[n7,w7]=freqz(fliplr(den3),den3,1000);
xp7=unwrap(angle(n7))/(2*pi);
xpp7=xpp7+xp7;
nn7=nn7.*n7;

[n7,w7]=freqz(fliplr(den4),den4,1000);
xp7=unwrap(angle(n7))/(2*pi);
xpp7=xpp7+xp7;
nn7=nn7.*n7;

xdd7=xpp7;
dly7=[1 0 0 0 0 0 0 0];
[n7,w7]=freqz(fliplr(dly7),dly7,1000);
xp7=unwrap(angle(n7))/(2*pi);
xpp7=xpp7+xp7;
nn7=nn7.*n7;

%path 8
den1=[1 zz bb(8,1)];
den2=[1 zz bb(8,2)];
den3=[1 zz bb(8,3) zz bb(8,4)];
den4=[1 zz bb(8,5) zz bb(8,6)];

[n8,w8]=freqz(fliplr(den1),den1,1000);
nn8=n8;
xpp8=unwrap(angle(n8))/(2*pi);

[n8,w8]=freqz(fliplr(den2),den2,1000);
xp8=unwrap(angle(n8))/(2*pi);
xpp8=xpp8+xp8;
nn8=nn8.*n8;

[n8,w8]=freqz(fliplr(den3),den3,1000);
xp8=unwrap(angle(n8))/(2*pi);
xpp8=xpp8+xp8;
nn8=nn8.*n8;

[n8,w8]=freqz(fliplr(den4),den4,1000);
xp8=unwrap(angle(n8))/(2*pi);
xpp8=xpp8+xp8;
nn8=nn8.*n8;

xdd8=xpp8;
dly8=[1 0 0 0 0 0 0 0 0];
[n8,w8]=freqz(fliplr(dly8),dly8,1000);
xp8=unwrap(angle(n8))/(2*pi);
xpp8=xpp8+xp8;
nn8=nn8.*n8;


%path 9
den1=[1 zz bb(9,1)];
den2=[1 zz bb(9,2)];
den3=[1 zz bb(9,3) zz bb(9,4)];
den4=[1 zz bb(9,5) zz bb(9,6)];

[n9,w9]=freqz(fliplr(den1),den1,1000);
nn9=n9;
xpp9=unwrap(angle(n9))/(2*pi);

[n9,w9]=freqz(fliplr(den2),den2,1000);
xp9=unwrap(angle(n9))/(2*pi);
xpp9=xpp9+xp9;
nn9=nn9.*n9;

[n9,w9]=freqz(fliplr(den3),den3,1000);
xp9=unwrap(angle(n9))/(2*pi);
xpp9=xpp9+xp9;
nn9=nn9.*n9;

[n9,w9]=freqz(fliplr(den4),den4,1000);
xp9=unwrap(angle(n9))/(2*pi);
xpp9=xpp9+xp9;
nn9=nn9.*n9;

xdd9=xpp9;
dly9=[1 0 0 0 0 0 0 0 0 0];
[n9,w9]=freqz(fliplr(dly9),dly9,1000);
xp9=unwrap(angle(n9))/(2*pi);
xpp9=xpp9+xp9;
nn9=nn9.*n9;

figure(5)

xd0=conv(xdd0,[1 0 -1]*100);
xd1=conv(xdd1,[1 0 -1]*100);
xd2=conv(xdd2,[1 0 -1]*100);
xd3=conv(xdd3,[1 0 -1]*100);
xd4=conv(xdd4,[1 0 -1]*100);
xd5=conv(xdd5,[1 0 -1]*100);
xd6=conv(xdd6,[1 0 -1]*100);
xd7=conv(xdd7,[1 0 -1]*100);
xd8=conv(xdd8,[1 0 -1]*100);
xd9=conv(xdd9,[1 0 -1]*100);
hold on

%plot((1/1000:1/1000:1-1/1000)*5,xd0(3:1001),'r')
%hold on
plot((1/1000:1/1000:1-1/1000)*5,xd1(3:1001),'r','linewidth',1.0)
hold on
plot((1/1000:1/1000:1-1/1000)*5,xd2(3:1001),'r','linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,xd3(3:1001),'r','linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,xd4(3:1001),'r','linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,xd5(3:1001),'r','linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,xd6(3:1001),'r','linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,xd7(3:1001),'r','linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,xd8(3:1001),'r','linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,xd9(3:1001),'r','linewidth',1.0)

% now plot original group delay terms

plot((1/1000:1/1000:1-1/1000)*5,d0(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d1(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d2(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d3(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d4(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d5(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d6(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d7(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d8(3:1001),'linewidth',1.0)
plot((1/1000:1/1000:1-1/1000)*5,d9(3:1001),'linewidth',1.0)
hold off
grid on
axis([0 .5 -6.2 -5])
xlabel('Normalized Frequency')
ylabel('Delay (input Samples)')
title('Group Delay of Original Ten Path Gains with Interpolated Mid Point Path Gains')

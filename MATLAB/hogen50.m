function hogen50(mm,n_bits)
% hogen50(mm,n_bits) try hogen50(20,23) then hogen50(20,22)
% 4-stage Hogenauer filter for mm to 1 downsampling
% integer implementation simulating 2-compl arithmetic with n_bit accumulators
% Script file written by fred harris of UCSD. Copyright 2021

if mm > 50
mm=50;
end

w1=0;w2=0;w3=0;w4=0;
d1=0;d2=0;d3=0;d4=0;

% integrators
%n_bits=16;
%mm=5;
for n=1:1000
d_in(n)=fix(16*sin(2*pi*n/395));

w1=add_2(d_in(n),w1,n_bits);
ww1(n)=w1;

w2=add_2(w1,w2,n_bits);
ww2(n)=w2;

w3=add_2(w2,w3,n_bits);
ww3(n)=w3;

w4=add_2(w3,w4,n_bits);
ww4(n)=w4;
end

subplot(4,2,1);plot(ww1,'linewidth',1);grid on;
title('Integrator 1');ylabel('Amplitude')

subplot(4,2,3);plot(ww2,'linewidth',1);grid on;
title('Integrator 2');ylabel('Amplitude')

subplot(4,2,5);plot(ww3,'linewidth',1);grid on;
title('Integrator 3');ylabel('Amplitude')

subplot(4,2,7);plot(ww4,'linewidth',1);grid on;
title('Integrator 4');ylabel('Amplitude');xlabel('Time Index')

% downsampling for comb filter
d_dwn=ww4(1:mm:length(ww4));

% differentiators
for n=1:length(d_dwn)
dd1(n)=add_2(d_dwn(n),-d1,n_bits);
d1=d_dwn(n);

dd2(n)=add_2(dd1(n),-d2,n_bits);
d2=dd1(n);

dd3(n)=add_2(dd2(n),-d3,n_bits);
d3=dd2(n);

dd4(n)=add_2(dd3(n),-d4,n_bits);
d4=dd3(n);
end


subplot(4,2,2);plot(dd1,'linewidth',1);grid on;
title('Derivative 1');ylabel('Amplitude')

subplot(4,2,4);plot(dd2,'linewidth',1);grid on;
title('Derivative 2');ylabel('Amplitude')

subplot(4,2,6);plot(dd3,'linewidth',1);grid on;
title('Derivative 3');ylabel('Amplitude')

subplot(4,2,8);plot(dd4,'linewidth',1);grid on;
title('Derivative 4');ylabel('Amplitude');xlabel('Time Index')

figure(2)
plot(dd4,'linewidth',2);
hold on
plot(mm^4*d_in(1:mm:length(d_in)),'r','linewidth',2)
hold off
grid on
title(' Input and Output, Hoegenauer Filter')
xlabel('Time Index')
ylabel('Amplitude')

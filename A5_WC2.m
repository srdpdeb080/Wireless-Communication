%Wireless Communication Assignment #5
%Question #2
%Souradeep Deb, MS(By Research)
%Roll No. 2019702004

N=16; %Repeat the same using N=8 and N=16
B=1;
H=abs(rand(N,N));
[U,S,V]=svd(H);

sigma=zeros(1,N);

for i=1:N
    sigma(i)=S(i,i);
end

SNR_in=-20:5:30;

C1=zeros(1,length(SNR_in));
C2=zeros(1,length(SNR_in));

for i=1:length(SNR_in)
    C1(i)=WaterFill(sigma,SNR_in(i),B)/N; %Water Filling Allocation Algorithm
    C2(i)=EqualPower(H,SNR_in(i),B)/N;    %Equal Power Allocation Algorithm
end

figure;
plot(C1,'ro--');hold on;
plot(C2,'bx--');
xlabel('SNR(dB)');
ylabel('Average Shannon Channel Capacity');
title('Average Capacity vs SNR for MIMO system(Nt=16,Nr=16)');
legend('Water Filling','Equal Power Alloc');
grid on;
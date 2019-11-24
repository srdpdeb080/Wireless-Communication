%Wireless Communication Assignment #5
%Question #1
%Souradeep Deb, MS(By Research)
%Roll No. 2019702004

sigma=[1.333 0.5129 0.0965]; %Singular Values of given channels
SNR_in=10; %Total Signal Power/Total Noise Power
B=1; %Bandwidth
gamma=SNR_in*(sigma.^2); %SNR of individual channels
gamma_o=0; %Threshold SNR
n=length(gamma);
sum=0;
k=0;  

    for i=1:n
      if gamma(i)>gamma_o
      sum=sum+(1/gamma(i));
      k=k+1;
      else
          gamma(i)=0;
          
      end
      gamma_o=k/(1+sum);
      
    end
X=sprintf('Threshold SNR: %12f',gamma_o);
disp(X);    
P_alloc=zeros(1,n); %Allocated Power/Total Power
C=0; %Shannon's Channel Capacity

for i=1:n
    if gamma(i)>gamma_o
    P_alloc(i)=(1/gamma_o)-(1/gamma(i));
    C=C+B*log2(1+P_alloc(i)*gamma(i));
    else
        continue;
    end
end
Y=sprintf('%12f ', P_alloc);
fprintf('Power Allocated in different channels: %s\n', Y);
Z=sprintf('Shannon Channel Capacity: %12f',C);
disp(Z);
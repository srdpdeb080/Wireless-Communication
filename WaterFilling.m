%Sourish Ganguly
%Roll: 2019702015
%Wireless Communication Assignment 5, Question 2

function C = WaterFilling(sigma, SNR_in, B)

SNR_inv = 10^(SNR_in/10);
gamma = SNR_inv*(sigma.^2);
gamma0 = 0;
k = 0;
while 1
    
    sum = 0;
    flag = 0;
    N = 0;
    for i = 1:length(gamma)
        
        if gamma(i)>gamma0 && gamma(i)~=0
            
            sum = sum + 1/gamma(i);
            N = N + 1;
            
        elseif gamma(i)<gamma0 && gamma(i)>0
            gamma(i) = 0;
            flag = -1;
        end
        
    end
    
    gamma0 = N/(1 + sum);
    k = k+1;
    if flag ==0 && k>1
        break;
    end
end
%Optimal Power Allocation:
P_alloc = zeros(1,length(gamma));
C = 0;
for i = 1:length(gamma)
    if gamma(i)~=0
      P_alloc(i) = (1/gamma0) - (1/gamma(i));
      C = C + B*log2(gamma(i)/gamma0);
    else
      continue;
    end
end
end
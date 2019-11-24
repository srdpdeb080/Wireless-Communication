%Wireless Communication Assignment #5
%Question #2
%Souradeep Deb, MS(By Research)
%Roll No. 2019702004

%Equal Power Allocation Algorithm Function

function C=EqualPower(H,SNR_in,B)
SNR_inv=10^((SNR_in)/10);
N = length(H(:,1));
I=eye(N);
D=det(I+(SNR_inv/N)*(H*H'));
C=B*log2(D);
end
%Wireless Communication Assignment #3
%Question #3

%4-QAM SER and BER

%Transmit Bitstream
l=10000;
m=2;
bit_seq =zeros(l,m);
for i=1:l
    for j=1:m
        bit_seq(i,j)=round(rand);
    end
end
x=zeros(l,m);
for i=1:l
 for j=1:m-1
 if (bit_seq(i,j)==0&&bit_seq(i,j+1)==0)
       x(i,j)= -1;
       x(i,j+1)=-1;
 elseif (bit_seq(i,j)==0&&bit_seq(i,j+1)==1)
       x(i,j)= -1;
       x(i,j+1)=1;
 elseif (bit_seq(i,j)==1&&bit_seq(i,j+1)==0)
       x(i,j)= 1;
       x(i,j+1)=-1;
 else
       x(i,j)= 1;
       x(i,j+1)=1;
 end
 end
end

%Receive bitstream
snr=0;
SNR=zeros(1,10);
SER=zeros(1,10);
BER=zeros(1,10);
for a=1:10

y=awgn(x,snr);
y_rcv=zeros(l,m);
for i=1:l
 for j=1:m-1
 if (y(i,j)<=0 && y(i,j+1)<=0)
       y_rcv(i,j)= 0;
       y_rcv(i,j+1)=0;
 elseif (y(i,j)<=0 && y(i,j+1)>0)
       y_rcv(i,j)= 0;
       y_rcv(i,j+1)=1;
 elseif (y(i,j)>0 && y(i,j+1)<=0)
       y_rcv(i,j)= 1;
       y_rcv(i,j+1)=0;
 else
       y_rcv(i,j)= 1;
       y_rcv(i,j+1)=1;
 end
 end
end

% Symbol Error Rate
symbol_error=0;
for i=1:l
 for j=1:m
        if(bit_seq(i,j)~=y_rcv(i,j))
            symbol_error=symbol_error+1;
                break
        end 
 end
end

SER(a)=symbol_error/l;

% Bit Error Rate
bit_error=0;
for i=1:l
 for j=1:m
        if(bit_seq(i,j)~=y_rcv(i,j))
            bit_error=bit_error+1;
        end
 end
end

BER(a)=bit_error/l;

SNR(a)=snr;
snr=snr+2;
end

%eb=1;
%n0=0;
%Pe=zeros(1,5);
%Pb=zeros(1,5);
%SNR_theo=zeros(1,5);
%for i=1:5
    %N0=10^(n0/10);
   %Pe(i)=2*qfunc(sqrt(2*eb/N0))-qfunc(sqrt(2*eb/N0)).^2;
   %Pb(i)=qfunc(sqrt(2*eb/N0))/2;
   %SNR_theo(i)=10*log10(eb/N0);
   %n0=n0-2;
%end

figure;
subplot(121);
semilogy(SNR_theo,Pe,'bo-');hold on;
semilogy(SNR,SER,'ro-');
xlabel('SNR');
ylabel('SER');
legend('Theoretical','Simulation');
grid on;
subplot(122);
semilogy(SNR_theo,Pb,'bo-');hold on;
semilogy(SNR,BER,'ro-');
xlabel('SNR');
ylabel('BER');
legend('Theoretical','Simulation');
grid on;
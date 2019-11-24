%Wireless Communication Assignment #3
%Question #5
%2-PAM SER and BER

%Transmit Bitstream
clear vals

l=1000;
m=1;
bit_seq =zeros(m,l);

for i=1:l

        bit_seq(i)=round(rand);
end

x=zeros(m,l);
for i=1:l
 
 if (bit_seq(i)==0)
       x(i)= -1;
 else
       x(i)= 1;  
 end
 end

%Receive bitstream
snr=0;
SNR=zeros(4,1);
SER=zeros(4,1);
BER=zeros(4,1);
for a=1:4

y=awgn(complex(x),snr);
y_real=real(y);
%y_imag=imag(y);

y_rcv=zeros(m,l);
for i=1:l
 if (y_real(i)>0.5)
       y_rcv(i)= 1;     
 else
       y_rcv(i)= 0;       
 end
 end

% Symbol Error Rate
symbol_error=0;
for i=1:l
        if(bit_seq(i)~=y_rcv(i))
            symbol_error=symbol_error+1;
        end 
 end

SER(a)=symbol_error/l;

% Bit Error Rate


SNR(a)=snr;
snr=snr+2;

end

eb=1;
n0=0; %in dB scale
Pe=zeros(1,5);
SNR_theo=zeros(1,5);
p=input('Enter the value of p:');

for i=1:4
    
    N0=10^(n0/10);
   Pe(i)= qfunc(p*sqrt(2*eb/N0));
   SNR_theo(i)=10*log10(eb/N0);
   n0=n0-2;
end


   
figure;

semilogy(SNR_theo,Pe,'bo-');hold on;
semilogy(SNR,SER,'ro-');
xlabel('SNR');
ylabel('SER');
legend('Theoretical','Simulation');
grid on;



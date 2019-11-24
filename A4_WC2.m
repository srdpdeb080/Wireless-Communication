%Wireless Communication Assignment #4
%Name: Souradeep Deb
%Roll No: 2019702004
%Question #2

N = 10000; 

bit_seq1 =zeros(1,N);
bit_seq2 =zeros(1,N);

%Transmit Bitstream

for i=1:N

        bit_seq1(i)=round(rand);
end
for i=1:N

        bit_seq2(i)=round(rand);
end


x1=zeros(1,N);
x2=zeros(1,N);

for i=1:N
 
 if (bit_seq1(i)==0)
       x1(i)= -1;
 else
       x1(i)= 1;  
 end
end

for i=1:N
 
 if (bit_seq2(i)==0)
       x2(i)= -1;
 else
       x2(i)= 1;  
 end
end

%Received Bitstream

BER1=zeros(1,21);
BER2=zeros(1,21);
for snr = 0:1:20 %dB
    snr_invdB = 10^(snr/10); 
    nvar = 1/(snr_invdB);
    
    y=zeros(1,N);
    y1=zeros(1,N);
    y2=zeros(1,N);
    s1=zeros(1,N);
    s2=zeros(1,N);
    for i = 1:N 
            n1 = sqrt(nvar/2)*randn; 
            n2 = sqrt(nvar/2)*randn; 
            h1 = sqrt(0.5)*abs(randn + 1i*randn); 
            h2 = sqrt(0.5)*abs(randn + 1i*randn);
            ar1=abs(h1)/(abs(h1)^2+abs(h2)^2);
            ar2=abs(h2)/(abs(h1)^2+abs(h2)^2);
            
            
            %Transmitter Diversity
            y(i) = ar1*abs(h1)*x1(i)+ar2*abs(h2)*x1(i)+ ar1*abs(h1)*n1 + ar2*abs(h2)*n2; 
            
            %Alamouti Scheme
            y1(i)=h1*x1(i)+h2*x2(i)+n1;
            y2(i)=-h1*x2(i)+h2*x1(i)+n2;
            
            s1(i)=h1*y1(i)+h2*y2(i);
            s2(i)=h2*y1(i)-h1*y2(i);
    end
    
    
    y_rcv=zeros(1,N);
    y_rcv1=zeros(1,N);
    y_rcv2=zeros(1,N);
    

 
for i=1:N
 if (y(i)>0)
       y_rcv(i)= 1;     
 else
       y_rcv(i)= 0;       
 end
end

for i=1:N
 if (s1(i)>0)
       y_rcv1(i)= 1;     
 else
       y_rcv1(i)= 0;       
 end
end

for i=1:N
 if (s2(i)>0)
       y_rcv2(i)= 1;     
 else
       y_rcv2(i)= 0;       
 end
end

% Bit Error Rate

error1=0;
for j=1:N
        if(bit_seq1(j)~=y_rcv(j))
            error1=error1+1;
        end 
end

error2=0;
for j=1:N
        if(bit_seq1(j)~=y_rcv1(j))
            error2=error2+1;
        end 
end
 
error3=0;
for j=1:N
        if(bit_seq2(j)~=y_rcv2(j))
            error3=error3+1;
        end 
end
 
error4=(error2+error3)/2;


BER1(snr+1)=error1/N;
BER2(snr+1)=error4/N;            
end    


figure;
snr=0:1:20; 
gamma = 10.^(snr./10);
BER= (1/2)*(1 - sqrt(gamma ./ (gamma + 1))); 
semilogy(snr,BER1,'r*-',snr,BER2,'c-o',snr,BER,'b'); grid on;
legend('Transmitter Diversity','Alamouti Scheme','No Diversity');
xlabel('SNR(dB)') 
ylabel('Bit error rate') 
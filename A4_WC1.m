%Wireless Communication Assignment #4
%Name: Souradeep Deb
%Roll No: 2019702004
%Question #1

N = 10000; 
m=1;
bit_seq =zeros(m,N);

for i=1:N

        bit_seq(i)=round(rand);
end

x=zeros(m,N);
for i=1:N
 
 if (bit_seq(i)==0)
       x(i)= -1;
 else
       x(i)= 1;  
 end
 end
BER1=zeros(1,21);
BER2=zeros(1,21);
BER3=zeros(1,21);
for snr = 0:1:20 %dB
    snr_invdB = 10^(snr/10); 
    nvar = 1/(snr_invdB); 
    error1 = 0; %Equal Gain Error
    error2 = 0; %Maximal Ratio Combining Error
    error3 = 0; %Selection Combining Error
            for i = 1:N 
            n1 = sqrt(nvar/2)*randn; 
            n2 = sqrt(nvar/2)*randn; 
            h1 = sqrt(0.5)*abs(randn + 1i*randn); 
            h2 = sqrt(0.5)*abs(randn + 1i*randn); 
            %Equal Gain combining
            y1 = x*h1+n1; 
            y2 = x*h2+n2; 
            y_equal = 0.5*(y1+y2); 
            %Maximal Ratio combining
            a1 = (abs(h1))^2;
            a2 = (abs(h2))^2;
            y_maximal = x*(a1*h1+a2*h2)+a1*n1+a2*n2;
            %Selection combining
            P1 = chi2rnd(4);
            P2 = chi2rnd(4);
            as1 = P1*(abs(h1))^2;
            as2 = P2*(abs(h2))^2;
            if as1 >= as2
                y_selection = x*(as1*h1)+as1*n1;
            end
            if as1 < as2
                y_selection = x*(as2*h2)+as2*n2;
            end
            
            %Error Calculation
            if y_equal < 0 
                error1 = error1 + 1;
            end
            if y_maximal < 0 
                error2 = error2 + 1;
            end
            if y_selection < 0 
                error3 = error2 + 1;
            end
            end
    BER1(snr+1) = error1/(N);
    BER2(snr+1) = error2/(N);
    BER3(snr+1) = error3/(N);
end

figure;
snr=0:1:20; 
mu = 10.^(snr./10);
ber_theo = (1/2)*(1 - sqrt(mu ./ (mu + 1))); 
semilogy(snr,BER1,'r*-',snr,BER2,'b--o',snr,BER3,'c-o',snr,ber_theo,'b'); grid on;
legend('Equal Gain','Maximal Ratio','Selection Combining','No Diversity');
xlabel('SNR(dB)') 
ylabel('Bit error rate') 
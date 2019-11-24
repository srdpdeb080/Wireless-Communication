%Wireless Communication Assignment #3
%Question #4
bit_count = 1000;

SNR = 0: 1: 40;

for a = 1: 1: length(SNR)
    errors = 0;
    bits = 0;
    
    while errors < 100
        
        bit_seq = round(rand(1,bit_count));
        % 2-PAM modulator
        tx = -2*(bit_seq-0.5);
    
       
        N0 = 1/10^(SNR(a)/10);
        
        % Rayleigh channel fading
        h = 1/sqrt(2)*randn(1,length(tx)) + 1i*randn(1,length(tx)); 
        
        rx = h.*tx + sqrt(N0/2)*(randn(1,length(tx))+1i*randn(1,length(tx)));
        rx = rx./h;
        
       
        rx1 = rx < 0;
    
        
        diff = bit_seq - rx1;
        errors = errors + sum(abs(diff));
        bits = bits + length(bit_seq);
        
    end
    
    BER(a) = errors / bits;
    
end
  

% Rayleigh Theoretical BER
snr_antilog = 10.^(SNR/10);
BER_theo_Rayleigh = 0.5.*(1-sqrt(snr_antilog./(snr_antilog+1)));

%Plot
figure(1);
semilogy(SNR,BER_theo_Rayleigh,'-');
hold on;

figure;
semilogy(SNR,BER,'ro-');
hold on;
xlabel('SNR (dB)');
ylabel('BER');
title('SNR Vs BER plot for 2-PAM Modualtion in Rayleigh Channel');
% Theoretical BER

BER_theo_AWGN = 0.5*erfc(sqrt(10.^(SNR/10)));
semilogy(SNR,BER_theo_AWGN,'blad-','LineWidth',2);
legend('Theoretical Rayleigh','Simulated Rayleigh', 'Theoretical AWGN');
axis([0 40 10^-5 0.5]);
grid on;
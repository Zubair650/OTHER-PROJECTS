clc;
clear all;
close all;
Transmitted_Message= '19-39745-1';
% Covert the message to bit %
VAL1 = 94500;
VAL2 = 410; 
x = asc2bin(Transmitted_Message); % Binary Information
VAL1Bin = de2bi(VAL1);
bp =.000001;
% Bit period
disp('Binary Information at Transmitter :');
disp(Transmitted_Message);
disp(x);
% Representation of transmitting binary information as digital signal %
bit=[]; 
for n=1:1:length(VAL1Bin)
    if VAL1Bin(n)==1;
       se=ones(1,100);
    else VAL1Bin(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];
end
t1=bp/100:bp/100:100*length(VAL1Bin)*(bp/100);
subplot(3,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(VAL1Bin) -.5 6]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Converting VAl1 To Digital Signal'); 
%XXX Binary-PSK Modulation XXXX&
data_NZR=2*x-1; 
s_p_data=reshape(data_NZR,2,length(x)/2); 
br=10.^6; % Bit rate 
f=br; % carrier frequency
T=1/br; 
t=T/99:T/99:T;

%MODULATION WITH QPSK
y=[]; 
y_in=[]; 
y_qd=[]; 
for(i=1:length(x)/2) 
y1=s_p_data(1,i)*cos(2*pi*f*t); 
y2=s_p_data(2,i)*sin(2*pi*f*t); 
y_in=[y_in y1]; 
y_qd=[y_qd y2]; 
y=[y y1+y2]; 
end 
Tx_signal=y; 
tt=T/99:T/99:(T*length(x))/2;
subplot(4,1,3);
plot(tt,y);
axis([ 0 bp*length(x)  -.5 6]);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Modulated Signal');

%SNR
snry=randn(size(Tx_signal))*std(Tx_signal)/db2mag(VAL2); 
disp('SNR value'); 
disp(snr(Tx_signal,snry)); 
%QPSK DEMODULATION 
mn=[]; 
Rx_signal=Tx_signal; 
for(i=1:length(x)/2) 
Z_in=Rx_signal((i-1)*length(t)+1:i*length(t)).*cos(2*pi*f*t); 
Z_in_intg=(trapz(t,Z_in))*(2/T); 
if(Z_in_intg>0) 
Rx_in_data=1; 
else 
Rx_in_data=0; 
end 
Z_qd=Rx_signal((i-1)*length(t)+1:i*length(t)).*sin(2*pi*f*t); 
Z_qd_intg=(trapz(t,Z_qd))*(2/T); 
if(Z_qd_intg>0) 
Rx_qd_data=1; 
else 
Rx_qd_data=0; 
end 
mn=[mn Rx_in_data Rx_qd_data]; 
end 
figure(2) 
stem(mn,'linewidth',2) 
title('Demodulated Signal'); % Converting Information bit to Massage %
axis([ 0 11 0 1.5]),grid on; 
Received_Message=bin2asc(mn); 
disp(' Conversion of the Information bit to Message'); 
disp(Received_Message);

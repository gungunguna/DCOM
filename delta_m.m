%% Delta Modulation (DM)
%delta modulation = 1-bit differential pulse code modulation (DPCM)
predictor = [0 1]; % y(k)=x(k-1)
%partition = [-1:.1:.9];codebook = [-1:.1:1];
step=0.2; %SFs>=2pifA
partition = [0];
codebook = [-1*step step]; %DM quantizer
t = [0:pi/20:4*pi];
x = 1.1*sin(2*pi*0.6*t); % Original signal, a sine wave
%t = [0:0.1:2*pi];x = 4*sin(t);
%x=exp(-1/3*t);
%x = sawtooth(3*t); % Original signal
% Quantize x(t) using DPCM.
encodedx = dpcmenco(x,codebook,partition,predictor);
% Try to recover x from the modulated signal.
decodedx = dpcmdeco(encodedx,codebook,predictor);
distor = sum((x-decodedx).^2)/length(x) % Mean square error
% plots
figure,
subplot(3,1,1);
plot(t,x);
xlabel('Time');
title('Original signal');
subplot(3,1,2);
stairs(t,10*codebook(encodedx+1),'--');
xlabel('Time');
title('DM output');
subplot(3,1,3);
plot(t,x);
hold;
stairs(t,decodedx);
grid;
xlabel('Time');
title('Received signal');
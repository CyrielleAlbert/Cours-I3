%%% EFFET AUDIO 1 %%%
Fe = 44100;
Fn = Fe/2;
F_low = 250;
F_high = 4000;
W1 = F_low/Fn;
W2 = F_high/Fn;

[num_low,den_low] = butter(4,W1,'low');
[num_high,den_high] = butter(4,W2,'high');
[num_band,den_band] = butter(4,[W1, W2]);

freqz(num_low,den_low)
freqz(num_high,den_high)
freqz(num_band,den_band)


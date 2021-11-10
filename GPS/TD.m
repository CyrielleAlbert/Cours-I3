% TD 1 
% On est des récepteus GPS
% Réception de 2 signaux: 
%  - N = 3 10h28' 34,567"
%  - N = 15 10h29' 34,765"

%Déterminer les pseudo-distances 
load('TD_correlateur.mat')

t = (1:1:1023)';
figure(1),clear figure,subplot(211)
d = (-1022:1:1022)';

corr1_ = xcorr(PRN1,incoming_signal_1);
corr2_ = xcorr(PRN2,incoming_signal_1);
corr3_ = xcorr(PRN3,incoming_signal_1);

plot(d,[corr1_,corr2_+100,corr3_+200])
legend("PRN1","PRN2","PRN3")

% Observations de pic plus importants sur la corrélation entre PRN3 et le
% signal 1 donc le signal 1 provient du satellite 1
subplot(212)
corr1_2 = xcorr(PRN1,incoming_signal_2);
corr2_2 = xcorr(PRN2,incoming_signal_2);
corr3_2 = xcorr(PRN3,incoming_signal_2);

plot(d,[corr1_2,corr2_2+100,corr3_2+200])
legend("PRN1","PRN2","PRN3")
% Observations de pic plus importants sur la corrélation entre PRN2 et le
% signal 2 donc le signal 2 provient du satellite 2

%Calculer la position D sachant que A = 45 000km

%% Devoir de traitement du signal, filtrage optimal
close all
close all

%% Définitions de variables
b1 = [1 -1.7119 0.81];
a1 = [1 -1.1168 0.9025];
b2 = [1 -2.0923 1.21];
a2 = [1 -1.6042 0.9025];
b3 = [1 -2.1 1.08];
a3 = [1 -1.7119 0.81];

impuls = zeros(1000, 1);
impuls(1) = 1;
r = randi([0 3],1,1000) - 1.5;
e = repelem(r, 10);
seq_len = length(e);
%% Filtrage du signal NRZ sur les canaux
close all;
filtered1 = filter(b1, a1, e);
filtered2 = filter(b2, a2, e);
filtered3 = filter(b3, a3, e);
figure(1);
plot(e);
figure(2);
plot(filtered1);
figure(3);
plot(filtered2);
figure(4);
plot(filtered3);

%% Affichage des signaux filtrés
close all
figure(1);
plot(filtered1)
title('Signal NRZ filtré par le canal 1');
figure(2);
plot(filtered2)
title('Signal NRZ filtré par le canal 2');
figure(3);
plot(filtered3)
title('Signal NRZ filtré par le canal 3');

%% Diagrammes de l'oeil
close all;
eyediagram(e, 30);
eyediagram(filtered1, 30);
eyediagram(filtered2, 30);
eyediagram(filtered3, 30);


%% Zplane
close all
figure(1);
zplane(a1, b1);
title('pole (x) et zeros (o) de la fonction de transfert inverse du canal 1');
figure(2);
zplane(a2, b2);
title('pole (x) et zeros (o) de la fonction de transfert inverse du canal 2');
figure(3);
zplane(a3, b3);
title('pole (x) et zeros (o) de la fonction de transfert inverse du canal 3');

%% Réponse impulsionnelle des filtres inverses
close all;
unf1 = filter(a1, b1, impuls);
unf2 = filter(a2, b2, impuls);
unf3 = filter(a3, b3, impuls);

figure(1);
plot(unf1);
title('Réponse impulsionnelle du filtre égaliseur pour le canal 1');
figure(2);
plot(unf2);
title('Réponse impulsionnelle du filtre égaliseur pour le canal 2');
figure(3);
plot(unf3);
title('Réponse impulsionnelle du filtre égaliseur pour le canal 3');


%% Approximation par FIR
close all;
N = 500;
R = 10;

rep1 = [zeros(R, 1); unf1(1:N)];
rep2 = [zeros(R, 1); unf2(1:N)];
rep3 = [zeros(R, 1); unf3(1:N)];
recon1 = filter(rep1, [1], filtered1);
recon2 = filter(rep2, [1], filtered2);
recon3 = filter(rep3, [1], filtered3);

figure(1);
plot(recon1);
title(sprintf('Canal %d N = %d R = %d', 1, N, R));

figure(2);
plot(recon2);
title(sprintf('Canal %d N = %d R = %d', 2, N, R));

figure(3);
plot(recon3);
title(sprintf('Canal %d N = %d R = %d', 3, N, R));

eyediagram(recon1, 30);
title('Eye diagram 1');
eyediagram(recon2, 30);
title('Eye diagram 2');
eyediagram(recon3, 30);
title('Eye diagram 3');

%% Wiener
close all;
R = 30;
N = 100;
d = [zeros(1, R) e(1:end-R)];
d_full = d;
d = d(1:N);

x1 = filtered1(1:N);
x2 = filtered2(1:N);
x3 = filtered3(1:N);

corr1 = xcorr(d, x1);
corr1 = corr1(N:end);
autocorr1 = xcorr(x1, x1);
autocorr1 = autocorr1(N:end);

corr2 = xcorr(d, x2);
corr2 = corr2(N:end);
autocorr2 = xcorr(x2, x2);
autocorr2 = autocorr2(N:end);

corr3 = xcorr(d, x3);
corr3 = corr3(N:end);
autocorr3 = xcorr(x3, x3);
autocorr3 = autocorr3(N:end);

Cxx1 = zeros([N, N]);
Cxd1 = zeros([N, N]);
Cxx2 = zeros([N, N]);
Cxd2 = zeros([N, N]);
Cxx3 = zeros([N, N]);
Cxd3 = zeros([N, N]);

for i = 1:N
    for j = 1:N
        Cxx1(i, j) = autocorr1(abs(i - j) + 1);
        Cxd1(i, j) = corr1(abs(i - j) + 1);
        Cxx2(i, j) = autocorr2(abs(i - j) + 1);
        Cxd2(i, j) = corr2(abs(i - j) + 1);
        Cxx3(i, j) = autocorr3(abs(i - j) + 1);
        Cxd3(i, j) = corr3(abs(i - j) + 1);
    end
end

Cxxinv1 = inv(Cxx1);
Cxxinv2 = inv(Cxx2);
Cxxinv3 = inv(Cxx3);

coeff_matrix1 = Cxd1 * Cxxinv1;
coeff_matrix2 = Cxd2 * Cxxinv2;
coeff_matrix3 = Cxd3 * Cxxinv3;

x_norm1 = x1 - mean(x1);
x_norm2 = x2 - mean(x2);
x_norm3 = x3 - mean(x3);

coeffs1 = coeff_matrix1(1, :);
estim1_2 = filter(coeffs1, [1], filtered1);

coeffs2 = coeff_matrix2(1, :);
estim2_2 = filter(coeffs2, [1], filtered2);

coeffs3 = coeff_matrix3(1, :);
estim3_2 = filter(coeffs3, [1], filtered3);

estim1 = coeff_matrix1 * x_norm1';
estim2 = coeff_matrix2 * x_norm2';
estim3 = coeff_matrix3 * x_norm3';

figure(1);
subplot 211;
hold on;
plot(estim1);
plot(d);
title(sprintf('%d premiers termes', N));
subplot 212;
%plot(estim1 - d');
hold on
plot(estim1_2(500:1500));
plot(d_full(500:1500));
title('Termes 500 à 1500');

figure(2);
subplot 211;
hold on;
plot(estim2);
plot(d);
title(sprintf('%d premiers termes', N));
subplot 212;
% plot(estim2 - d');
hold on
plot(estim3_2(500:1500));
plot(d_full(500:1500));
title('Termes 500 à 1500');

figure(3);
subplot 311;
hold on;
plot(estim3);
plot(d);
title(sprintf('%d premiers termes', N));
subplot 312;
% plot(estim3 - d');
hold on
plot(estim3_2(500:1500));
plot(d_full(500:1500));
title('Termes 500 à 1500');
subplot 313;
erreur = abs(estim3_2 - d_full);
plot(erreur(500:1500));
title('Erreur absolue');

%% LMS
d = d_full;

mu = 2e-3; 
coef_init = randn(1,N);
[sortie,erreur,coefs] = lms(filtered1,d,coef_init,mu,N);

figure()
plot(coefs)
hold on
plot(coeffs1)
title('Comparaison des coefficiant LMS(bleu) et WIENER(rouge)');
figure()

plot(sortie)
hold on
plot(d)
title('Entrainement avec les 100 premiers termes et mu = 2e-3')
figure()
subplot 211
plot(sortie(seq_len-400:seq_len))
hold on
plot(d(seq_len-400:seq_len));
title('400 termes après entrainement');
subplot 212
plot(abs(erreur(seq_len-400:seq_len)));
title('Erreur absolue');

eyediagram(sortie(seq_len-1200:seq_len),30);
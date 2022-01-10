%% DM Filtrage Optimal %%

%% Analyse théorique de la problématique de l’égalisation
%% 2.2.1 Étude expérimentale de la transmission d’un code M-aire NRZ sur un canal à bande passante limitée

%Création d'un code NRZ 4 états à valeur moyenne nulle
%Le signal peut prendre les valeurs [1, -1, 3, -3]
Fs = 1e3;
Fe = 10*Fs;
N = 200;
N1 = 70; N2 = 70; N3 = 30; N4 = 30;
numbers = [ones(1,N1)*1, ones(1,N2)*-1,ones(1,N3)*3,ones(1,N4)*-3];
v = numbers(randperm(length(numbers)));
e_k = [];
for i=1:N
    a = ones(1,10)*v(i);
    e_k = cat(2,e_k,a);
end
figure(1)
x_k = (0:1/Fe:(N*10-1)*1/Fe)';
plot(x_k,e_k)
% Test : 
length = length(e_k)
mean = mean(e_k) % Vérification que la moyenne du code NRZ est nulle

% Calcul de la DSP du signal
NFFT = 2^12;
Nw =50;
[dsp_x,f] = pwelch(e_k,Nw,[],NFFT,1,'twosided');
figure(2),clf
plot(f-0.5,fftshift(dsp_x))


% Réponse impulsionelle
impulsion = zeros(N*10,1);
impulsion(1) = 1;
% Cas 1
num1 = [1,-1.7119,0.8100];
denum1 = [1,-1.1168,0.9025];
rep_imp_1 = filter(num1,denum1,impulsion);
t = (0:1/Fe:(N*10-1)*1/Fe)';
figure(3),clf, 
subplot(321)
plot(t,rep_imp_1)
title("Réponse impulsionnelle du Canal 1")
% Cas 2
num2 = [1,-2.0923,1.2100 ];
denum2 = [1,-1.6042,0.9025];
rep_imp_2 = filter(num2,denum2,impulsion);
subplot(323)
plot(t,rep_imp_2)
title("Réponse impulsionnelle du Canal 2")
% Cas 3
num3 = [1,-2.1000 ,1.0800 ];
denum3 = [1,-1.7119,0.8100];
rep_imp_3 = filter(num3,denum3,impulsion);
subplot(325)
plot(t,rep_imp_3)
title("Réponse impulsionnelle du Canal 3")


%Réponse en fréquence
%Cas 1 
[H1,F] = freqz(num1,denum1,N*10, Fe);
subplot(322)
plot(F,20*log(abs(H1)))
title("Réponse en fréquence du Canal 1")
%Cas 2 
[H2,F] = freqz(num2,denum2,N*10, Fe);
subplot(324)
plot(F,20*log(abs(H2)))
title("Réponse en fréquence du Canal 2")
%Cas 3
[H3,F] = freqz(num3,denum3,N*10, Fe);
subplot(326)
plot(F,20*log(abs(H3)))
title("Réponse en fréquence du Canal 3")

% Conclusion: 
% Les 3 canaux ont un effet de perturbateur sur le signal envoyé à travers.

% Génération des signaux de sortie des canaux
v1_filtered = filter(num1,denum1,v);
v2_filtered = filter(num2,denum2,v);
v3_filtered = filter(num3,denum3,v);
figure(4),clf,
subplot(311)
t1 = (0:1/Fs:(N-1)*1/Fs);
plot(t1,v1_filtered,t1,v)
legend("Signal filtré par C1","Signal initial")
title("Filtrage dans le Canal 1 du formant élémentaire servant à créer le code NRZ")
subplot(312)
plot(t1,v2_filtered,t1,v)
legend("Signal filtré par C2","Signal initial")
title("Filtrage dans le Canal 2 du formant élémentaire servant à créer le code NRZ")
subplot(313)
plot(t1, v3_filtered,t1,v)
legend("Signal filtré par C3","Signal initial")
title("Filtrage dans le Canal 3 du formant élémentaire servant à créer le code NRZ")

% Observations 
% On remarque que le formant lui même est modifié suite à son passage dans
% le Canal. Par conséquence, le code NRZ subira également des
% modifications dans l'amplitude du code 
% entrainant des interférences entre les symboles.

% Signaux de sortie des canaux 1,2 et 3
x1_k = filter(num1,denum1,e_k);
x2_k = filter(num2,denum2,e_k);
x3_k = filter(num3,denum3,e_k);
figure(5),clf
plot(t,[x1_k ; x2_k+10 ; x3_k+20])
legend("Signal filtré par le Canal 1","Signal filtré par le Canal 2","Signal filtré par le Canal 3")
title("Visualisation des signaux en sortie des canaux 1,2 et 3")

% Diagrammes de l'oeil
% Diagramme de l'oeil du code NRZ
eyediagram(e_k,10);
% Diagrammes de l'oeil de l'oeil du code NRZ filtré par les canaux 1,2 et 3
eyediagram(x1_k,10);
eyediagram(x2_k,10);
eyediagram(x3_k,10);

%% Détermination théorique de la réponse impulsionnelle d’un filtre égaliseur
close all
% Carte des pôles et des zéros des filtres Hc(z) des canaux 1,2 et 3
figure(1),clf,
subplot(321)
zplane(num1,denum1)
title("Carte des pôles et des zéros du filtre Hc(z) du canal 1")
subplot(322)
zplane(denum1,num1)
title("Carte des pôles et des zéros du filtre He(z) du canal 1")
subplot(323)
zplane(num2,denum2)
title("Carte des pôles et des zéros du filtre Hc(z) du canal 2")
subplot(324)
zplane(denum2,num2)
title("Carte des pôles et des zéros du filtre He(z) du canal 2")
subplot(325)
zplane(num3,denum3)
title("Carte des pôles et des zéros du filtre Hc(z) du canal 3")
subplot(326)
zplane(denum3,num3)
title("Carte des pôles et des zéros du filtre He(z) du canal 3")
%% Réponses Impulsionnelles des filtres Egaliseurs
RI_eg1 = filter(denum1,num1,impulsion);
RI_eg2 = filter(denum2,num2,impulsion);
RI_eg3 = filter(denum3,num3,impulsion);

% Visualisation des RI des filtres Egaliseurs

figure(2),clf,
subplot(311)
plot(t, RI_eg1)
title("Réponse Imp du filtre Egaliseur du Canal 1")
subplot(312)
plot(t,RI_eg2)
title("Réponse Imp du filtre Egaliseur du Canal 2")
subplot(313)
plot(t,RI_eg3)
title("Réponse Imp du filtre Egaliseur du Canal 3")






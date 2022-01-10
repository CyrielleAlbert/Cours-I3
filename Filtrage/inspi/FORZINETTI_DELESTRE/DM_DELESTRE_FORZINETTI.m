%% DM Filtrage Optimal %%


%% Initialisation des variables
clc
clear all
close all

NMC=1e6;
A=1;

%% 2.2.1.1
%% Generation du signal

signal = randi([-2*A,2*A],1,NMC);
zerofound = find(signal);
Signal_entree = signal(zerofound);
Signal2 = repmat(Signal_entree,10,1);
Signal2 = reshape(Signal2,1,size(Signal_entree,2)*10);
Signal_principal = mean(Signal_entree);


%% DSP

[mDSP,f] = pwelch(Signal2);

Fs = f(length(f));

figure (1)
plot(f,mDSP);


%% Génération du canal

num1 = [1,-1.7119,0.8100];
num2 = [1,-2.0923,1.2100];
num3 = [1,-2.1000,1.0800];
den1 = [1,-1.1168,0.9025];
den2 = [1,1.6042,0.9025];
den3 = [1,-1.7119,0.8100];



Sortie_canal1 = filter(num1,den1,Signal_entree);
Sortie_canal2 = filter(num2,den2,Signal_entree);
Sortie_canal3 = filter(num3,den3,Signal_entree);

%% Réponse fréquentielle pour les 3 cas

impuls=[1;zeros(1000,1)];

reponse_Cas1= filter(num1,den1,impuls);
reponse_Cas2= filter(num2,den2,impuls);
reponse_Cas3= filter(num3,den3,impuls);

%% Visualisation de ces réponses fréquentielle

k=(0:length(impuls)-1);

figure(2)
subplot(3,1,1)
plot(k,reponse_Cas1,'o-');
title('Réponse impulsionelle canal 1')
subplot(3,1,2)
plot(k,reponse_Cas2,'o-');
title('Réponse impulsionelle canal 2')
subplot(3,1,3)
plot(k,reponse_Cas3,'o-');
title('Réponse impulsionelle canal 3')

%% 2.2.1.4
%% EyeDiagram


eyediagram(Signal_entree,floor(length(Signal_entree)/10));

%% 2.2.1.5
%% Eyediagram filtré


 eyediagram(Sortie_canal1,floor(length(Sortie_canal1)/10));
 eyediagram(Sortie_canal2,floor(length(Sortie_canal2)/10));
 eyediagram(Sortie_canal3,floor(length(Sortie_canal3)/10));



 
 %% 2.2.2 Détermination théorique de la réponse impulsionnelle d’un filtre égaliseur
 
 
 %% 2.2.2.1 Représentation de la carte de poles des 3 canaux

 
 figure(7)
 title('Ensemble des repésentations de la carte des poles')
 subplot(3,2,1)
 zplane(num1,den1);
 title('Canal 1 filtre')
 subplot(3,2,2)
 zplane(den1,num1);
 title('Canal 1 filtre inverse ')
 
 % Filtres canal 2
 subplot(3,2,3)
 zplane(num2,den2);
 title('Canal 2 filtre')
 subplot(3,2,4)
 zplane(den2,num2);
 title('Canal 2 filtre inverse ')
 
  % Filtres canal 3
 subplot(3,2,5)
 zplane(num3,den3);
 title('Canal 3 filtre')
 subplot(3,2,6)
 zplane(den3,num3);
 title('Canal 3 filtre inverse ')
 
 
 %% 2.2.2.2 Calcul des réponses impulsionelles des filtre égalisateurs
 
RI_egalisateur_cas1= filter(den1,num1,impuls);
RI_egalisateur_cas2= filter(den2,num2,impuls);
RI_egalisateur_cas3= filter(den3,num3,impuls);

% Représentation de ces 3 réponses impulsionelles

figure(8)
subplot(3,1,1)
plot(k,RI_egalisateur_cas1,'o-');
title('Réponse impulsionelle canal 1')
subplot(3,1,2)
plot(k,RI_egalisateur_cas2,'o-');
title('Réponse impulsionelle canal 2')
subplot(3,1,3)
plot(k,RI_egalisateur_cas3,'o-');
title('Réponse impulsionelle canal 3')

%% 2.2.2.3



%% 2.2.2.5

N1 =20;
R1 = 1;
N2 =20;
R2 = 980;
N3 =20;
R3 = 980;


Egalisateur1=RI_egalisateur_cas1(R1:R1+N1);
Egalisateur2=RI_egalisateur_cas2(R2:R2+N2);
Egalisateur3=RI_egalisateur_cas3(R3:R3+N3);

k3=(0:length(Egalisateur1)-1);

figure(9)
subplot(3,1,1)
plot(k3,Egalisateur1,'o-');
title('Réponse impulsionelle canal 1')
subplot(3,1,2)
plot(k3,Egalisateur2,'o-');
title('Réponse impulsionelle canal 2')
subplot(3,1,3)
plot(k3,Egalisateur3,'o-');
title('Réponse impulsionelle canal 3')



y1 = conv(Sortie_canal1,Egalisateur1);
y2 = conv(Sortie_canal2,Egalisateur2);
y3 = conv(Sortie_canal3,Egalisateur3);

k3=(0:length(Signal_entree(1:500))-1);
k2=(0:length(y1(1:500))-1);
figure(10)
subplot(3,2,1)
plot(k3,Signal_entree(21:520),'o-');
subplot(3,2,2)
plot(k2,y1(1:500),'o-');

subplot(3,2,3)
plot(k3,Signal_entree(21:520),'o-');
subplot(3,2,4)
plot(k2,y2(1:500),'o-');

subplot(3,2,5)
plot(k3,Signal_entree(21:520),'o-');
subplot(3,2,6)
plot(k2,y3(1:500),'o-');

% Diagramme d'oeil

 eyediagram(y1,floor(length(y1)/10));
 eyediagram(y2,floor(length(y2)/10));
 eyediagram(y3,floor(length(y3)/10));
 

 
 %% 2.2.2.6 Excitation par bruit blanc
 
 % Soit un bruit blanc
 B=randn(NMC,1);
yB1 = conv(B,Egalisateur1);
yB2 = conv(B,Egalisateur2);
yB3 = conv(B,Egalisateur3);

figure(11)
subplot(3,2,1)
plot(k3,B(41:540),'o-');
subplot(3,2,2)
plot(k2,yB1(1:500),'o-');

subplot(3,2,3)
plot(k3,B(41:540),'o-');
subplot(3,2,4)
plot(k2,yB2(1:500),'o-');

subplot(3,2,5)
plot(k3,B(41:540),'o-');
subplot(3,2,6)
plot(k2,yB3(1:500),'o-');


%% 2.2.3 Égalisation par filtrage de WIENER causal


%% 2.2.3.3

% Nous allons choisir N = 100 pour cet excercice
N=100;

X1 = filter(num1,den1,B);
X2 = filter(num2,den2,B);
X3 = filter(num3,den3,B);



d= B;


phi_xx1=xcorr(X1,X1,N,'biased');
phi_xx2=xcorr(X2,X2,N,'biased');
phi_xx3=xcorr(X2,X2,N,'biased');

%Calcul matric autocorr alors
% -N à N, donc 2N+1 au total : on enregsitre la partie positive de la
% corrélation pour la première ligne de la matrice
Matrice_Autocor1 = toeplitz(phi_xx1(N+1: 2*N+1));
Matrice_Autocor2 = toeplitz(phi_xx2(N+1: 2*N+1));
Matrice_Autocor3 = toeplitz(phi_xx3(N+1: 2*N+1));

% Calcul de Rd
phi_xd1= xcorr(d , X1 , N ,'biased');
phi_xd2= xcorr(d , X2 , N ,'biased');
phi_xd3= xcorr(d , X3 , N ,'biased');

Rxd1 = phi_xd1(N+1 : 2*N+1);
Rxd2 = phi_xd2(N+1 : 2*N+1);
Rxd3 = phi_xd3(N+1 : 2*N+1);

%% 2.2.3.4 Calculons Hopt

H_OPT1 = Matrice_Autocor1 \ Rxd1 ;
H_OPT2 = Matrice_Autocor2 \ Rxd2 ;
H_OPT3 = Matrice_Autocor3 \ Rxd3 ;


%% 2.2.3.5

yB1= filter(H_OPT1 , 1, X1);
yB2= filter(H_OPT2 , 1, X2);
yB3= filter(H_OPT3 , 1, X3);


 eyediagram(B, floor(length(B/10)));
 eyediagram(yB1,floor(length(yB1)/10));
 eyediagram(yB2,floor(length(yB2)/10));
 eyediagram(yB3,floor(length(yB3)/10));


%% NRZ
% Nombre de points
N1=100
N2=100;
N3=15;
% retard
R1=0;
R2=100;
R3=100;
X1 = filter(num1,den1,Signal_entree');
X2 = filter(num2,den2,Signal_entree');
X3 = filter(num3,den3,Signal_entree');

%signal désiré avec induction d'un retard R

d1= Signal_entree';
d2= [zeros(1,R2),Signal_entree]';
d3= [zeros(1,R3),Signal_entree]';
% calcul de la première ligne de Rxx pour appliquer toeplitz après
phi_xx1=xcorr(X1,X1,N1,'biased');
phi_xx2=xcorr(X2,X2,N2,'biased');
phi_xx3=xcorr(X2,X2,N3,'biased');

% Calcul matrice autocorr alors
% -N à N, donc 2N+1 au total : on enregsitre la partie positive de la
% corrélation pour la première ligne de la matrice
Matrice_Autocor1 = toeplitz(phi_xx1(N1+1: 2*N1+1));
Matrice_Autocor2 = toeplitz(phi_xx2(N2+1: 2*N2+1));
Matrice_Autocor3 = toeplitz(phi_xx3(N3+1: 2*N3+1));

X11=X1;
X12=[X2',zeros(1,R2)]';
X13=[X3',zeros(1,R3)]';
% Calcul de Rd
phi_xd1= xcorr(d1 , X11 , N1 ,'biased');
phi_xd2= xcorr(d2 , X12 , N2 ,'biased');
phi_xd3= xcorr(d3 , X13 , N3 ,'biased');

Rxd1 = phi_xd1(N1+1 : 2*N1+1);
Rxd2 = phi_xd2(N2+1 : 2*N2+1);
Rxd3 = phi_xd3(N3+1 : 2*N3+1);

%% 2.2.3.4 Calculons Hopt

H_OPT1 = Matrice_Autocor1 \ Rxd1 ;
H_OPT2 = Matrice_Autocor2 \ Rxd2 ;
H_OPT3 = Matrice_Autocor3 \ Rxd3 ;


%% 2.2.3.5
% Filtrons alors l'entrée par l'égalisateur et comparons avec notre signal
% désiré
yB1= filter(H_OPT1 , 1, X1);
yB2= filter(H_OPT2 , 1, X2);
yB3= filter(H_OPT3 , 1, X3);

eyediagram(Signal_entree, floor(length(Signal_entree/10)));
 eyediagram(yB1,floor(length(yB1)/10));
 eyediagram(yB2,floor(length(yB2)/10));
 eyediagram(yB3,floor(length(yB3)/10));
 
 

 
 %% 2.3 Égalisation adaptative
 
 %% 2.3.1 Égalisation linéaire adaptative à l’aide de l’algorithme LMS


 %% 2.3.1.2
 % Economiser de la mémoire
 entree1=X1(1:10000);
 entree2=X2(1:10000);
 entree3=X3(1:10000);
 
 desire1=d1(1:10000);
 desire2=d2(1:10000);
 desire3=d3(1:10000);
 %Calculons mu max
mu_max1= 1/(N1*mean(mDSP)); 
mu_max2= 1/(N2*mean(mDSP));
mu_max3= 1/(N3*mean(mDSP));

%Utilisation : [sortie,erreur,coefs] = lms_c(entree,desire,coefs_init,mu,nb_coefs_enregistres)
[y1,erreur1,coefs1]=lms_c(entree1,desire1,zeros(N1,1),mu_max1/10,length(entree1));
[y2,erreur2,coefs2]=lms_c(entree2,desire2,zeros(N2,1),mu_max2/10,length(entree2));
[y3,erreur3,coefs3]=lms_c(entree3,desire3,zeros(N3,1),mu_max3/10,length(entree3));

%% 2.3.1.3 Bruit blanc

X1 = filter(num1,den1,B);
X2 = filter(num2,den2,B);
X3 = filter(num3,den3,B);
entree1=X1(1:10000);
entree2=X2(1:10000);
entree3=X3(1:10000);

d1= B;
d2= [zeros(1,R2),B']';
d3= [zeros(1,R3),B']';

 desire1=d1(1:10000);
 desire2=d2(1:10000);
 desire3=d3(1:10000);

 %Calculons mu max
mu_max1= 1/(N1*var(entree1)); 
mu_max2= 1/(N2*var(entree2));
mu_max3= 1/(N3*var(entree3));

%Utilisation : [sortie,erreur,coefs] = lms_c(entree,desire,coefs_init,mu,nb_coefs_enregistres)
[y1,erreur1,coefs1]=lms_c(entree1,desire1,zeros(N1,1),mu_max1/10,length(entree1));
[y2,erreur2,coefs2]=lms_c(entree2,desire2,zeros(N2,1),mu_max2/10,length(entree2));
[y3,erreur3,coefs3]=lms_c(entree3,desire3,zeros(N3,1),mu_max3/10,length(entree3));


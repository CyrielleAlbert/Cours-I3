%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   FICHIER :       kalman_scalaire_nonstationnaire.m
%
%   BUT :           Démonstration des possibilités offertes par le filtre de KALMAN
%                   pour reconstruire les états d'un système. Le problème considéré
%                   ici est scalaire et non stationnaire. Nous utilisons
%                       1) l'algorithme de KALMAN de prédiction à un pas
%                       2) l'algorithme de d'estimation de l'état courant
%                   La non stationnarité est introduite par un coefficient
%                   A(k) qui varie dans le temps :
%                           A(k) = A0*sin(2*pi*fA*k) + mu_A
%
%   AUTEUR :        GUY PLANTIER (ESEO)
%
%   DATE :          Novembre 1998
%
%   REFERENCES :    Cours d'automatique avancée pour AII - ESEO
%                   Cours de filtrage optimal TST - ESEO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Définition des constantes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 400;               % Nombre de points utilisés pour la simulation

A0 = 0.3;              % Amplitude des oscillations du coefficient A(k)
mu_A = 0.8;             % moyenne des oscillations du coefficient A(k)
fA = 1/100;             % Fréquences des oscillations du coefficient A(k)
B = 5;
C = 0.5;
f0 = 1/50;              % Fréquence du signal sinusoidal d'excitation

var_W_reel = 1;         % Puissance du bruit d'état réel excitant le système
var_V_reel = 100000;     % Puissance du bruit de mesure réel excitant le système
X0_reel = 0;            % x(0) réel

var_W_kalman = 1;       % Puissance du bruit d'état utilisé pour le filtrage de Kalman
var_V_kalman = 100000;   % Puissance du bruit de mesure utilisé pour le filtrage de Kalman
X0_kalman = 0;        % x(0) estimé
P0_kalman = 0;         % p(0) estimé

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création du vecteur temps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = (0:N-1)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création du vecteur des coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = A0*sin(2*pi*fA*k) + mu_A;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création des vecteurs de bruit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W = sqrt(var_W_reel)*randn(N,1);
V = sqrt(var_V_reel)*randn(N,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création des vecteurs d'exitation U(k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

U = sin(2*pi*f0*k);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création des vecteurs X et Y pour les simulations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = zeros(N,1);
X(1) = X0_reel;
for m = 1:N-1
   X(m+1) = A(m)*X(m)+ B*U(m) + W(m);
end

Y = C*X+V;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Présentation de X et Y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
clf
plot(k,X,k,Y,k,C*X,'Linewidth',2)
%title('Etat X(k+1) = A(k)*X(k)+ B*U(k) + W(k) (jaune)  -  Obsevation Y(k) = C*X(k)+V(k) (magenta)  -  Partie non bruitée C*X(k) (cyan)')
xlabel('Temps : k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création et initialisation des vecteurs d'état estimés par l'algorithme
% de prédiction et d'estimation d'état courant, du vecteur
% de mesure estimé, du vecteur des gains de KAMAN et du vecteur P(k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_est_courant = zeros(N,1);     % Contiendra toutes les valeurs de l'estimation d'état courant
X_est_pred = zeros(N,1);        % Contiendra toutes les valeurs de l'estimation d'état prédit


L = zeros(N,1);                 % Contiendra toutes les valeurs prises au cours du temps par
                                % la matrice de gain de KALMAN L(k) qui est dans notre cas un scalaire
P = zeros(N,1);                 % Contiendra toutes les valeurs prises au cours du temps par la matrice
                                % de covariance de l'erreur de prédiction à un pas P(k|k-1) (scalaire)

P(1) = P0_kalman;               % Initialisation du premier élément du vecteur P à P(0|-1)=P0_kalman
X_est_pred(1) = X0_kalman;      % Initialisation du premier élément du vecteur X_est_pred() à
                                % X(0|-1)=X0

L(1) = P(1)*C*(C*P(1)*C+var_V_kalman)^(-1);                    % Initialisation du gain de KALMAN L
X_est_courant(1) = X_est_pred(1)+L(1)*(Y(1)-C*X_est_pred(1));  % Initialisation de X(0|0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Estimation de l'état du système à l'aide d'un filtre de KALMAN
% de prédiction à un pas et d'un filtre de KALMAN
% d'estimation d'état courant
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for m = 1:N-1
    P(m+1) = A(m)*(1-L(m)*C)*P(m)*A(m)+var_W_kalman;
    L(m+1) = P(m+1)*C*(C*P(m+1)*C+var_V_kalman)^(-1);
    X_est_pred(m+1) = A(m)*X_est_courant(m) + B*U(m);
    X_est_courant(m+1) = X_est_pred(m+1)+L(m+1)*(Y(m+1)-C*X_est_pred(m+1));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Présentation de X, X_est_pred et X_est_courant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
clf
subplot(211)
plot(k,X,k,X_est_pred,k,X_est_courant,'Linewidth',2)
axe_courants = axis;
%title('Etat du système (jaune)   -    Etat du système par KALMAN prédicteur (magenta)-   Etat du système par KALMAN courant (cyan)')
xlabel('Temps : k')
subplot(212)
plot(k,(X-X_est_courant),'Linewidth',2)
axis(axe_courants);
%title('Erreur d''estimation d''état courrant : \epsilon (k) = X(k)-X_{est}(k|k)')
xlabel('Temps : k')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Présentation du gain de Kalman L(k) et du  vecteur P(k|k-1) = E[(X(k)-X_est(k|k-1))^2]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3)
clf
subplot(211)
plot(k,L,'Linewidth',2)
%title('Gain de Kalman L(k)')
xlabel('Temps : k')
subplot(212)
plot(k,P,'Linewidth',2)
%title('P(k|k-1) = E[(X(k)-X_{est}(k|k-1))^2]')
xlabel('Temps : k')

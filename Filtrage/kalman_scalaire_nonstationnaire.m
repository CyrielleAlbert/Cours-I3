%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   FICHIER :       kalman_scalaire_nonstationnaire.m
%
%   BUT :           D�monstration des possibilit�s offertes par le filtre de KALMAN
%                   pour reconstruire les �tats d'un syst�me. Le probl�me consid�r�
%                   ici est scalaire et non stationnaire. Nous utilisons
%                       1) l'algorithme de KALMAN de pr�diction � un pas
%                       2) l'algorithme de d'estimation de l'�tat courant
%                   La non stationnarit� est introduite par un coefficient
%                   A(k) qui varie dans le temps :
%                           A(k) = A0*sin(2*pi*fA*k) + mu_A
%
%   AUTEUR :        GUY PLANTIER (ESEO)
%
%   DATE :          Novembre 1998
%
%   REFERENCES :    Cours d'automatique avanc�e pour AII - ESEO
%                   Cours de filtrage optimal TST - ESEO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�finition des constantes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 400;               % Nombre de points utilis�s pour la simulation

A0 = 0.3;              % Amplitude des oscillations du coefficient A(k)
mu_A = 0.8;             % moyenne des oscillations du coefficient A(k)
fA = 1/100;             % Fr�quences des oscillations du coefficient A(k)
B = 5;
C = 0.5;
f0 = 1/50;              % Fr�quence du signal sinusoidal d'excitation

var_W_reel = 1;         % Puissance du bruit d'�tat r�el excitant le syst�me
var_V_reel = 100000;     % Puissance du bruit de mesure r�el excitant le syst�me
X0_reel = 0;            % x(0) r�el

var_W_kalman = 1;       % Puissance du bruit d'�tat utilis� pour le filtrage de Kalman
var_V_kalman = 100000;   % Puissance du bruit de mesure utilis� pour le filtrage de Kalman
X0_kalman = 0;        % x(0) estim�
P0_kalman = 0;         % p(0) estim�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation du vecteur temps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = (0:N-1)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation du vecteur des coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = A0*sin(2*pi*fA*k) + mu_A;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation des vecteurs de bruit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W = sqrt(var_W_reel)*randn(N,1);
V = sqrt(var_V_reel)*randn(N,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation des vecteurs d'exitation U(k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

U = sin(2*pi*f0*k);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation des vecteurs X et Y pour les simulations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = zeros(N,1);
X(1) = X0_reel;
for m = 1:N-1
   X(m+1) = A(m)*X(m)+ B*U(m) + W(m);
end

Y = C*X+V;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pr�sentation de X et Y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
clf
plot(k,X,k,Y,k,C*X,'Linewidth',2)
%title('Etat X(k+1) = A(k)*X(k)+ B*U(k) + W(k) (jaune)  -  Obsevation Y(k) = C*X(k)+V(k) (magenta)  -  Partie non bruit�e C*X(k) (cyan)')
xlabel('Temps : k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation et initialisation des vecteurs d'�tat estim�s par l'algorithme
% de pr�diction et d'estimation d'�tat courant, du vecteur
% de mesure estim�, du vecteur des gains de KAMAN et du vecteur P(k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_est_courant = zeros(N,1);     % Contiendra toutes les valeurs de l'estimation d'�tat courant
X_est_pred = zeros(N,1);        % Contiendra toutes les valeurs de l'estimation d'�tat pr�dit


L = zeros(N,1);                 % Contiendra toutes les valeurs prises au cours du temps par
                                % la matrice de gain de KALMAN L(k) qui est dans notre cas un scalaire
P = zeros(N,1);                 % Contiendra toutes les valeurs prises au cours du temps par la matrice
                                % de covariance de l'erreur de pr�diction � un pas P(k|k-1) (scalaire)

P(1) = P0_kalman;               % Initialisation du premier �l�ment du vecteur P � P(0|-1)=P0_kalman
X_est_pred(1) = X0_kalman;      % Initialisation du premier �l�ment du vecteur X_est_pred() �
                                % X(0|-1)=X0

L(1) = P(1)*C*(C*P(1)*C+var_V_kalman)^(-1);                    % Initialisation du gain de KALMAN L
X_est_courant(1) = X_est_pred(1)+L(1)*(Y(1)-C*X_est_pred(1));  % Initialisation de X(0|0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Estimation de l'�tat du syst�me � l'aide d'un filtre de KALMAN
% de pr�diction � un pas et d'un filtre de KALMAN
% d'estimation d'�tat courant
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for m = 1:N-1
    P(m+1) = A(m)*(1-L(m)*C)*P(m)*A(m)+var_W_kalman;
    L(m+1) = P(m+1)*C*(C*P(m+1)*C+var_V_kalman)^(-1);
    X_est_pred(m+1) = A(m)*X_est_courant(m) + B*U(m);
    X_est_courant(m+1) = X_est_pred(m+1)+L(m+1)*(Y(m+1)-C*X_est_pred(m+1));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pr�sentation de X, X_est_pred et X_est_courant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
clf
subplot(211)
plot(k,X,k,X_est_pred,k,X_est_courant,'Linewidth',2)
axe_courants = axis;
%title('Etat du syst�me (jaune)   -    Etat du syst�me par KALMAN pr�dicteur (magenta)-   Etat du syst�me par KALMAN courant (cyan)')
xlabel('Temps : k')
subplot(212)
plot(k,(X-X_est_courant),'Linewidth',2)
axis(axe_courants);
%title('Erreur d''estimation d''�tat courrant : \epsilon (k) = X(k)-X_{est}(k|k)')
xlabel('Temps : k')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pr�sentation du gain de Kalman L(k) et du  vecteur P(k|k-1) = E[(X(k)-X_est(k|k-1))^2]
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

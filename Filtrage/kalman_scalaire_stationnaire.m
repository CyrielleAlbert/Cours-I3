%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   FICHIER :       kalman_scalaire_stationnaire.m
%
%   BUT :           D�monstration des possibilit�s offertes par le filtre de KALMAN
%                   pour reconstruire les �tats d'un syst�me. Le probl�me consid�r�
%                   ici est scalaire et stationnaire. Nous utilisons
%                       1) l'algorithme de KALMAN de pr�diction � un pas
%                       2) l'algorithme de d'estimation de l'�tat courant
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

N = 4000;                % Nombre de points utilis�s pour la simulation

A = 0.8;                % Matrice d'�tat A (pour cet exemple un scalaire)
B = 5;                  % Matrice B (pour cet exemple un scalaire)
C = 2;                  % Matrice C (pour cet exemple un scalaire)

var_W_reel = 2;        % Puissance du bruit d'�tat r�el excitant le syst�me
var_V_reel = 10000;     % Puissance du bruit de mesure r�el excitant le syst�me
X0_reel = 0;            % x(0) r�el

var_W_kalman = 2;      % Puissance du bruit d'�tat utilis� pour le filtrage de Kalman
var_V_kalman = 10000;   % Puissance du bruit de mesure utilis� pour le filtrage de Kalman
X0_kalman = 200;        % x(0) estim�
P0_kalman = 50000;          % p(0) estim� P contient la puissance de l'erreur d'estimation
% p0 est un parametre qui permet de traduire la confiance que l'on a dans
% x0


f0 = 1/50;              % Fr�quence du signal sinuso�dal d'excitation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation du vecteur temps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = (0:N-1)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation des vecteurs de bruit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W = sqrt(var_W_reel)*randn(N,1);
V = sqrt(var_V_reel)*randn(N,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation des vecteurs d'excitation U(k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%U = ones(N,1);
U = sin(2*pi*f0*k) > 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation des vecteurs X et Y pour les simulations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = zeros(N,1);
X(1) = X0_reel;
for m = 1:N-1
   X(m+1) = A*X(m)+ B*U(m) + W(m);      % Equation d'�tat
end

Y = C*X+V;                              % Equation d'observation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pr�sentation de X et Y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
clf
% plot(k,X,'y-',k,Y,'m:',k,C*X,'c--')
plot(k,X,k,Y,k,C*X,'Linewidth',2)
%title('Etat X(k+1) = A*X(k)+ B*U(k) + W(k) (jaune)  -  Observation Y(k) = C*X(k)+V(k) (magenta)  -  Partie non bruit�e C*X(k) (cyan)')
xlabel('Temps : k')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation et initialisation des vecteurs d'�tat estim�s par l'algorithme
% de pr�diction et d'estimation d'�tat courant, du vecteur
% de mesure estim�, du vecteur des gains de KAMAN et du vecteur P(k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_est_courant = zeros(N,1);     % Contiendra toutes les valeurs de l'estimation d'�tat courant
X_est_pred = zeros(N,1);        % Contiendra toutes les valeurs de l'estimation d'�tat pr�dit

L = zeros(N,1);     % Contiendra toutes les valeurs prises au cours du temps par
                    % de la matrice de gain de KALMAN L(k) qui est dans notre cas un scalaire
P = zeros(N,1);     % Contiendra toutes les valeurs prises au cours du temps par la matrice
                    % de covariance de l'erreur de pr�diction � un pas P(k|k-1) (scalaire)

P(1) = P0_kalman;           % Initialisation du premier �l�ment du vecteur P � P(0|-1)=P0_kalman
X_est_pred(1) = X0_kalman;  % Initialisation du premier �l�ment du vecteur X_est_pred() �
                            % X(0|-1)=X0

L(1) = P(1)*C'*(C*P(1)*C'+var_V_kalman)^(-1);                     % Initialisation du gain de KALMAN L
X_est_courant(1) = X_est_pred(1)+L(1)*(Y(1)-C*X_est_pred(1));  % Initialisation de X(0|0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Estimation de l'�tat du syst�me � l'aide d'un filtre de KALMAN
% de pr�diction � un pas et d'un filtre de KALMAN
% d'estimation d'�tat courant
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for m = 1:N-1
    P(m+1) = A*(1-L(m)*C)*P(m)*A+var_W_kalman;
    L(m+1) = P(m+1)*C*(C*P(m+1)*C+var_V_kalman)^(-1);
    X_est_pred(m+1) = A*X_est_courant(m) + B*U(m);
    X_est_courant(m+1) = X_est_pred(m+1)+L(m+1)*(Y(m+1)-C*X_est_pred(m+1));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pr�sentation de X, X_est_pred et X_est_courant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
clf
subplot(211)
% plot(k,X,'y-',k,X_est_pred,'m:',k,X_est_courant,'c--')
plot(k,X,k,X_est_pred,k,X_est_courant,'Linewidth',2)
axe_courants = axis;
%title('Etat du syst�me (jaune)   -    Etat du syst�me par KALMAN pr�dicteur (magenta)   -   Etat du syst�me par KALMAN courant (cyan)')
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
plot(k,P,'Linewidth',2')
%title('P(k|k-1) = E[(X(k)-X_{est}(k|k-1))^2]')
xlabel('Temps : k')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul d'une estimation de la variance de l'erreur d'estimation courante
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% estim_var_err_estim = sum((X-X_est_courant).^2)/N
estim_var_err_estim = var(X(floor(N/2):N)-X_est_courant(floor(N/2):N))
var_err_estim = P(N)
ecart_type = sqrt(P(N))

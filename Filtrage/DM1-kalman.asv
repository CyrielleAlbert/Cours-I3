% Simulation de la situation Apollo

%% Simulation de x(t)- la chute de la capsule-, v(t) - le bruit - et y(t) le signal capté par le radar.
a = -1/2*9.81 ; v0 = 100; x0 = 10000; K = 1000;
t = (0:0.1:(K-1)*0.1)'; 

v_t = 1000*randn(K,1);
x_t = a*t.^2 + v0*t+x0;
y_t = x_t + v_t;
%% Filtrage du bruit

M = [t.^2 , t , ones(size(t))];
theta = M\y_t;
x_estim = M*theta; %filtrage du bruit

figure(1),clf,plot(t,[y_t x_t x_estim])
%% Calcul de l'instant t_plouf pour lequel la capsule touchera l'eau
racines = roots(theta);
t_plouf = racines(racines>0);


%% MONTE CARLO - Répétition de la simulation avec Monté-Carlo et visualisation de l'évolution de t_plouf

NMC = 10000;
t_ploufs = zeros(NMC,1);
for k=1:NMC
    k
    v_t = 1000*randn(K,1);
    x_t = a*t.^2 + v0*t+x0;
    y_t = x_t + v_t;
    theta = M\y_t;
    x_estim = M*theta; %filtrage du bruit
    racines = roots(theta);
    t_plouf = racines(racines>0);
    t_ploufs(k) = t_plouf;
end

k = (1:NMC)';
figure(2),clf,plot(k,t_ploufs)

%% Calcul de l'espérence mathématique et de la variance des t_ploufs
esperence = mean(t_ploufs)
variance = var(t_ploufs)

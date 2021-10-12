NMC = 10e5; K =  100;
x = 9.4+ 2*randn(NMC,K);
Estim_moy_CM1 = mean(x,2);
Esp_math_estim_moy = mean(Estim_moy_CM1);
%%
a = 1:5;
b = cumsum(a,2);
var_x = 5;K_max =1000; NMC = 10000; x = 9.4+sqrt(var_x)*randn(NMC,K_max);
tic;
Estim_moy = cumsum(x,2);
toc;
K = 1:K_max; for xi = 1:NMC,Estim_moy(xi,:)=Estim_moy(xi,:)./K;end

figure(1),clf,plot(Estim_moy(1:5000,:)'),grid on, zoom on

Moy_stat_estim_moy = mean(Estim_moy,1);
Var_stat_estim_moy = var(Estim_moy,1);
%% Voyage vers les Moindres carrés
mu_THEO = 9.4; var_b = 3;K = 100; x_obs = mu_THEO + sqrt(var_b)*randn(K,1);
figure(1),hold on,plot(x_obs)
theta = (0:0.01:20)'; 
J_L1 = zeros(length(theta),1); J_L2 = zeros(length(theta),1);
for kk=1:length(theta), J_L1(kk) = sum(abs(x_obs-theta(kk))); J_L2(kk) = sum((x_obs-theta(kk)).^2);end
figure(2), hold on,plot(theta,J_L1),figure(3),hold on,plot(theta,J_L2)

%% Exo x_obs = ak+b+bruit
a_theo = 2; b_theo=8; K = 100; 
t = (0:K-1)';
x_obs = a_theo*t + b_theo + randn(K,1);
figure(1),clf,plot(t,x_obs)

a = (0:0.01:20)';
b = (0:0.01:20)'; 
J_L1 = zeros(length(a),length(b));
J_L2 = zeros(length(a),length(b));
for ka=1:length(a)
    for kb = 1:length(b)
        x_test = a(ka)*t+b(kb);
        J_L1(ka,kb) = sum(abs(x_obs-x_test));
        J_L2(ka,kb) = sum((x_obs-x_test).^2);
    end
end

figure(2),clf,mesh(a,b,log(J_L1))% meilleure visualisation avec log
figure(3),clf,mesh(a,b,log(J_L2))
figure(4),clf,contour(a,b,log(J_L2),100)
%% Exemple 3 : Sinusoidal
A_theo = 2; alpha_theo = 4.5;  K = 100; k =(0:K-1)'; f0 = 0.05;
x_obs = A_theo*sin(2*pi*f0*k+alpha_theo) + 0.5*randn(K,1);
figure(1),clf,plot(k,x_obs)

A = (-5:0.1:5)';
alpha = (0:0.1:2*pi)';
J_L1 = zeros(length(A),length(alpha));
J_L2 = zeros(length(A),length(alpha));


for ka=1:length(A)
    for kb = 1:length(alpha)
        x_test = A(ka)*sin(2*pi*f0*k+alpha(kb));
        J_L1(ka,kb) = sum(abs(x_obs-x_test));
        J_L2(ka,kb) = sum((x_obs-x_test).^2);
    end
end

figure(2),clf,mesh(alpha,A,J_L1)
%% Résolution d'équa lin x,y
M = [3 2; 1 -1; 1 -5];
V = [5; 4;9];
theta_opt = M\V

%% Résolution avec \ - Exemple 1 - y = cste + bruit
K = 100; x_OBS = 9.4 + 2*randn(K,1);
moy_CM1 = mean(x_OBS);
M = [ones(K,1)];
moy_PINV = pinv(M)*x_OBS;
moy_slash = M\x_OBS;


%% Résolution avec \ - Exemple 2 - y = ax+b + bruit
K = 100; t = (0:0.1:10-0.1)'; x_OBS = 3*t+5+2*randn(K,1);
a = ones(1,K);

M = [t, ones(size(t))];
theta = M\x_OBS

%% Résolution avec \ - Exemple 3 - y = ax^2+bx+c

K = 1000; t = (0:0.01:10-0.01)'; x_OBS = 3*t.^2-20*t+6+ 4*randn(K,1);
M = [t.^2 , t , ones(size(t))];
theta = M\x_OBS

x_theo = M*theta;
figure(1),clf,plot(t,[x_OBS x_theo]);

%% Résolution avec \ - Exemple 4 - y = A sin (2PI f0 t + alpha) + B + bruit

K = 1000; t = (0:K-1)';f0 = 0.01;
A = 3; alpha = 2.5; B = 6;

x1 = A*cos(alpha)*sin(2*pi*f0*t);
x2 = A*sin(alpha)*cos(2*pi*f0*t);
x_theo = A*sin(2*pi*f0*t+alpha);

x_OBS = x1 +x2  + 9.4*randn(K,1);

M = [cos(2*pi*f0*t), sin(2*pi*f0*t), ones(size(t))];
theta = M\x_OBS
x = M*theta;
A_est = sqrt(theta(1)^2+theta(2)^2)
alpha_est = atan2(theta(2),theta(1))

figure(1),clf,plot(t, [x_OBS x_theo x])
%%
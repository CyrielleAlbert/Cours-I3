x = 4*cos(2*pi*0.05*(0:20000)'+12.45);
figure(1),clf,plot(x)

[phi_xx,LAGS] = xcorr(x,x,"biased");
[phi_xx_B, LAGS] = xcorr(x,x,"unbiased");
%%
N = 10e6; var_x = 2^2; var_b = 4^2;
x = sqrt(var_x)*randn(N,1);
b = sqrt(var_b)*randn(N,1);
[num, den] = butter( 2, 2*[0.05 0.1]);
impuls = [1; zeros(1000,1)]; k = (0:length(impuls)-1)';
RI_theo = filter(num,den,impuls);
figure(1),clf,plot(k,RI_theo)
y = filter(num,den,x);
M = 1000;
[phi_xx,LAGS]= xcorr(x,x,M,"biased");
figure(2),clf,plot([b,x,y])
%%
[phi_xb,LAGS]= xcorr(b,x,M,'biased');
z = y+b;
[phi_xy,LAGS] = xcorr(y,x,M,'biased');
[phi_xz,LAGS] = xcorr(z,x,M,'biased');
hello = var_x*RI_theo;
figure(3),clf, plot(LAGS,[phi_xx,phi_xy+20],k,hello+20)
%%
RI_estim_inter_corr = phi_xy/var_x;
figure(1),clf,plot(k,[impuls, RI_theo+2],LAGS,RI_estim_inter_corr+4)

%% Bruit non blanc
var_a = 3^2;
a_k = sqrt(var_a)* randn(N,1); %Bruit blanc de variance 2

alpha = 0.95;
den = [1 -alpha];
num = 1;
x2_k = filter(num,den,a_k);%définition du bruit coloré
figure(1),clf,plot(x)
Nh = 100;
[num,den] = butter(2,2*[0.05 0.1]);
y = filter(num,den,x2_k);

[phi_xx,LAGS]= xcorr(x2_k,x2_k,Nh,"biased");
[phi_xy,LAGS] = xcorr(y,x2_k,Nh,'biased');

matr_autocor_x = toeplitz(phi_xx(Nh+1:2*Nh+1));
figure(2),clf,mesh(matr_autocor_x)
figure(3),clf,plot(LAGS, [phi_xx,phi_xy]), grid on , zoom on

RI_estim_wiener_hoff = matr_autocor_x \ phi_xy(Nh+1:2*Nh+1)
impuls = [1; zeros(Nh,1)]; k = (0:length(impuls)-1)';
RI_theo = filter(num,den,impuls);
figure(4),clf,plot(k,[RI_theo RI_estim_wiener_hoff]),grid on, zoom on


%% Bruit blanc
var_x = 2^2;
N = 10e6; M = 100;
x = sqrt(var_n)*randn(N,1);
[num,den] = butter(2,2*[0.05 0.1]);
impuls = [1; zeros(M,1)]; k = (0:length(impuls)-1)';
RI_theo = filter(num,den,impuls);
figure(1),clf,plot(k,RI_theo)
y = filter(num,den,x);
[phi_xx,LAGS]= xcorr(x,x,M,"biased");
[phi_xy,LAGS] = xcorr(y,x,M,'biased');

figure(2),clf, plot(LAGS,[phi_xx,phi_xy+20])
Matr_Autocor_x = toeplitz(phi_xx(M+1:2*M+1));

RI_estim_wiener_hoff = inv(Matr_Autocor_x) * phi_xy(M+1:2*M+1);
figure(3),clf, plot(LAGS,[phi_xx,phi_xy+20],k,RI_estim_wiener_hoff)

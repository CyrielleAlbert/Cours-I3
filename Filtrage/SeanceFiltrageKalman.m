%% Discretisation avec la méthode d'EULER
A = 3.5; alpha = 1.15;
f0 =1/200; k = (0:2000)';
x1_theo = A*cos(2*pi*f0*k + alpha);
x2_theo = A*sin(2*pi*f0*k + alpha);
figure(1),clf,plot(k,[x1_theo x2_theo])
Mat_etat = [1 , -2*pi*f0; 2*pi*f0,1];
X = zeros(2,length(k));
X(1,1) = A*cos(alpha);
X(2,1) = A*sin(alpha);
for ll=1:length(k)-1
    X(:,ll+1)= Mat_etat* X(:,ll);    
end

figure(2),clf,plot(k,[x1_theo],k,X(1,:)')
%% Equa d'état discrette sans discretisation 
A = 3.5; alpha = 1.15;
f0 =1/200; k = (0:2000)';
x1_theo = A*cos(2*pi*f0*k + alpha);
x2_theo = A*sin(2*pi*f0*k + alpha);
figure(1),clf,plot(k,[x1_theo x2_theo])
Mat_etat = [cos(2*pi*f0) , -sin(2*pi*f0); sin(2*pi*f0),cos(2*pi*f0)];
X = zeros(2,length(k));
X(1,1) = A*cos(alpha);
X(2,1) = A*sin(alpha);
for ll=1:length(k)-1
    X(:,ll+1)= Mat_etat* X(:,ll);    
end

figure(2),clf,plot(k,[x1_theo],k,X(1,:)')
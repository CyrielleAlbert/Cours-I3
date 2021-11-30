load data.txt

%-------------------------------------------------------------------------------
% structure de data
%-------------------------------------------------------------------------------

t = data(:,1);
epoques = unique(data(:,1));
% data(:,2) : numéros des satellites
% data(:,3) : ranges corrigées
% data(:,4) : mesures Doppler
% data(:,5 à 7) : positions des satellites
% data(:,8 à 10) : vitesses des satellites

%-------------------------------------------------------------------------------
% calcul de position et vitesse ensemble avec code C1 et mesures Doppler D1
%-------------------------------------------------------------------------------

XYZTplus = nan+ones(length(epoques),8);

for i=1:length(epoques)
  f=find(t==epoques(i));
  nbsat = length(f);

  X2 = data(f,5);
  Y2 = data(f,6);
  Z2 = data(f,7);
  RC2 = data(f,3); % ranges corrigées

  VX2 = data(f,8);
  VY2 = data(f,9);
  VZ2 = data(f,10);
  D2 = data(f,4); % mesures Doppler

%%%TP%%% calcul de la solution %%%TP%%%
XYZTplus(i,:) = [X Y Z rckt VX VY VZ rcktdot];

if i==1
P1 = inv(H'*H);
X1 = XYZTplus(i,1);
Y1 = XYZTplus(i,2);
Z1 = XYZTplus(i,3);
end

end

%-------------------------------------------------------------------------------
% écriture d'un fichier kml
%-------------------------------------------------------------------------------

[longitude,latitude,h] = c2g_rgf(XYZTplus(:,1),XYZTplus(:,2),XYZTplus(:,3));
longitude=longitude*180/pi;
latitude=latitude*180/pi;

fid = fopen('traj_tmp.kml');
fid2 = fopen('traj.kml','w');

l=fgetl(fid);
while isempty(findstr(l,'coordinates'))
   fprintf(fid2,'%s\r\n',l); l=fgetl(fid);
end

fprintf(fid2,'%s\r\n',l);
fprintf(fid2,'%.8f,%.8f,0 ',[longitude latitude]');
fprintf(fid2,'\r\n');

l=fgetl(fid);
while l~=-1
   fprintf(fid2,'%s\r\n',l); l=fgetl(fid);
end

fclose all;

%-------------------------------------------------------------------------------
% filtre
%-------------------------------------------------------------------------------

etat = nan+ones(8,length(epoques));
P = nan+ones(8,8*length(epoques));

i = 1;
    
% initialisation du filtre (état et covariance à l'instant 1) et bruits des mesures

etat(:,i) = [XYZTplus(i,1) XYZTplus(i,5) XYZTplus(i,2) XYZTplus(i,6) XYZTplus(i,3) XYZTplus(i,7) XYZTplus(i,4) XYZTplus(i,8)]';

P(:,8*(i-1)+[1:8]) = [P1(1,1) P1(1,5) P1(1,2) P1(1,6) P1(1,3) P1(1,7) P1(1,4) P1(1,8);
	 P1(5,1) P1(5,5) P1(5,2) P1(5,6) P1(5,3) P1(5,7) P1(5,4) P1(5,8);
	 P1(2,1) P1(2,5) P1(2,2) P1(2,6) P1(2,3) P1(2,7) P1(2,4) P1(2,8);
	 P1(6,1) P1(6,5) P1(6,2) P1(6,6) P1(6,3) P1(6,7) P1(6,4) P1(6,8);
	 P1(3,1) P1(3,5) P1(3,2) P1(3,6) P1(3,3) P1(3,7) P1(3,4) P1(3,8);
	 P1(7,1) P1(7,5) P1(7,2) P1(7,6) P1(7,3) P1(7,7) P1(7,4) P1(7,8);
	 P1(4,1) P1(4,5) P1(4,2) P1(4,6) P1(4,3) P1(4,7) P1(4,4) P1(4,8);
	 P1(8,1) P1(8,5) P1(8,2) P1(8,6) P1(8,3) P1(8,7) P1(8,4) P1(8,8)];

p_pr = 7.5; %en m
p_dop = 0.4; %en m/s
r_rho_pr = p_pr^2; %en m²
r_rho_dop = p_dop^2; %en (m/s)²

% filtrage

for i=2:length(epoques)

    delta_t = epoques(i)-epoques(i-1);

    % coefficients à régler et calcul pour déterminer la matrice de variance du modèle
    Sp=1; %en (m/s)²/s
    Sf=1; %en m²/s
    Sg=1; %en (m/s)²/s
    
% reference: R. Grover Brown and Patrick Hwang, Introduction to Random Signals
% and Applied Kalman Filtering, 2nd ed., John Wiley & Sons, New York, 1992.

    % calcul
    qp3=(Sp*delta_t^3)/3; qp2=(Sp*delta_t^2)/2; qp1=Sp*delta_t;
    qg3=(Sg*delta_t^3)/3; qg2=(Sg*delta_t^2)/2; qg1=Sg*delta_t;
    qf1=Sf*delta_t + qg3;

    Q = [qp3 qp2  0   0   0   0   0   0;
         qp2 qp1  0   0   0   0   0   0;
          0   0  qp3 qp2  0   0   0   0;
          0   0  qp2 qp1  0   0   0   0;
          0   0   0   0  qp3 qp2  0   0;
          0   0   0   0  qp2 qp1  0   0;
          0   0   0   0   0   0  qf1 qg2;
          0   0   0   0   0   0  qg2 qg1];

%%%TP%%% prédiction %%%TP%%%
PHI = eye(8,8);
PHI(1,2) =delta_t;
PHI(3,4) =delta_t;
PHI(5,6) =delta_t;
PHI(7,8) =delta_t;
etatpredit = FHI*etat(:,i);
%%%TP%%% observations %%%TP%%%
    f=find(t==epoques(i));
    nbsat = length(f);
    
    X2 = data(f,5);
    Y2 = data(f,6);
    Z2 = data(f,7);
    RC2 = data(f,3); % ranges corrigées

    VX2 = data(f,8);
    VY2 = data(f,9);
    VZ2 = data(f,10);
    D2 = data(f,4); % mesures Doppler
    
    X=etatpredit(1); Y=etatpredit(2); Z=etatpredit(3);
    rckt=0;
    VX=0; VY=0; VZ=0; rcktdot=0;
    oldrckt=1;
    while abs(rckt-oldrckt)>1e-3
      mes = [];
      H = [];
      for j=1:nbsat
        mes = [mes;RC2(j)-norm([X Y Z]-[X2(j) Y2(j) Z2(j)])];
        H = [H;[([X Y Z]-[X2(j) Y2(j) Z2(j)])/(norm([X Y Z]-[X2(j) Y2(j) Z2(j)])) 1]];
      end
      mesdop = [];
      Hdop = [];
      for j=1:nbsat
        Rho = norm([X Y Z]-[X2(j) Y2(j) Z2(j)]);
        % Doppler prédits
        d1 = (X-X2(j))*(VX-VX2(j));
        d2 = (Y-Y2(j))*(VY-VY2(j));
        d3 = (Z-Z2(j))*(VZ-VZ2(j));
        doppred = -(d1 + d2 + d3)/Rho;
        % dérivées partielles sur Doppler 
        factx = (VX-VX2(j))/Rho;
        directiondopx = -factx + ((d1+d2+d3)*(X-X2(j)))/(Rho)^3;
        facty = (VY-VY2(j))/Rho;
        directiondopy = -facty + ((d1+d2+d3)*(Y-Y2(j)))/(Rho)^3;
        factz = (VZ-VZ2(j))/Rho;
        directiondopz = -factz + ((d1+d2+d3)*(Z-Z2(j)))/(Rho)^3;

        directiondopvx = (X2(j)-X)/Rho;
        directiondopvy = (Y2(j)-Y)/Rho;
        directiondopvz = (Z2(j)-Z)/Rho;

        mesdop = [mesdop;D2(j)*299792458/(1575.42*10^6)-doppred];
        Hdop = [Hdop;[directiondopx directiondopy directiondopz 0 directiondopvx directiondopvy directiondopvz -1]];
      end
      H = [[H zeros(nbsat,4)];Hdop];
      mes = [mes;mesdop];
    end
end

%-------------------------------------------------------------------------------
% écriture d'un fichier kml
%-------------------------------------------------------------------------------

[longitude,latitude,h] = c2g_rgf(etat(1,:)',etat(3,:)',etat(5,:)');
longitude=longitude*180/pi;
latitude=latitude*180/pi;

fid = fopen('traj_tmp.kml');
fid2 = fopen('traj_ekf.kml','w');

l=fgetl(fid);
while isempty(findstr(l,'coordinates'))
   fprintf(fid2,'%s\r\n',l); l=fgetl(fid);
end

fprintf(fid2,'%s\r\n',l);
fprintf(fid2,'%.8f,%.8f,0 ',[longitude latitude]');
fprintf(fid2,'\r\n');

l=fgetl(fid);
while l~=-1
   fprintf(fid2,'%s\r\n',l); l=fgetl(fid);
end

fclose all;

%-------------------------------------------------------------------------------
% figures
%-------------------------------------------------------------------------------

t1 = epoques-epoques(1);

figure

subplot(2,4,1)
plot(t1,XYZTplus(:,1)-4201600)
hold on
plot(t1,etat(1,:)-4201600,'r')
xlabel('s'), ylabel('m'), title('X')

subplot(2,4,2)
plot(t1,XYZTplus(:,2)-174400)
hold on
plot(t1,etat(3,:)-174400,'r')
xlabel('s'), ylabel('m'), title('Y')

subplot(2,4,3)
plot(t1,XYZTplus(:,3)-4779400)
hold on
plot(t1,etat(5,:)-4779400,'r')
xlabel('s'), ylabel('m'), title('Z')

subplot(2,4,4)
plot(t1,XYZTplus(:,4))
hold on
plot(t1,etat(7,:),'r')
xlabel('s'), ylabel('m'), title('rckt')

subplot(2,4,5)
plot(t1,XYZTplus(:,5))
hold on
plot(t1,etat(2,:),'r')
xlabel('s'), ylabel('m/s'), title('VX')

subplot(2,4,6)
plot(t1,XYZTplus(:,6))
hold on
plot(t1,etat(4,:),'r')
xlabel('s'), ylabel('m/s'), title('VY')

subplot(2,4,7)
plot(t1,XYZTplus(:,7))
hold on
plot(t1,etat(6,:),'r')
xlabel('s'), ylabel('m/s'), title('VZ')

subplot(2,4,8)
plot(t1,XYZTplus(:,8))
hold on
plot(t1,etat(8,:),'r')
xlabel('s'), ylabel('m/s'), title('rcktdot')

[xf,yf,zf] = cart2tan(X1,Y1,Z1,etat(1,:),etat(3,:),etat(5,:));
[x,y,z] = cart2tan(X1,Y1,Z1,XYZTplus(:,1),XYZTplus(:,2),XYZTplus(:,3));

figure

subplot(2,4,1)
plot(t1,x)
hold on
plot(t1,xf,'r')
xlabel('s'), ylabel('m'), title('E')

subplot(2,4,2)
plot(t1,y)
hold on
plot(t1,yf,'r')
xlabel('s'), ylabel('m'), title('N')

subplot(2,4,3)
plot(t1,z)
hold on
plot(t1,zf,'r')
xlabel('s'), ylabel('m'), title('U')

subplot(2,4,4)
plot(t1,XYZTplus(:,4))
hold on
plot(t1,etat(7,:),'r')
xlabel('s'), ylabel('m'), title('rckt')

%-------------------------------------------------------------------------------
% fin de db2eseo
%-------------------------------------------------------------------------------

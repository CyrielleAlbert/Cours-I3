import numpy as np
import matplotlib.pyplot as plt

# Definition du random seed pour la reproductibilite
np.random.seed(7)
# Definition des exemples entrees / sorties
# Couples de valeurs en entree :
# [0,0], [0.1,0], [0.2,0], ... [0.9,0], [1,0], [0,0.1], [0.1,0.1], ...
E1 = np.repeat(np.linspace(0, 1, 11).reshape([1, 11]), 11, axis=0)
E1 = E1.reshape(121)
E2 = np.repeat(np.linspace(0, 1, 11), 11)
E = np.array([E1, E2])
# Sorties correspondantes
# 0, 0, 0, ... 1, 1, 0, 0, ...
Y = np.zeros(E.shape[1])
print(E.shape)
for n_exe in range(0, E.shape[1]):
    if (E[0, n_exe]>=0.5 and E[1,n_exe]<0.5) or (E[0, n_exe]<0.5 and E[1,n_exe]>=0.5):
        Y[n_exe] = 1

plt.figure(1)
for n_exe in range(0, E.shape[1]):
    plt.plot(E[0, n_exe], E[1, n_exe], '+', color=[Y[n_exe], 0, 0])
plt.grid()
plt.title('Cartographie de la fonction XOR')
plt.xlabel('Premiere entree')
plt.ylabel('Deuxieme entree')

# Definition du reseau de neurones
Ne = 2  # Nombre d'entrees
N  = 10  # Nombre de neurones caches
Ns = 1  # Nombre de sorties
V = np.random.rand(N,Ne)           # 3 neurones caches et 2 entrees
W = np.random.rand(Ns,N)           # 1 neurone de sortie et 3 entrees

# Algorithme d'entrainement
N_ite = 400                          # Nombre d'iterations de l'algorithme d'entrainement
N_exemples = E.shape[1]                # Nombre d'exemples d'entrainement
alpha = 0.5                            # Taux d'apprentissage
Err_quad_plot = np.zeros(N_ite)        # Vecteur pour enregistrer l'erreur a chaque iteration
Poids_cachees = np.zeros([N_ite,N*Ne]) # Vecteur pour enregistrer les poids a chaque iteration
Poids_sortie = np.zeros([N_ite,Ns*N])  # Vecteur pour enregistrer les poids a chaque iteration
for n_ite in range(0,N_ite):
    Err_quad = 0.0                   # Initialisation de l'erreur
    for n_exe in range(0,N_exemples):
        # Calcul des sorties de la couche cachee
        Sv = np.zeros(N)
        for n_neurone in range(0,N):
            for n_entree in range(0,Ne):
                Sv[n_neurone] =Sv[n_neurone]+V[n_neurone,n_entree]*E[n_entree,n_exe] # + ...
        Sv = 1/(1+ np.exp(-Sv)) # Sv = f(Sv) application de la fonction d'activation
        # Calcul des sorties de la couche de sortie
        Sw = np.zeros(Ns)
        for n_neurone in range(0,Ns):
            for n_Sv in range(0,N):
                Sw[n_neurone] = Sw[n_neurone] +(W[n_neurone,n_Sv]*Sv[n_Sv]) # + ...
        Sw = 1/(1+ np.exp(-Sw)) # / ... Sw = f(Sw) application de la fonction d'activation
        # Erreur commise sur cet exemple
        Err_quad =  Err_quad + (Y[n_exe]-Sw)**2 # + ...
        # Calcul des correcteurs
        delta_W = np.zeros(Ns)
        for n_neurone in range(0,Ns):
            delta_W[n_neurone] = Sw[n_neurone]*(1-Sw[n_neurone])*(Y[n_exe]-Sw[n_neurone]) # *... terme correcteur de la couche de sortie
        delta_V = np.zeros(N)
        for n_neurone in range(0,N):
            s = 0.0
            for n_sortie in range(0,Ns):
                s = s + W[n_sortie,n_neurone]
                delta_V[n_neurone] = Sv[n_neurone]*(1-Sv[n_neurone])*delta_W[n_sortie]*s # *... terme correcteur de la couche cachee
        # Mise a jour des poids
        for n_neurone in range(0,N):
            for n_entree in range(0,Ne):
                V[n_neurone,n_entree] = V[n_neurone,n_entree]+ alpha*delta_V[n_neurone]*E[n_entree,n_exe] # + alpha*... application de la correction
        for n_neurone in range(0,Ns):
            for n_entree in range(0,N):
                W[n_neurone,n_entree] = W[n_neurone,n_entree]+ alpha*delta_W*Sv[n_entree] # + alpha*...
                
    # Enregistrement de l'erreur et des poids
    Err_quad_plot[n_ite]    = Err_quad/N_exemples
    Poids_cachees[n_ite, :] = V.reshape(N*Ne)
    Poids_sortie[n_ite, :]  = W.reshape(Ns*N)

# Affichage des resultats
x = range(0, N_ite)
# Evolution de l'erreur
plt.figure(2)
plt.plot(x, Err_quad_plot)
plt.grid()
plt.title('Evolution de l\'erreur quadratique moyenne')
plt.xlabel('Nombre d\'iterations')
plt.ylabel('Erreur')
# Evolution des poids de la couche cachee
plt.figure(3)
plt.plot(x, Poids_cachees)
plt.grid()
plt.title('Evolution des poids de la couche cachee')
plt.xlabel('Nombre d\'iterations')
plt.ylabel('Valeurs')
# Evolution des poids de la couche de sortie
plt.figure(4)
plt.plot(x, Poids_sortie)
plt.grid()
plt.title('Evolution des poids de la couche de sortie')
plt.xlabel('Nombre d\'iterations')
plt.ylabel('Valeurs')

# Cartographie de la sortie
prediction = np.zeros(N_exemples)
for n_exe in range(0,N_exemples):
        # Calcul des sorties de la couche cachee
        Sv = np.zeros(N)
        for n_neurone in range(0, N):
            for n_entree in range(0, Ne):
                Sv[n_neurone] = Sv[n_neurone] + V[n_neurone,n_entree]*E[n_entree,n_exe]# + ...
        Sv = 1/(1+ np.exp(-Sv))# / ...
        # Calcul des sorties de la couche de sortie
        Sw = np.zeros(Ns)
        for n_neurone in range(0, Ns):
            for n_Sv in range(0, N):
                Sw[n_neurone] = Sw[n_neurone] + (W[n_neurone,n_Sv]*Sv[n_Sv]) # + ...
        Sw = 1/(1+ np.exp(-Sw))  # / ...
        prediction[n_exe] = Sw

plt.figure(5)
plt.subplot(1, 2, 1)
plt.imshow(np.flip(Y.reshape(11,11),0), extent=[0, 1, 0, 1])
plt.title('Cartopgrahie de la fonction attendue')
plt.xlabel('Entree 1')
plt.ylabel('Entree 2')
plt.subplot(1, 2, 2)
plt.imshow(np.flip(prediction.reshape(11,11),0), extent=[0, 1, 0, 1])
plt.title('Cartopgrahie de la fonction realisee')
plt.xlabel('Entree 1')
plt.ylabel('Entree 2')
plt.show()
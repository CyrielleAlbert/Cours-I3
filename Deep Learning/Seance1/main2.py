from matplotlib import colors
import numpy as np
import matplotlib.pyplot as plt
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras import optimizers
from tensorflow.python.framework.ops import inside_function
from tensorflow.python.keras.engine import input_layer
from tensorflow.random import set_seed

import timeit
from sklearn.model_selection import train_test_split

# Definition des exemples entrees / sorties
E1 = np.repeat(np.linspace(0, 1, 11).reshape([1, 11]), 11, axis=0)
E1 = E1.reshape(121)
E2 = np.repeat(np.linspace(0,1,11),11)
E = np.array([E1,E2])
E = E.transpose() # TensorFlow attend le nombre d'exemple en premier dimension

# Sorties correspondantes
# 0, 0, 0, ... 1, 1, 0, 0, ...
Y = np.zeros(E.shape[0])
for n_exe in range(0, E.shape[0]):
    if (E[n_exe, 0]>=0.5 and E[n_exe, 1]<0.5) or (E[n_exe, 0]<0.5 and E[n_exe, 1]>=0.5):
        Y[n_exe] = 1
plt.figure(1)
for n_exe in range(0, E.shape[0]):
    plt.plot(E[n_exe, 0], E[n_exe, 1], '+', color=[Y[n_exe], 0, 0])
plt.grid()
plt.title('Cartographie de la fonction XOR')
plt.xlabel('Premiere entree')
plt.ylabel('Deuxieme entree')

# Definition du random seed pour la reproductibilite
np.random.seed(7)
set_seed(7)

# Creation du modele
model = Sequential()
model.add(Dense(3, input_dim=2,activation='sigmoid')) #Couche C?
model.add(Dense(3, input_dim=3,activation='sigmoid'))
model.add(Dense(3, input_dim=3,activation='sigmoid'))
model.add(Dense(1,activation='sigmoid')) #Couche S

# Séparation des données pour train/test/validation

X_train, X_test, y_train, y_test = train_test_split(E, Y, test_size=0.3)
X_test,X_validate,y_test,y_validate = train_test_split(E, Y, test_size=0.5)
# Compilation du modele
sgd = optimizers.SGD(lr=1.0, decay=0.0, momentum=0.0, nesterov=False)

model.compile(loss="mse", optimizer=sgd, metrics=["mae", "mse"])
model.summary() # Donne une representation du reseau

# Entrainement du modele
start_time = timeit.default_timer() # Mesure du temps d'entrainement
history = model.fit(X_train, y_train, epochs=8000, shuffle=True,batch_size=32)
print("\n Duree entrainement : %.2f s" % (timeit.default_timer() - start_time))

# Evaluation du modele
scores = model.evaluate(X_test, y_test,verbose=0)
print("\n%s: %.2f" % (model.metrics_names[1], scores[1]))

## Affichage des resultats
# Evolution de l'erreur
plt.figure()
plt.plot(history.history['loss'])
plt.grid()
plt.title('Evolution de l\'erreur quadratique moyenne')
plt.xlabel('Nombre d\'iterations')
plt.ylabel('Erreur')

print(X_validate.shape)
# Predictions
prediction = model.predict(X_validate)

# Cartographie de la sortie
plt.figure(5)
plt.subplot(1, 2, 1)
plt.imshow(np.flip(Y.reshape(11,11),0), extent=[0, 1, 0, 1])
plt.title('Cartopgrahie de la fonction attendue')
plt.xlabel('Entree 1')
plt.ylabel('Entree 2')
plt.subplot(1, 2, 2)
plt.plot(X_validate[0,:],X_validate[1,:],'o')


plt.title('Cartopgrahie de la fonction realisee')
plt.xlabel('Entree 1')
plt.ylabel('Entree 2')
plt.show()
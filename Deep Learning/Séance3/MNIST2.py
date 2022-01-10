import numpy
from tensorflow.keras.datasets import fashion_mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Dropout
from tensorflow.keras.utils import to_categorical
from tensorflow import random
from sklearn.model_selection import train_test_split
from matplotlib import pyplot as plt

# fix random seed for reproducibility
seed = 7
numpy.random.seed(seed)
random.set_seed(seed)

# load data
(X_train, y_train), (X_test, y_test) = fashion_mnist.load_data()


# flatten 28*28 images to a 784 vector for each image
num_pixels = X_train.shape[1] * X_train.shape[2]
X_train = X_train.reshape(X_train.shape[0], num_pixels).astype('float32')
X_test = X_test.reshape(X_test.shape[0], num_pixels).astype('float32')

# normalize inputs from 0-255 to 0-1
X_train = X_train / 255
X_test = X_test / 255

# apply noise
noise_factor = 0.1
X_train = X_train + noise_factor*numpy.random.randn(X_train.shape[0], X_train.shape[1])
X_test = X_test + noise_factor*numpy.random.randn(X_test.shape[0], X_test.shape[1])

# one hot encode outputs
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)
num_classes = y_test.shape[1]

X_train, X_val, y_train, y_val = train_test_split(X_train, y_train, test_size=0.20)

# Create hidden layer 1
couche_cachee_1 = Sequential()
couche_cachee_1.add(Dense(300, input_dim=num_pixels, activation='sigmoid'))


# Create hidden layer 2
couche_cachee_2 = Sequential()
couche_cachee_2.add(Dense(144, activation='sigmoid',
                          input_dim=couche_cachee_1.output_shape[1]))
couche_cachee_2.add(Dropout(0.2))

# Create hidden layer 3
couche_cachee_3 = Sequential()
couche_cachee_3.add(Dense(couche_cachee_1.output_shape[1], activation='sigmoid',
                          input_dim=couche_cachee_2.output_shape[1]))

# Create output layer
couche_sortie = Sequential()
couche_sortie.add(Dense(num_pixels, activation='sigmoid',
                          input_dim=couche_cachee_1.output_shape[1]))

# Create first hidden layer and ouput model
hidden_and_output = Sequential()
hidden_and_output.add(couche_cachee_1)
hidden_and_output.add(couche_sortie)
# Compile first hidden layer and ouput model
hidden_and_output.compile(loss='mse', optimizer='adam', metrics=['mse'])

# Create 2nd and 3rd hidden layers model
couche_cachee_2_et_3 = Sequential()
couche_cachee_2_et_3.add(couche_cachee_2)
couche_cachee_2_et_3.add(couche_cachee_3)
# Compile hidden layer 2 and 3 model
couche_cachee_2_et_3.compile(loss='mse', optimizer='adam', metrics=['mse'])

# Create total model
model = Sequential()
model.add(couche_cachee_1)
model.add(couche_cachee_2)
model.add(couche_cachee_3)
model.add(couche_sortie)
# Compile total model
model.compile(loss='mse', optimizer='adam', metrics=['mse'])

# Create encodeur model
encodeur = Sequential()
encodeur.add(couche_cachee_1)
encodeur.add(couche_cachee_2)
# Compile total model
encodeur.compile(loss='mse', optimizer='adam', metrics=['mse'])

hidden_and_output.summary()
couche_cachee_2_et_3.summary()

# Fit the first hidden layer and ouput model
N_epochs = 25
Batch_size = 128
print("Entrainement couches cachee 1 et sortie")
hidden_and_output.fit(X_train, X_train, validation_data=(X_val, X_val),
          epochs=N_epochs, batch_size=Batch_size, verbose=1)

# Evaluation of the first hidden layer and ouput model
scores = hidden_and_output.evaluate(X_test, X_test, verbose=0)
print("Test MSE couches cachee 1 et sortie : %f" % (scores[1]))

# Get intermediate outputs
X_train_intermediate = couche_cachee_1.predict(X_train)
X_val_intermediate = couche_cachee_1.predict(X_val)
X_test_intermediate = couche_cachee_1.predict(X_test)

# Fit the hidden layer 2 and 3 model
print("Entrainement couches cachees 2 et 3")
# N_epochs = 10
# Batch_size = 64
couche_cachee_2_et_3.fit(X_train_intermediate, X_train_intermediate, validation_data=(X_val_intermediate, X_val_intermediate),
          epochs=N_epochs, batch_size=Batch_size, verbose=1)

# Evaluation of the first hidden layer and ouput model
scores = couche_cachee_2_et_3.evaluate(X_test_intermediate, X_test_intermediate, verbose=0)
print("Test MSE couches cachees 2 et 3: %f" % (scores[1]))

# Fit the total model
print("Entrainement modele complet")
# N_epochs = 10
# Batch_size = 64
model.fit(X_train, X_train, validation_data=(X_val, X_val),
          epochs=N_epochs, batch_size=Batch_size, verbose=1)

# Evaluation of the total model
scores = model.evaluate(X_test, X_test, verbose=0)
print("Test MSE modele complet: %f" % (scores[1]))

# Visualizing the Reconstructions
X_test_output = model.predict(X_test)
X_test_internal = encodeur.predict(X_test)

def plot_image(image, shape=[28, 28]):
    plt.imshow(image.reshape(shape), cmap="Greys", interpolation="nearest")
    plt.axis("off")
def plot_internal_image(image, shape=[12, 12]):
    plt.imshow(image.reshape(shape), cmap="Greys", interpolation="nearest")
    plt.axis("off")
    
n_test_digits = 5
plt.figure()
for digit_index in range(n_test_digits):
    plt.subplot(n_test_digits, 3, digit_index * 3 + 1)
    plot_image(X_test[digit_index])
    
    plt.subplot(n_test_digits, 3, digit_index * 3 + 2)
    plot_internal_image(X_test_internal[digit_index])
    
    plt.subplot(n_test_digits, 3, digit_index * 3 + 3)
    plot_image(X_test_output[digit_index])
plt.show()
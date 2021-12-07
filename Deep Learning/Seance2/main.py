# Simple CNN for the MNIST Dataset
import numpy
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Dropout
from tensorflow.keras.layers import Flatten
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import MaxPooling2D
from tensorflow.keras.utils import to_categorical
from tensorflow import random
from matplotlib import pyplot as plt
from sklearn.model_selection import train_test_split
import timeit
from tensorflow.keras.callbacks import TensorBoard
import datetime

from tensorflow.python.keras import callbacks

# fix random seed for reproducibility
seed = 7
numpy.random.seed(seed)
random.set_seed(seed)

# load data
(X_train, y_train), (X_test, y_test) = mnist.load_data()

# plot 4 images as gray scale
plt.subplot(221)
plt.imshow(X_train[0], cmap=plt.get_cmap('gray'))
plt.subplot(222)
plt.imshow(X_train[1], cmap=plt.get_cmap('gray'))
plt.subplot(223)
plt.imshow(X_train[2], cmap=plt.get_cmap('gray'))
plt.subplot(224)
plt.imshow(X_train[3], cmap=plt.get_cmap('gray'))
plt.show()

# reshape to be [samples][width][height][channels]
X_train = X_train.reshape(X_train.shape[0], 28, 28, 1).astype('float32')
X_test = X_test.reshape(X_test.shape[0], 28, 28, 1).astype('float32')

# normalize inputs from 0-255 to 0-1
X_train = X_train / 255
X_test = X_test / 255

# one hot encode outputs
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)
num_classes = y_test.shape[1]

# validation data split
X_train, X_val, y_train, y_val = train_test_split(X_train, y_train, test_size=0.20)

# define a simple CNN model
def CNN_model():
    # create model
    model = Sequential()
    ## Définition de modèle à completer
    input_shape=(28,28,1)
    model.add(Conv2D(10,kernel_size=(5,5), activation='sigmoid',input_shape=input_shape))
    model.add(MaxPooling2D(pool_size=(2,2),strides=(2,2)))
    model.add(Dropout(0.2))
    model.add(Flatten())
    model.add(Dense(10,activation='sigmoid',kernel_initializer='uniform'))

    model.add(Dense(num_classes, activation='sigmoid',kernel_initializer='uniform'))
    # Compile model
    model.compile(loss='categorical_crossentropy',
                  optimizer='adam', metrics=['accuracy'])
    return model

def baseline_model(initializer,activation):
    model = Sequential()
    model.add(Dense(10, input_dim=28*28,
    kernel_initializer=initializer, activation=activation))

    for i in range(1,4):
        model.add(Dense(10, kernel_initializer=initializer, activation=activation))
        model.add(Dense(num_classes, kernel_initializer=initializer, activation='softmax'))
    # Compile model
    model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])
    return model
    # build the model
model = baseline_model('glorot_uniform','sigmoid')

# build the model
#model = CNN_model()
model.summary()

# Fit the model
N_epochs = 10
Batch_size = 200
start_time = timeit.default_timer()
NAME = 'glorot_uniform_init_sigmoid_activation'+ datetime.datetime.now().strftime("%d_%m_%Y-%H_%M_%S") # NEW FILE NAME FOR EACH TRAINING
tensorboard = TensorBoard(log_dir="MLP\\{}".format(NAME), histogram_freq=1)

## Entraînement du modèle à completer
history = model.fit(X_train,y_train, validation_data=(X_val, y_val), epochs=N_epochs, batch_size=Batch_size,callbacks=[tensorboard_callback])
print("Duree entrainement : %.2f s" %
      (timeit.default_timer() - start_time))

# Final evaluation of the model
## Mesure des performances sur l'ensemble de test à compléter
scores = model.evaluate(X_test,y_test,batch_size=Batch_size)
print("CNN Error: %.2f%%" % (100-scores[1]*100))

# Trace training performances
## Plot des performances à décommenter
plt.figure()
plt.plot(history.history['accuracy'])
plt.plot(history.history['val_accuracy'])
plt.title('Performance pendant l\'entrainement')
plt.legend(['Train','Val'])
plt.xlabel('Epochs')
plt.ylabel('Accuracy')
plt.show()

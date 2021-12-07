# Simple Deep NN for the MNIST Dataset
import numpy
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.callbacks import TensorBoard
from tensorflow import random
from sklearn.model_selection import train_test_split
import datetime

# fix random seed for reproducibility
seed = 7
numpy.random.seed(seed)
random.set_seed(seed)

# load data
(X_train, y_train), (X_test, y_test) = mnist.load_data()

# flatten 28*28 images to a 784 vector for each image
num_pixels = X_train.shape[1] * X_train.shape[2]
X_train = X_train.reshape(X_train.shape[0], num_pixels).astype('float32')
X_test = X_test.reshape(X_test.shape[0], num_pixels).astype('float32')

# normalize inputs from 0-255 to 0-1
X_train = X_train / 255
X_test = X_test / 255

# one hot encode outputs
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)
num_classes = y_test.shape[1]

X_train, X_val, y_train, y_val = train_test_split(X_train, y_train, test_size=0.20)

# define baseline model
def baseline_model(initializer, activation):
    # create model
    model = Sequential()
    model.add(Dense(10, input_dim=num_pixels,
                    kernel_initializer=initializer, activation=activation))
    for i in range(1,10):
        model.add(Dense(10, kernel_initializer=initializer, activation=activation))
    model.add(Dense(num_classes, kernel_initializer=initializer, activation=activation))
    # Compile model
    model.compile(loss='MSE', optimizer='adam', metrics=['accuracy'])
    return model

# build the model
initializer = 'normal'
activation = 'sigmoid'
model = baseline_model(initializer, activation)
model.summary()

# Fit the model
N_epochs = 10
Batch_size = 32
NAME = initializer + '_' + activation + '_'\
       + datetime.datetime.now().strftime("%d_%m_%Y-%H_%M_%S") # NEW FILE NAME FOR EACH TRAINING
tensorboard = TensorBoard(log_dir="MLP/{}".format(NAME), histogram_freq=1)
model.fit(X_train, y_train, validation_data=(X_val, y_val),
          epochs=N_epochs, batch_size=Batch_size,callbacks=[tensorboard])

# Final evaluation of the model
scores = model.evaluate(X_test, y_test, verbose=0)
print("Error: %.2f%%" % (100-scores[1]*100))
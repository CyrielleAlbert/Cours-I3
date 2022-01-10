import matplotlib.pyplot as plt # For ploting
import numpy as np # to work with numerical data efficiently
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import LSTM
from tensorflow import random

# Fix random seed for reproducibility
seed = 7
np.random.seed(seed)
random.set_seed(seed)

Fs = 4000 # Sampling frequency
f  = 100  # Signal frequency
x  = np.arange(Fs)
dataset = np.sin(2 * np.pi * f * x / Fs)+np.sin(2 * np.pi * f * x*2.3 / Fs)+1.5*np.sin(2 * np.pi * f * x* 0.5 / Fs)#+0.2*np.random.randn(Fs)
dataset = dataset/max(dataset)
dataset = np.asarray(dataset)

# Split into train and test sets
train_size = int(len(dataset) * 0.67)
test_size  = len(dataset) - train_size
train      = dataset[0:train_size]
test       = dataset[train_size:len(dataset)]

# Sshowing the exact location of the samples
plt.figure()
plt.plot(x[0:train_size],train)
plt.plot(x[train_size:len(dataset)],test)
plt.ylabel('Value')
plt.xlabel('Time')
plt.title('Dataset')
plt.grid()

# Convert an array of values into a dataset matrix
def create_dataset(dataset, look_back=1):
    dataX, dataY = [], []
    for i in range(len(dataset)-look_back-1):
        a = dataset[i:(i+look_back)]
        dataX.append(a)
        dataY.append(dataset[i + look_back])
    return np.array(dataX), np.array(dataY)

# Reshape into X=t-N, ..., t-1, t and Y=t+1
look_back      = 1000
trainX, trainY = create_dataset(train, look_back)
testX, testY   = create_dataset(test, look_back)
trainX = np.reshape(trainX, (trainX.shape[0], trainX.shape[1], 1))
testX = np.reshape(testX, (testX.shape[0], testX.shape[1], 1))

print('trainX dimensions : ', trainX.shape)
print('trainY dimensions : ', trainY.shape)
print('testX dimensions : ', testX.shape)
print('testY dimensions : ', testY.shape)

# Create and fit RNN model
model = Sequential()

model.add(LSTM(6, activation='tanh', input_shape=(look_back,1)))
model.add(Dense(1, activation='linear'))

model.compile(loss='mse', optimizer='adam')
model.summary()

# Fit the model
history = model.fit(trainX, trainY, epochs=2, batch_size=trainX.shape[0], shuffle=True)
# Plot performances
plt.figure()
plt.plot(history.history['loss'])
plt.ylabel('MSE')
plt.xlabel('Epochs')
plt.title('Training history')
plt.grid()

# Estimate model performance
trainScore = model.evaluate(trainX, trainY, verbose=0)
testScore = model.evaluate(testX, testY, verbose=0)
print('Train Score : ', trainScore)
print('Test Score  : ', testScore)

# Plot prediction against target
trainPredict = model.predict(trainX)
testPredict = model.predict(testX)
plt.figure()
plt.plot(range(0,len(trainY)), trainY, label='train')
plt.plot(range(0,len(trainY)), trainPredict, '--', label='train predict')
plt.plot(range(len(trainY), len(trainY)+len(testY)), testY, label='test')
plt.plot(range(len(trainY), len(trainY)+len(testY)), testPredict, '--', label='test predict')
plt.legend(), plt.grid(), plt.xlabel('Time'), plt.ylabel('Value')
plt.title('Dataset vs predictions')

# Generate data with pre-trained model
nb_points_generes = 200
sortie = np.zeros((nb_points_generes,))
entree = np.zeros((1,look_back,1))
for i in range(0,nb_points_generes):
    sortie[i] = model.predict(entree)
    entree[0,:look_back-1,0] = entree[0,1:look_back,0]
    entree[0,look_back-1,0] = sortie[i]
plt.figure()
plt.plot(sortie)
plt.grid(), plt.xlabel('Time'), plt.ylabel('Value')
plt.title('Generated signal')
plt.show()

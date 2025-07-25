# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd

data = pd.read_csv("seed-data.csv")
data = data.sample(frac=1).reset_index(drop=True)
data.head()

X = np.array(data)[:, 1:-1]
print(X[0])
data.shape

from sklearn.preprocessing import OneHotEncoder
one_hot_encoder = OneHotEncoder(sparse=False)
Y = np.array(data)[:, -1]
Y = one_hot_encoder.fit_transform(np.array(Y).reshape(-1, 1))

from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.25)
X_train.shape

def NeuralNetwork(X_train, Y_train, X_val=None, Y_val=None, epochs=10, nodes=[], lr=0.07):
    hidden_layers = len(nodes) - 1
    weights = InitializeWeights(nodes)
    for epoch in range(1, epochs+1):
        weights = Train(X_train, Y_train, lr, weights)
        if (epoch % 50 == 0):
            print("Epoch {}".format(epoch))
            print("Training Accuracy: {}".format(Accuracy(X_train, Y_train, weights)))
            if X_val is not None:
                print("Validation Accuracy: {}".format(Accuracy(X_val, Y_val, weights)))
    return weights

def InitializeWeights(nodes):
    layers = len(nodes)
    weights = []
    for i in range(1, layers):
        w = [[np.random.uniform(-1, 1) for k in range(nodes[i-1] + 1)] for j in range(nodes[i])]
        weights.append(np.matrix(w))
    return weights

def ForwardPropagation(x, weights, layers):
    activations, layer_input = [x], x
    for j in range(layers):
        activation = Sigmoid(np.dot(layer_input, weights[j].T))
        activations.append(activation)
        layer_input = np.append(1, activation)
    return activations

def BackPropagation(y, activations, weights, layers):
    outputFinal = activations[-1]
    error = np.matrix(y - outputFinal)
    for j in range(layers, 0, -1):
        currActivation = activations[j]
        if j > 1:
            prevActivation = np.append(1, activations[j-1])
        else:
            prevActivation = activations[0]
        delta = np.multiply(error, SigmoidDerivative(currActivation))
        weights[j-1] += lr * np.multiply(delta.T, prevActivation)
        w = np.delete(weights[j-1], [0], axis=1)
        error = np.dot(delta, w)
    return weights

def Train(X, Y, lr, weights):
    layers = len(weights)
    for i in range(len(X)):
        x, y = X[i], Y[i]
        x = np.matrix(np.append(1, x))
        activations = ForwardPropagation(x, weights, layers)
        weights = BackPropagation(y, activations, weights, layers)
    return weights

def Sigmoid(x):
    return 1 / (1 + np.exp(-x))

def SigmoidDerivative(x):
    return np.multiply(x, 1 - x)

def Predict(item, weights):
    layers = len(weights)
    item = np.append(1, item)
    activations = ForwardPropagation(item, weights, layers)
    outputFinal = activations[-1].A1
    m, index = outputFinal[0], 0
    for i in range(1, len(outputFinal)):
        if outputFinal[i] > m:
            m, index = outputFinal[i], i
    y = [0 for i in range(len(outputFinal))]
    y[index] = 1
    return y

def Accuracy(X, Y, weights, display=False):
    correct = 0
    for i in range(len(X)):
        x, y = X[i], list(Y[i])
        guess = Predict(x, weights)
        if display == True:
            print("\n\nInput:\n", x, "\nPredicted:\n", guess, "\nActual:\n", y)
        if y == guess:
            correct += 1
        elif display == True:
            print("mispredicted")
    return correct / len(X)

layers = [len(X[0]), 11, 8, 5, 5, len(Y[0])]
lr, epochs = 0.1, 500
weights = NeuralNetwork(X_train, Y_train, epochs=epochs, nodes=layers, lr=lr)

print("Final weights:\n", weights)
print("Testing Accuracy: {}".format(Accuracy(X_test, Y_test, weights, display=True)))

import sklearn
Y_result = []
for x in X_test:
    guess = Predict(x, weights)
    Y_result.append(guess)

print("R2 score : %f" % sklearn.metrics.r2_score(Y_test, Y_result))
print(sklearn.metrics.classification_report(Y_test, Y_result))

ytest, yresult = [], []
for i in range(len(Y_test)):
    ytest.append(Y_test[i][0])
    yresult.append(Y_result[i][0])

from sklearn.metrics import roc_curve, roc_auc_score
fpr, tpr, thresholds = roc_curve(ytest, yresult)

import matplotlib.pyplot as plt
def plot_roc_curve(fpr, tpr):
    plt.plot(fpr, tpr)
    plt.axis([0, 1, 0, 1])
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.show()

plot_roc_curve(fpr, tpr)

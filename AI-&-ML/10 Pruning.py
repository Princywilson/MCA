# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn import metrics
from sklearn.tree import export_graphviz
from six import StringIO
from IPython.display import Image
import pydotplus
import os
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt

# input data is read and printed
traindatainput = pd.read_csv('monks2_train.csv', delimiter=",")
print("Training Dataset")
print(traindatainput)

testdatainput = pd.read_csv('monks2_test.csv', delimiter=",")
print("Test Dataset")
print(testdatainput)

X_train = traindatainput[['a1', 'a2', 'a3', 'a4', 'a5', 'a6']].values
y_train = traindatainput["label"]
print(y_train[0:6])

X_test = testdatainput[['a1', 'a2', 'a3', 'a4', 'a5', 'a6']].values
y_test = testdatainput["label"]
print(y_test[0:6])

# print shapes
print(X_train.shape)
print(X_test.shape)
print(y_train.shape)
print(y_test.shape)

# using Entropy on the input data, create the decision tree
monksTree = DecisionTreeClassifier(criterion="entropy", max_depth=4)
monksTree.fit(X_train, y_train)
predicted = monksTree.predict(X_test)
print(predicted)

# find and print the accuracy of the decision tree model
print("\nDecisionTrees's Accuracy: ", metrics.accuracy_score(y_test, predicted))

# Visualize the decision tree
dot_data = StringIO()
export_graphviz(monksTree, out_file=dot_data)
graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
graph.write_png('tree.png')
Image(graph.create_png())

# Trying with different criteria
monksTree = DecisionTreeClassifier(criterion='gini')
monksTree.fit(X_train, y_train)
pred = monksTree.predict(X_test)
print('Criterion=gini', accuracy_score(y_test, pred))

monksTree = DecisionTreeClassifier(criterion='entropy')
monksTree.fit(X_train, y_train)
pred = monksTree.predict(X_test)
print('Criterion=entropy', accuracy_score(y_test, pred))

# Check if pruning can improve the results
max_depth = []
acc_gini = []
acc_entropy = []

for i in range(1, 30):
    monksTree = DecisionTreeClassifier(criterion='gini', max_depth=i)
    monksTree.fit(X_train, y_train)
    pred = monksTree.predict(X_test)
    acc_gini.append(accuracy_score(y_test, pred))

    monksTree = DecisionTreeClassifier(criterion='entropy', max_depth=i)
    monksTree.fit(X_train, y_train)
    pred = monksTree.predict(X_test)
    acc_entropy.append(accuracy_score(y_test, pred))

    max_depth.append(i)

d = pd.DataFrame({
    'acc_gini': pd.Series(acc_gini),
    'acc_entropy': pd.Series(acc_entropy),
    'max_depth': pd.Series(max_depth)
})

# Visualizing changes in parameters
plt.plot('max_depth', 'acc_gini', data=d, label='gini')
plt.plot('max_depth', 'acc_entropy', data=d, label='entropy')
plt.xlabel('max_depth')
plt.ylabel('accuracy')
plt.legend()

# Check accuracy with a shorter tree, with max_depth of 7 and criterion of entropy
monksTree = DecisionTreeClassifier(criterion='entropy', max_depth=7)
monksTree.fit(X_train, y_train)
pred = monksTree.predict(X_test)
print("Accuracy after reducing depth and using Entropy", accuracy_score(y_test, pred))

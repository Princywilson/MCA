import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv("diabetes.csv")
data.shape
data.head()

X = data.drop(['SkinThickness', 'Outcome'], axis=1)
y = data['Outcome']

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20)

from sklearn.linear_model import LogisticRegression
clf = LogisticRegression(max_iter=1000)
clf.fit(X_train, y_train)

# Predict the response for test dataset
y_pred = clf.predict(X_test)

from sklearn.metrics import accuracy_score
# Model Accuracy, how often is the classifier correct?
print("Accuracy:", accuracy_score(y_test, y_pred))

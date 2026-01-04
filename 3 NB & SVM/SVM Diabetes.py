import numpy as np
import pandas as pd

# Read the dataset
dataset = pd.read_csv(
    r"C:\Users\CDE LAB\Desktop\MCA0001\dataset_diabetes\diabetic_data.csv"
)

print(dataset.head())

# Convert target to binary
dataset['readmitted'] = dataset['readmitted'].apply(
    lambda x: 0 if x == 'NO' else 1
)

# Features and target
X = dataset.drop('readmitted', axis=1)
y = dataset['readmitted'].values

# Encode categorical data
X = pd.get_dummies(X, drop_first=True)

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.25, random_state=0
)

# Create SVM model
from sklearn.svm import SVC
classifier = SVC(kernel='linear', random_state=0)

# Fit the model
classifier.fit(X_train, y_train)

# Prediction
y_pred = classifier.predict(X_test)

# Confusion matrix
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)
print(cm)

# Cross validation
from sklearn.model_selection import cross_val_score
accuracies = cross_val_score(classifier, X_train, y_train, cv=10)

print("Accuracy: {:.2f} %".format(accuracies.mean() * 100))
print("Standard Deviation: {:.2f} %".format(accuracies.std() * 100))

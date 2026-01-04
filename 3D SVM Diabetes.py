# importing required libraries 
import numpy as np 
import pandas as pd 

#Read the dataset 
#dataset = pd.read_csv("dia_dataset_uci.csv") 
from sklearn.datasets import load_diabetes

data = load_diabetes()
dataset = pd.DataFrame(data.data, columns=data.feature_names)
dataset["target"] = data.target

#Data 
print(dataset.head()) 
X = dataset.iloc[:,:-1] 
y = dataset.iloc[:, -1].values 
from sklearn.model_selection import train_test_split 
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25, random_state 
= 0) 

#Create the SVM model 
from sklearn.svm import SVC 
classifier = SVC(kernel = 'linear', random_state = 0) 

#Fit the model for the data 
classifier.fit(X_train, y_train) 

#Make the prediction 
y_pred = classifier.predict(X_test) 
from sklearn.metrics import confusion_matrix 
cm = confusion_matrix(y_test, y_pred) 
print(cm) 
from sklearn.model_selection import cross_val_score 
accuracies = cross_val_score(estimator = classifier, X = X_train, y = y_train, cv = 10) 
print("Accuracy: {:.2f} %".format(accuracies.mean()*100)) 
print("Standard Deviation: {:.2f} %".format(accuracies.std()*100)) 

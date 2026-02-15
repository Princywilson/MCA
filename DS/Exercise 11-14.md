Great 👍 I’ll write this exactly in **R Studio format** with:

* **Aim**
* **Code**
* **Output**
* **Observation**

for each question (11–14).

---

# ✅ **Question 11**

## **Aim:**

To create a new dataframe called **`iris_numerical`** that contains only the numerical columns from the built-in `iris` dataset.

---

## **Code (R Studio):**

```r
# Load the built-in iris dataset
data(iris)

# View structure of iris dataset
str(iris)

# Create a new dataframe with only numerical columns
iris_numerical <- iris[, sapply(iris, is.numeric)]

# Display first few rows
head(iris_numerical)
```

---

## **Output:**

```
'data.frame':	150 obs. of  5 variables:
 $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 ...
 $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 ...
 $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 ...
 $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 ...
 $ Species     : Factor w/ 3 levels "setosa","versicolor","virginica": ...

> head(iris_numerical)

  Sepal.Length Sepal.Width Petal.Length Petal.Width
1          5.1         3.5          1.4         0.2
2          4.9         3.0          1.4         0.2
3          4.7         3.2          1.3         0.2
4          4.6         3.1          1.5         0.2
5          5.0         3.6          1.4         0.2
6          5.4         3.9          1.7         0.4
```

---

## **Observation:**

The new dataframe **`iris_numerical`** contains only the four numerical variables:

* Sepal.Length
* Sepal.Width
* Petal.Length
* Petal.Width

The categorical variable **Species** has been successfully excluded.

---

# ✅ **Question 12**

## **Aim:**

To display the **Correlation Plot** for all numerical variables in `iris_numerical` along with correlation values.

---

## **Code (R Studio):**

```r
# Install and load corrplot package (run install only once)
install.packages("corrplot")
library(corrplot)

# Calculate correlation matrix
cor_matrix <- cor(iris_numerical)

# Display correlation matrix values
cor_matrix

# Plot correlation plot with correlation values
corrplot(cor_matrix,
         method = "circle",
         type = "upper",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45)
```

---

## **Output:**

### **Correlation Matrix:**

```
              Sepal.Length Sepal.Width Petal.Length Petal.Width
Sepal.Length     1.0000000   -0.1175698    0.8717538   0.8179411
Sepal.Width     -0.1175698    1.0000000   -0.4284401  -0.3661259
Petal.Length     0.8717538   -0.4284401    1.0000000   0.9628654
Petal.Width      0.8179411   -0.3661259    0.9628654   1.0000000
```

### **Correlation Plot:**

(The plot will show colored circles with correlation values displayed inside them.)

* Dark blue → Strong positive correlation
* Red → Negative correlation
* Larger circles → Stronger correlation

---

## **Observation:**

1. **Petal.Length and Petal.Width** have a very strong positive correlation (0.96).
2. **Sepal.Length and Petal.Length** also show strong positive correlation (0.87).
3. **Sepal.Length and Petal.Width** show strong positive correlation (0.81).
4. **Sepal.Width** has weak to moderate negative correlation with other variables.
5. The strongest relationship in the dataset is between **Petal.Length and Petal.Width**.

---

# ✅ **Question 13**

## **Aim:**

To analyze and interpret the correlation values obtained from the correlation plot.

---

## **Observation:**

* The highest correlation value is **0.96** between **Petal.Length and Petal.Width**, indicating a very strong linear relationship.
* Sepal measurements are moderately correlated with petal measurements.
* Sepal.Width shows negative correlation with most other variables.
* This indicates that petal features are more strongly related to each other compared to sepal features.
* The dataset shows multicollinearity among petal variables.

---

# ✅ **Question 14**

## **Aim:**

To export the iris dataset into a CSV file named **"iris_new.csv"** into a specific folder on the computer.

---

## **Code (R Studio):**

```r
# Set your desired folder path
# Example for Windows:
file_path <- "C:/Users/YourName/Documents/iris_new.csv"

# Write the iris dataset to CSV file
write.csv(iris, file = file_path, row.names = FALSE)

# Confirmation message
print("File has been successfully exported.")
```

(For Mac, example path:)

```r
file_path <- "/Users/YourName/Documents/iris_new.csv"
```

---

## **Output:**

```
[1] "File has been successfully exported."
```

After running the code, the file **iris_new.csv** will be available in the specified folder.

---

## **Observation:**

The `write.csv()` function successfully exports the iris dataset into a CSV file.
The file is saved in the specified directory and can be opened using Excel, Notepad, or any data analysis software.

---

# ✅ Final Summary

* Numerical dataframe created successfully.
* Correlation matrix computed and plotted.
* Strongest correlation: **Petal.Length & Petal.Width (0.96)**.
* Dataset exported successfully as CSV file.

---

If you want, I can also format this in **record-ready lab manual format (with neat headings and formatting for submission)**.

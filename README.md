# Credit Card Fraud Detection

The goal of this project is to predict credit card fraud using customer data. The data is anonymized by using PCA algorithms. These are these data that are used in the model created. 

## Data Analysis

The dataset contains more data belonging to the class "No" than the class "Yes".
![Class_distribution_plot](https://user-images.githubusercontent.com/64648386/159119500-418aca0a-6315-4153-8ee1-d30c6fa63971.png)

In this case, data are imbalanced. A resampling was realized before creating a model.
  
## Modelisation

The choosen model is a random forest. Accuracy of the model is 99%. 
The performances are showed in the graph below.

![lift_curve](https://user-images.githubusercontent.com/64648386/159119680-91542508-862c-4281-aff2-5481e8e6b754.png)

## Explainability of the model

To better understand how the model works, LIME helps to have the features importances. One example is introduced in the graph. The choose was made to show only five features to make the graph more understandable. 

![explanability_subject15](https://user-images.githubusercontent.com/64648386/159119711-4b6b13bc-b4e5-497e-b9b9-7967e5395a10.png)






# load librairies
library(ROSE)
library(caret)
library(e1071)

data <- read.csv('~/Credit_Card_Fraud_Detection/01_tidy_data/creditcard_clean.csv',
                 header=TRUE)

# split the dataset into train and test set
set.seed(42)
trainIndex <- createDataPartition(data$v31,
                                  p = .75, 
                                  list = FALSE, 
                                  times = 1)

train <- data[ trainIndex,]
test  <- data[-trainIndex,]

table(train$v31)

# using ROSE to work on imbalanced dataset
rose <- ROSE(v31~., data = train, N = 600, seed=42)$data
table(rose$v31)
summary(rose)

# training model
rf_fit <- train(as.factor(v31) ~ ., 
                data = rose, 
                method = "ranger")

# predict the outcome on a test set
rf_pred <- predict(rf_fit, test)
# compare predicted outcome and true outcome
confusionMatrix(rf_pred, as.factor(test$v31), positive = '1')
# load librairies
library(ROSE)
library(caret)
library(e1071)
library(pROC)
library(lime)

data <- read.csv('~/Credit_Card_Fraud_Detection/01_tidy_data/creditcard_clean.csv',
                 header=TRUE)
data$v31 <- as.factor(data$v31)
data$v31 <- ifelse(data$v31=="1","yes","no")

# split the dataset into train and test set
set.seed(42)
trainIndex <- createDataPartition(data$v31,
                                  p = .75, 
                                  list = FALSE, 
                                  times = 1)

train <- data[ trainIndex,]
test  <- data[-trainIndex,]

prop.table(table(train$v31))
prop.table(table(test$v31))

# using ROSE to work on imbalanced dataset
rose <- ROSE(v31~., data = train, N = 600, seed=42)$data
prop.table(table(rose$v31))
summary(rose)

# training model with crossvalidation
fitControl <- trainControl(method="cv",
                           classProbs=TRUE,
                           number=5,
                           summaryFunction = twoClassSummary)
rf_fit <- train(v31 ~ ., 
                data = rose,
                method="ranger",
                metric="ROC",
                trControl=fitControl)

# predict the outcome on a test set
rf_pred <- as.factor(predict(rf_fit, test))
test$v31 <- as.factor(test$v31)

# compare predicted outcome and true outcome
matrix <- confusionMatrix(data=rf_pred,
                          reference=test$v31,
                          positive = 'yes')
print(matrix)

# lift curve
score <- predict(rf_fit,test,type="prob")[,"yes"]
print(quantile(score))
liftdata <- data.frame(classe=test$v31)
liftdata$score <- score
lift_obj <- lift(classe ~ score, 
                 data=liftdata, 
                 class="yes")
print(lift_obj)
plot(lift_obj)

# roc curve
roc_obj <- roc(test$v31=="yes",score)
plot(1-roc_obj$specificities,roc_obj$sensitivities,type="l")
abline(0,1)

print(roc_obj$auc)

library(ggplot2)
 
data <- read.csv('~/Credit_Card_Fraud_Detection/01_tidy_data/creditcard_clean.csv',
                 header=TRUE)

data <- as.data.frame(sapply(data, as.numeric))

str(data)

summary(data)

barplot(prop.table(table(data$v31)),
        col = rainbow(2),
        main = "Class Distribution")
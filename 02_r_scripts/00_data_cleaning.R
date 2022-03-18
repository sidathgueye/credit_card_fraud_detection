# Load required R librairies
library(dplyr)
library(janitor)
library(naniar)

# Import dataset & observed the 5 first line
creditcard <- read.csv("~/Credit_Card_Fraud_Detection/00_raw_data/creditcard.csv",
                       header=FALSE)
head(creditcard)


# Cleaning and deal with missing data
## cleaning name of the columns
creditcard_clean <- clean_names(creditcard)
creditcard_clean <- creditcard_clean[-c(1)]

## percentage complete values
pct_complete(creditcard_clean)

# save dataset cleaning
write_csv(creditcard_clean, "~/Credit_Card_Fraud_Detection/01_tidy_data/creditcard_clean.csv")
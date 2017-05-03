##### Load Data from csv #####
train <- read.csv('~/Project/R_example/kaggle/titanic/train.csv', stringsAsFactors = F)
test  <- read.csv('~/Project/R_example/kaggle/titanic/test.csv', stringsAsFactors = F)

summary(train$Survived)

#Suvived v.s Not Survived
sum(train$Survived==1) / sum(train$Survived==0)

sum(is.na(train$Age))

#### To check which column has missing data, Age column ####
for(i in 1:ncol(train)) {
  row <- train[, i]
  # do stuff with row
  if(sum(is.na(row)) > 0) {
    print(colnames(train[i]))
  }
}

missingAge <- subset(train, is.na(train$Age))



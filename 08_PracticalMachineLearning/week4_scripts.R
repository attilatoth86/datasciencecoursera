# Q1
rm(list=ls())
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

head(vowel.train)
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)

library(caret)

mdlrf <- train(y~.,vowel.train,method='rf')
mdlgbm <- train(y~.,vowel.train,method='gbm')

predict(mdlrf,vowel.test)
confusionMatrix(predict(mdlrf,vowel.test),vowel.test$y)
confusionMatrix(predict(mdlgbm,vowel.test),vowel.test$y)

# Q2
rm(list=ls())
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

head(training)

mdlrf <- train(diagnosis~., training, method="rf")
mdlgbm <- train(diagnosis~., training, method="gbm") 
mdllda <- train(diagnosis~., training, method="lda")

predrf <- predict(mdlrf,training)
predgbm <- predict(mdlgb,training)
predlda <- predict(mdllda,training)

mdlstacked <- train(diagnosis~., training, method="rf")

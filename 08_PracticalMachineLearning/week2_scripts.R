library(caret); library(kernlab); data(spam)
dim(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

set.seed(32343)
modelFit <- train(type ~.,data=training, method="glm")
modelFit
summary(modelFit$finalModel)

predictions <- predict(modelFit,newdata=testing)
predictions

confusionMatrix(predictions,testing$type)


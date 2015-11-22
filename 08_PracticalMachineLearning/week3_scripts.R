# Q1
# --
rm(list=ls())
install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

inTrain <- createDataPartition(segmentationOriginal$Case,p=0.75,list = FALSE)
sOtrain <- segmentationOriginal[inTrain,]
sOtest <- segmentationOriginal[-inTrain,]
set.seed(125)
mdl <- train(Class~.,sOtrain,method="rpart")
mdl$finalModel

head(sOtrain)

a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2 
b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100 
c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100 
d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2 

# Q2
# --


# Q3
# --
rm(list=ls())
install.packages("pgmm")
library(pgmm)
data(olive)
olive = olive[,-1]

newdata = as.data.frame(t(colMeans(olive)))

mdl <- train(Area~.,olive,method="rpart")
predict(mdl,newdata)



# Q4
# --
rm(list=ls())
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

trainSA$chd <- as.factor(trainSA$chd)
testSA$chd <- as.factor(testSA$chd)
mdl <- train(chd~age+alcohol+obesity+tobacco+typea+ldl, 
             trainSA, 
             method="glm", 
             family="binomial")

predtrain <- predict(mdl,trainSA)
predtest <- predict(mdl,testSA)

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
missClass(as.numeric(as.character(testSA$chd)),as.numeric(as.character(predtest)))
missClass(as.numeric(as.character(trainSA$chd)),as.numeric(as.character(predtrain)))

# Q5
# --
library(caret)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

head(vowel.train)
head(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

set.seed(33833)

mdl <- train(y~.,vowel.train,method="rf")
mdl$finalModel

varImp(mdl)

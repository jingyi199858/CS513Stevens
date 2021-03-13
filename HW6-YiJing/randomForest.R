rm(list=ls())
#install.packages('randomForest')
library(randomForest)

file<-file.choose()
cancer<-read.csv(file,na.strings = '?')
cancer$Class <- factor(cancer$Class, levels = c(2,4),labels = c("Benign", "Malignant"))
cancer<-na.omit(cancer)
idx<-sort(sample(nrow(cancer),as.integer(.70*nrow(cancer))))
training<-cancer[-idx,]
test<-cancer[idx,]
#Perform randomForest Algorithm
fit <- randomForest( Class~., data=training, importance=TRUE, ntree=1000)
importance(fit)
varImpPlot(fit)
Prediction <- predict(fit, test)
table(actual=test$Class, Prediction)
#Measure Error Rate
wrong<- (test$Class!=Prediction )
error_rate<-sum(wrong)/length(wrong)
error_rate 


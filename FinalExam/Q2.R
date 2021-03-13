rm(list=ls())
#install.packages('randomForest')
library(randomForest)

file<-file.choose()
Admission<-read.csv(file,na.strings = '?')
Admission$ADMIT <- factor(Admission$ADMIT)
Admission<-na.omit(Admission)
idx<-sort(sample(nrow(Admission),as.integer(.30*nrow(Admission))))
training<-Admission[-idx,]
test<-Admission[idx,]
#Perform randomForest Algorithm
fit <- randomForest( ADMIT~., data=training, importance=TRUE, ntree=1000)
importance(fit)
varImpPlot(fit)
Prediction <- predict(fit, test)
table(actual=test$ADMIT, Prediction)
#Measure Error Rate
wrong<- (test$ADMIT!=Prediction )
error_rate<-sum(wrong)/length(wrong)
error_rate 

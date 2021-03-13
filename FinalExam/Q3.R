rm(list=ls())
library(C50)
file<-file.choose()
Admission<-read.csv(file,na.strings = '?')
table(Admission$ADMIT)
Admission$ADMIT <- factor(Admission$ADMIT)
idx<-sort(sample(nrow(Admission),as.integer(.30*nrow(Admission))))
training<-Admission[-idx,]
test<-Admission[idx,]
#Perform C50 Algorithm
model<-C5.0(ADMIT~.,data=training)
summary(model)
plot(model)
prediction<-predict(model,test) 
table(actual=test[,2],prediction)
#Measure Error Rate
wrong<- (test[,2] != prediction)
c50_error_rate<-sum(wrong)/length(test[,2])
c50_error_rate




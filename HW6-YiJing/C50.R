rm(list=ls())
library(C50)
file<-file.choose()
cancer<-read.csv(file,na.strings = '?')
table(cancer$Class)
cancer$Class <- factor(cancer$Class, levels = c(2,4),labels = c("Benign", "Malignant"))
idx<-sort(sample(nrow(cancer),as.integer(.70*nrow(cancer))))
training<-cancer[idx,]
test<-cancer[-idx,]
#Perform C50 Algorithm
model<-C5.0(Class~.,data=training)
summary(model)
plot(model)
prediction<-predict(model,test,type="class") 
table(actual=test[,11],prediction)
#Measure Error Rate
wrong<- (test[,11] != prediction)
c50_error_rate<-sum(wrong)/length(test[,11])
c50_error_rate




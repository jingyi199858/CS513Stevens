#  First Name       : Khasha
#  Last Name        : Dehnad   
#  Purpose          : Midterm Solution 
#                   :  
#  Creation date    : 


#6 (15 Points):  Naïve Bayes: 
#Load the "Adult_Income_Bayes.csv"

rm(list=ls())
file<-file.choose()
#a)	Remove any row with missing values
dsn<-  read.csv(file, na.strings = " ?")
dsn2<-na.omit(dsn)
#b)	Select every fifth record, starting with the first record,
#as the test dataset and the remaining records as the training dataset

index<- seq(1,nrow(dsn2), by=5)
test<-dsn2[index,]
training<-dsn2[-index,]


#c)	Perform Naïve Bayes 
## Naive Bayes classification using all variables 
library(e1071)
nBayes <- naiveBayes(Income~., data =training)


#d)	Score the test dataset
#e)	Measure the error rate. 
category_all<-predict(nBayes,test  )



table(NBayes=category_all,Survived=test$Income)
NB_wrong<-sum(category_all!=test$Income )
NB_error_rate<-NB_wrong/length(category_all)
NB_error_rate









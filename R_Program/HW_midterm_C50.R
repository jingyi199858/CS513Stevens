#  First Name       : Khasha
#  Last Name        : Dehnad   
#  Purpose          : Midterm 5=c5.0 Solution 
#                   :  
#  Creation date    : 
rm(list=ls())
#8 (15 Points):  C5.0 analysis: 
#Load the "Adult_Income_Dtree.csv"

 
file<-file.choose()
dsn<-  read.csv(file)


#a)	Select every fifth record, starting with the first record, as the test dataset and the remaining records as the training dataset
index<- seq(1,nrow(dsn), by=5)
test<-dsn[index,]
training<-dsn[-index,]

#b)	Perform C5.0 analysis 
library('C50')
C50_class <- C5.0(  Income~.,data=training )

#c)	Score the test dataset
#d)	Measure the error rate.
C50_predict<-predict( C50_class ,test , type="class" )
table(actual=test[,"Income"],C50=C50_predict)
wrong<- (test[,"Income"]!=C50_predict)
c50_rate<-sum(wrong)/length(test[,"Income"])
c50_rate
 
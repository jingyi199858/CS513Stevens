#  First Name       : Khasha
#  Last Name        : Dehnad   
#  Purpose          : Midterm CART Solution 
#                   :  
#  Creation date    : 






rm(list=ls())

#7 (15 Points):  CART analysis: 
#Load the "Adult_Income_Dtree.csv"
rm(list=ls())
file<-file.choose()
dsn<-  read.csv(file)


#a)	Select every fifth record, starting with the first record, as the test dataset and the remaining records as the training dataset
index<- seq(1,nrow(dsn), by=5)
test<-dsn[index,]
training<-dsn[-index,]

#b)	Perform CART analysis

library(rpart)
library(rpart.plot)  			# Enhanced tree plots
library(rattle)           # Fancy tree plot
library(RColorBrewer)     # colors needed for rattle

#c)	Score the test dataset
CART_Income <-rpart( Income~.,data=training)
rpart.plot(CART_Income )
CART_predict2<-predict( CART_Income,test, type="class") 
table(Actual=test[,11],CART=CART_predict2)
 

#d)	Measure the error rate.
CART_wrong<-sum(test[,11]!=CART_predict2)
CART_error_rate<-CART_wrong/length(CART_predict2)
CART_error_rate

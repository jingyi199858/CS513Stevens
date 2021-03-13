#############################################################
#
#  First Name       : Khasha
#  Last Name        : Dehnad   
#  Purpose          : Solution to the final exam 
#                   : Problem 4 
#  Creation date    : 
###########################################################





rm(list=ls())

#4 (20 Points):   
#   Load the "IBM_Attrition_v3.csv".
#   Read all the columns as numeric variables except the "Attrition" and "MaritalStatus" columns. Perform the following tasks:
# a)	Delete rows with missing values
# b)	Select every third record, starting with the first record,
#     as the test dataset and the remaining records as the training dataset
# c)	Perform Random Forest classification for the "attrition" column  
# d)	Score the test dataset
# e)	Measure the error rate. 

rm(list=ls())
file<-file.choose()
#a)	Remove any row with missing values
dsn1<-  read.csv(file, na.strings = " ?")
dsn<-na.omit(dsn)

index<- seq(1,nrow(dsn), by=3)
test<-dsn[index,]
training<-dsn[-index,]

fit <- randomForest(  Attrition~., data=training, importance=TRUE, ntree=100)
importance(fit)
varImpPlot(fit)
dev.off()
Prediction <- predict(fit, test)
table(actual=test[,6],Prediction)


wrong<- (test[,6]!=Prediction )
error_rate<-sum(wrong)/length(wrong)
error_rate 





rm(list=ls())

file<-file.choose()
bc <-  read.csv(file,
                na.strings = "?",)

#install.packages("rpart")
#install.packages("rpart.plot")     
#install.packages("rattle")         
#install.packages("RColorBrewer")   
library(rpart)
library(rpart.plot)  			
library(rattle)           
library(RColorBrewer)     

index<-sort(sample(nrow(bc),round(.30*nrow(bc ))))
training<-bc[-index,]
test<-bc[index,]

?rpart()


CART_class<-rpart( Infected~.,data=training[,-1])
rpart.plot(CART_class)
CART_predict2<-predict(CART_class,test, type="class")
df<-as.data.frame(cbind(test,CART_predict2))
table(Actual=test[,"Infected"],CART=CART_predict2)

CART_wrong<-sum(test[,"Infected"]!=CART_predict2)

error_rate=CART_wrong/length(test$Infected)

dev.off()







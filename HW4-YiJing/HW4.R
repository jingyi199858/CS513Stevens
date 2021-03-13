rm(list=ls())
file<-file.choose()
bc_raw<-  read.csv(file,
                   na.strings = "?",
                   colClasses=c("Sample"="character",
                                "F1"="factor","F2"="factor","F3"="factor",
                                "F4"="factor","F5"="factor","F6"="factor",
                                "F7"="factor","F8"="factor","F9"="factor",
                                "Class"="factor"))


data_delete<-na.omit(bc_raw)
data_delete$Class<-factor(data_delete$Class,levels = c(2,4),labels = c("benign","malignant"))
idx<-sample(2,nrow(data_delete),replace = TRUE,prob = c(0.7,0.3))
training <- data_delete[idx==1,]
training
test <- data_delete[idx==2,]

#install.packages('e1071', dependencies = TRUE)

library(e1071)


nBayes <- naiveBayes(factor(Class)~., data =training[,-1])


category_all<-predict(nBayes,test[,-1]  )


table(NBayes=category_all,Class=test$Class)
NB_wrong<-sum(category_all!=test$Class )
NB_error_rate<-NB_wrong/length(category_all)
NB_error_rate


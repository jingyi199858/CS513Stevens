rm(list=ls())
file<-file.choose()
bc_raw<-  read.csv(file,
                   na.strings = "?")


is.factor(bc_raw$F1)
bc<-na.omit(bc_raw)

idx<-sort(sample(nrow(bc),as.integer(.70*nrow(bc))))

training<-bc[idx,]

test<-bc[-idx,]

#install.packages('e1071', dependencies = TRUE)

library(e1071)


nBayes <- naiveBayes(factor(Infected)~., data =training[,-1])


category_all<-predict(nBayes,test[,-1]  )


table(NBayes=category_all,Infected=test$Infected)
NB_wrong<-sum(category_all!=test$Infected )
NB_error_rate<-NB_wrong/length(category_all)
NB_error_rate


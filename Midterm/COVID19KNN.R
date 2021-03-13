remove(list=ls())
dev.off()
file<-file.choose()
bc<- read.csv(file, na.strings = "?", colClasses=c("Infected"="factor" ))
is.factor(bc$Class)
bc_clean<-na.omit(bc)

index<-sort(sample(nrow( bc_clean),round(.30*nrow(bc_clean ))))
training<- bc_clean[-index,]
test<- bc_clean[index,]

library(kknn) 
predict_k1 <- kknn(formula= Infected~., training[,c(-1)] , test[,c(-1)], k=5,kernel ="rectangular"  )

fit <- fitted(predict_k1)
table(test$Infected,fit)

wrong<- ( test$Infected!=fit)
rate<-sum(wrong)/length(wrong)
rate





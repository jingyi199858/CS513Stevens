rm(list=ls())
file<-file.choose()
Admission<-read.csv(file)

summary(Admission)
summary(Admission$GRE)
summary(Admission$GPA)

Admission<-na.omit(Admission)
Admission<-Admission[-1]
Admission_dist<-dist(Admission[,c(2,3)])

#Perform Hclust Algorithm
hclust_resutls<-hclust(Admission_dist )
plot(hclust_resutls)
hclust_2<-cutree(hclust_resutls,2)
table(Cluster=hclust_2,Actual=Admission[,1])

#Perform K mean Algorithm
kmeans_2<- kmeans(Admission[,c(2,3)],2,nstart = 10)
kmeans_2$cluster
table(kmeans_2$cluster,Actual=Admission[,1])

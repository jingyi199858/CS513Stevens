
rm(list=ls())
set.seed(123)
data(iris)
View(iris)
#install.packages("kohonen")
library("kohonen")
?som()
example(som)
##Define max-min normalization function
mmnorm <-function(x) {z<-((x-min(x))/(max(x)-min(x)))
return(z) 
}
training<-iris[,-5]

iris_som<-som(as.matrix(training), grid = somgrid(3,1))


summary(iris_som)
str(iris_som)
iris_som$unit.classif

table(cluster=iris_som$unit.classif,iris[,5])

plot(iris_som)
summary(iris_som)
map(iris_som,as.matrix(iris[,-5]))



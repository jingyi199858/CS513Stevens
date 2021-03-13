#Yi Jing, cs513 HW2
rm(list=ls())
file<-file.choose()
data <- read.csv(file,na.string="?")
View(data)
#Summarizing each column (e.g. min, max, mean )
summary(data)

#Identifying missing values
df<- data.frame(data)
is.na(df)
sum(is.na(df))

#Replacing the missing values with the “mean” of the column.
installed.packages()
install.packages("imputeTS")
library(imputeTS)
df <- na_mean(df)

is.na(df)
sum(is.na(df))

#Displaying the frequency table of “Class” vs. F6
ftable <- table(data$Class,data$F6)
print(ftable)
#Displaying the scatter plot of F1 to F6, one pair at a time
pairs(df[2:7],main = "Pair F1 to F6", pch = 21,bg =c("red","blue")[factor(df$Class)])

#Show histogram box plot for columns F7 to F9
boxplot(df[8:10])

rm(list=ls())
file<-file.choose()
data1 <- read.csv(file,na.string="?")

is.na(data1)
sum(is.na(data1))

data1_removed<-na.omit(data1)
is.na(data1_removed)
sum(is.na(data1_removed))


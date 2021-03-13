rm(list=ls())

file<-file.choose()
EDA<-  read.csv(file,na.strings = " ?")

#identify missing value
summary(EDA)
is.na(EDA)
sum(is.na(EDA))

mytable <- table(EDA$Infected, EDA$MaritalStatus)
mytable

plot(EDA$Age, EDA$MaritalStatus)
plot(EDA$Age, EDA$MonthAtHospital)
plot(EDA$MaritalStatus, EDA$MonthAtHospital)

boxplot(EDA$Age, EDA$MaritalStatus)
boxplot(EDA$Age, EDA$MonthAtHospital)
boxplot(EDA$MaritalStatus, EDA$MonthAtHospital)


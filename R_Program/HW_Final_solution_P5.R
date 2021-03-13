#############################################################
#
#  First Name       : Khasha
#  Last Name        : Dehnad   
#  Purpose          : Solution to the final exam 
#                   : Problem 5 
#  Creation date    : 
###########################################################

#5 (20 Points)
#Using hclust, categorize the "IBM_Attrition_v3.csv" data
#into two (2) clusters using all the columns 
#except the "Attrition" and "MaritalStatus" columns.
#Tabulate the clustered rows against the "Attrition" column.
#(Remove the rows with missing values first)  



rm(list=ls())
file<-file.choose()
#a)	Remove any row with missing values
dsn_hclust1<-  read.csv(file, na.strings = " ?")
dsn_hclust  <-na.omit(dsn_hclust1)

## min max normalizing function
mmnorm2 <-function(x)
{z<-((x-min(x))/(max(x)-min(x)))
return(z)                              
}

myvector<-1:20
mmnorm2(myvector)

## noralizing the data
dsn_hclust_norm<-data.frame( Age=mmnorm2(dsn_hclust$Age)
                       ,JobSatisfaction=mmnorm2(dsn_hclust$JobSatisfaction)
                       ,MonthlyIncome=mmnorm2(dsn_hclust$MonthlyIncome)
                       ,YearsAtCompany=mmnorm2(dsn_hclust$YearsAtCompany)
                       ,Attrition=dsn_hclust$Attrition
)

dsn_hdist<-dist(dsn_hclust_norm[,-5] )
hclust_resutls<-hclust(dsn_hdist )
dev.off()
plot(hclust_resutls)
hclust_2<-cutree(hclust_resutls,2)
table(Cluster=hclust_2,Actual=dsn_hclust_norm[,5] )

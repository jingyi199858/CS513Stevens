#############################################################
#
#  First Name       : Khasha
#  Last Name        : Dehnad   
#  Purpose          : Solution to the final exam 
#                   : Problem 6 
#  Creation date    : 
###########################################################

#6 (20 Points)
#Using k-means, categorize the "IBM_Attrition_v3.csv" data
#into two (2) clusters using all the columns except
#the "Attrition" and "MaritalStatus" column.
#Tabulate the clustered rows against the "Attrition" column.
#(Remove the rows with missing values first)  




rm(list=ls())
file<-file.choose()
#a)	Remove any row with missing values
dsn_kmeans1<-  read.csv(file, na.strings = " ?")
dsn_kmeans   <-na.omit(dsn_kmeans1 )

## min max normalizing function
mmnorm2 <-function(x)
{z<-((x-min(x))/(max(x)-min(x)))
return(z)                              
}
## test the vector
myvector<-1:20
mmnorm2(myvector)

## noralizing the data
dsn_kmeans_norm<-data.frame( Age=mmnorm2( dsn_kmeans$Age)
                       ,JobSatisfaction=mmnorm2( dsn_kmeans$JobSatisfaction)
                       ,MonthlyIncome=mmnorm2( dsn_kmeans$MonthlyIncome)
                       ,YearsAtCompany=mmnorm2( dsn_kmeans$YearsAtCompany)
                       ,Attrition=dsn_kmeans$Attrition
)


dev.off()


kmeans_clust<- kmeans( dsn_kmeans_norm[,-5],2,nstart = 10)
kmeans_clust$cluster
table( kmeans_clust$cluster,Actual=dsn_kmeans_norm[,5]  )

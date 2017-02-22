# Creating descriptive plots for N-Back
library(lattice)
library(doBy)
library(plyr)

data_nBack <- nback_finalOne

# creating data for different age groups
data_nBack$ageGroup<-ifelse((data_nBack$Age<9),yes = (data_nBack$ageGroup='lower9'),no = (ifelse((data_nBack$Age<12),yes = (data_nBack$ageGroup='between9_11'),no = (data_nBack$ageGroup='higher11'))))
nbackTable<-summaryBy(dTag~block+ageGroup, data = data_nBack, FUN = c(mean,sd), keep.names = TRUE)
table(data_nBack$Age)

# graphs
xyplot(dTag~block|subject,data = data_nBack, auto.key = TRUE)
bwplot(dTag~block,data=data_nBack)

sum_nBack<-summaryBy(dTag~block,FUN=c(mean,sd), keep.names = TRUE, data= data_nBack)

print(sum_nBack)


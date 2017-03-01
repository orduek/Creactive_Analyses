# calculating sdq for total data - only calculation - not analyses. 

library(car)
library(ggplot2)
library(reshape)
library(plyr)
source('/home/ord/Dropbox/CreActive/Data/sdq_calc.r')
totalSdq = NULL
sdq_data <- sdq_total#read.csv('/home/ord/Dropbox/CreActive/Analysis/sdq_forR_parent.csv')
sdq_data$subjectNo = factor(sdq_data$subjectNo)
sdq_data$time = factor(sdq_data$time)
for (i in 1:nrow(sdq_data)) {
    a<- calc_sdq(sdq_data[i,1], sdq_data[i,33],sdq_data)
    totalSdq = rbind(totalSdq,a)
}
totalSdq <- rename(totalSdq, c(subNo = 'subjectNo'))
totalSdq <- rename(totalSdq, c(timeVar = 'time'))
totalSdq$subjectNo = factor(totalSdq$subjectNo)
totalSdq$time = factor(totalSdq$time)


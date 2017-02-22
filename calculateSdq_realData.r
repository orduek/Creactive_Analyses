# calculating sdq for total data

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

## reshaping data for t0 and t1
f<- melt(totalSdq)
reshapeSdq <- cast(f, subjectNo + time + variable ~ value)
boxplot(reshapeSdq$phyper_0,reshapeSdq$phyper_1)
summary(aov(pemotion_0~pemotion_1, reshapeSdq))

## aggregate data
#library(lsr)
library(doBy)
library(plyr)
library(plotrix)
sumSdq <- ddply(totalSdq, "time", summarize, mean = mean(pebdtot), std = std.error(pebdtot))
ggplot(sumSdq, aes(x=time, y=mean, fill = time)) + geom_bar(position = position_dodge(), stat = "identity", width=0.5) +
    geom_errorbar(aes(ymin=mean-std, ymax=mean+std), width=0.2) + ylab("Total SDQ Score") + xlab("Time")


sumSdq.hyper <- ddply(totalSdq, "time", summarize, mean = mean(phyper), std = std.error(phyper))
hyperPlot<- ggplot(sumSdq.hyper, aes(x=time, y=mean)) + geom_bar(position = position_dodge(), stat = "identity", width=0.5) +
    geom_errorbar(aes(ymin=mean-std, ymax=mean+std), width=0.2) + theme_bw() + xlab("Time") + ylab("SDQ - HyperActivity")

sumSdq.emotion <- ddply(totalSdq, "time", summarize, mean = mean(pemotion), std = std.error(pemotion))
ggplot(sumSdq.emotion, aes(x=time, y=mean, fill = time)) + geom_bar(position = position_dodge(), stat = "identity", width=0.5) +
    geom_errorbar(aes(ymin=mean-std, ymax=mean+std), width=0.2) + ylab("Mean Emotional Score") + ggtitle("Difference between T0 and T1 in Emotional SDQ Score") + theme_minimal()

sumSdq.conduct <- ddply(totalSdq, "time", summarize, mean = mean(pconduct), std = std.error(pconduct))
ggplot(sumSdq.conduct, aes(x=time, y=mean)) + geom_bar(position = position_dodge(), stat = "identity", width=0.5) +
    geom_errorbar(aes(ymin=mean-std, ymax=mean+std), width=0.2) + theme_bw()


# outlire subject 123
sumSdq_outlire <- ddply(sdq_outlire, "time", summarize, mean = mean(pebdtot), std = std.error(pebdtot))
ggplot(sumSdq_outlire, aes(x=time, y=mean, fill = time)) + geom_bar(position = position_dodge(), stat = "identity", width=0.5) +
    geom_errorbar(aes(ymin=mean-std, ymax=mean+std), width=0.2) + ylab("Total SDQ Score") + xlab("Time")

## reshaping data for t0 and t1 excluding outlire
f<- melt(sdq_outlire)
reshapeSdq <- cast(f, subjectNo ~ variable + time)
boxplot(reshapeSdq$pebdtot_0,reshapeSdq$pebdtot_1)
summary(aov(pebdtot_0~pebdtot_1, reshapeSdq))

# scatter plot of sdq scores
ggplot(totalSdq, aes(y=phyper,x=subjectNo, color = time)) + geom_point(size=2) + scale_colour_manual(values=c("#FF0000","#0000FF"))

# Anova 
summary(aov(pebdtot~time + Error(subjectNo), data=totalSdq))
summary(aov(pemotion~time + Error(subjectNo), data=totalSdq))
summary(aov(phyper~time + Error(subjectNo), data= totalSdq))

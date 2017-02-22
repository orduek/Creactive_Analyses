# Analyse Corsi block task

# In this analysis output is correct answer for forward and backward (for each subject) + the total score (forward and backward) for each subject. Final is a data frame with subject, score for each (correctAns) and totalScore.

# take subject - clean data:
#1. remove practice sessions.
#2. remove everything that is not forward or backward

# create score
#1. calculate forward score (sum of all correctAns)
#2. calculate backward score (sum of all correctAns)
#3. calculate total Corsi score
#4. Add normative data (?)

# add to total data of subject

corsi_dat2<- subset(corsi_dat, direction != "NA") # remove trials of instructions etc.

corsi_dat2 <- subset(corsi_dat2, is.na(block)) # leave only NA values in Block (is set to either practice or NA)

library(doBy)
corsi_sum <- summaryBy(correctAns ~ subject + direction, keep.names = TRUE, FUN = sum, data = corsi_dat2)
total <- summaryBy(correctAns ~ subject, FUN=sum, data = corsi_dat2, var.names = "totalScore", keep.names = TRUE)
corsi_sum <- merge(corsi_sum, total)

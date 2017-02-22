# calculating SDQ

# Script to read csv files of sdq (from excell - until we start using web based data)

sdqT0 <- read.csv('/home/ord/Dropbox/CreActive/Data/questionnaires_sheets/sdq_qT0.csv')
sdqT1 <- read.csv('/home/ord/Dropbox/CreActive/Data/questionnaires_sheets/sdq_qT1.csv')

sdqT0$time <- factor(0)
sdqT1$time <- factor(1)

sdqT0$subjectNo <- factor(sdqT0$subjectNo)
sdqT1$subjectNo <- factor(sdqT1$subjectNo)

sdq_total<- rbind(sdqT0,sdqT1)

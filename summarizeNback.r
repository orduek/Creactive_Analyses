# Analyzing n-Back results.
# use Stanislaw & Todorov, 1999 for coplete explanation. And use ""ormative data on the n-back task for children and young adolescents" - for reference on total calculation. 

# 1. clean data --> leave subject, RT, block type etc.
# 2. Calculate HRT (Hit reaction time) - only when subject identifies correctly a target
# 3. Calculate d' for each subject (d' = z(hit rate) - z(false alarm rate))
    # a. Identified if Hit/Correct Rejection/False Alarm/ Miss
    # b. Take hit to calculate HRT then average it
    # c. take hit and FA to calculate d'
# Hit rate --> Total number of hit / total target trials.
# FA rate --> number of FA / total number of noise trials (distractors)
# start cleanning
#if needed nback_dat <- totalnBack

#nback_dat <- nBack
nback_dat$subject <- factor(nback_dat$subject) # set subject as factor to remove non relevant
nback_dat2 <- subset (nback_dat, block == "one-back" | block == "two-back")

# making a nested ifelse statement that checks if target (and then if Hit or Miss) or if distractor (and the if Correct Rejection or False Alarm)

nback_dat2$accuracy <- ifelse((nback_dat2$condition=="target"),yes = ifelse((nback_dat2$answer==1),yes = (nback_dat2$accuracy = "hit"), no = (nback_dat2$accuracy = "miss")), no = ifelse((nback_dat2$answer==1),yes = (nback_dat2$accuracy = "CR"), no = (nback_dat2$accuracy = "FA")))

# now should calculate d' for each subject
checknBack <- nback_dat2[c("subject","accuracy","block")]
# should do rate (10 targets for each block and 20 distractors)

nback_sum <- as.data.frame(table(checknBack)) # summarize freqencies of miss,hit etc.
library(doBy)
# now create a table with each subcet and his total freq. of miss/hit etc.
nback_sum_Total <- summaryBy(Freq ~ subject + accuracy + block ,data = nback_sum, FUN = sum, keep.names = TRUE)

# should calculate d' for each subject: 1. rate of Hit for each subject and rate of FA.
# proportion of hit from hit/miss and proportion of FA from FA and CR. then multiplie by 0.5 to scale it.

# ifelse statment to calculate hit and FA rates for each subject. 
nback_sum_Total$hitRate <- ifelse((nback_sum_Total$accuracy=="hit"),yes = (nback_sum_Total$hitRate=nback_sum_Total$Freq/10),no = ifelse ((nback_sum_Total$accuracy=="FA"),yes = (nback_sum_Total$hitRate= nback_sum_Total$Freq/20), no = (nback_sum_Total$hitRate="Irr")))

# now should calculate d' for each
nback_nonIrr <- subset(nback_sum_Total, hitRate != "Irr")
nback_nonIrr$hitRate <- as.numeric (nback_nonIrr$hitRate)

# using qnorm to transform propotion of Hit and FA to z scores. 
# changing 0 or 1 in Hit rate or FA rate to using Stanislaw & Stolorow's method. if 1 - then replace with (n-0.5)/n. If 0 then replace with 0.5/n (n is either number of targets or of distractors)
nback_nonIrr$hitRateP<-ifelse((nback_nonIrr$accuracy=="hit"),yes = (ifelse((nback_nonIrr$hitRate==0.00),yes = (nback_nonIrr$hitRateP=(0.5/10)),no = ifelse((nback_nonIrr$hitRate==1.00),yes = (nback_nonIrr$hitRateP=((10-0.5)/10)), no = (nback_nonIrr$hitRateP=nback_nonIrr$hitRate)))), no = (ifelse((nback_nonIrr$hitRate==0.00),yes = (nback_nonIrr$hitRateP=(0.5/20)),no = ifelse((nback_nonIrr$hitRate==1.00),yes = (nback_nonIrr$hitRateP=((10-0.5)/20)), no = (nback_nonIrr$hitRateP=nback_nonIrr$hitRate)))))

# now calculate for blockOne
blockOne<- subset(nback_nonIrr, block == "one-back")
dTagOne <- (qnorm(blockOne$hitRateP[blockOne$accuracy=="hit"]) ) - (qnorm(blockOne$hitRateP[blockOne$accuracy=="FA"]))
blockOne <- subset(blockOne, accuracy == "hit") # use it keep only one subject row for each block
blockOne$dTag <- dTagOne  # now I have in blockOne a data.frame with d' of every subject.

# do for second block
blockTwo <- subset(nback_nonIrr, block == "two-back")
dTagTwo <- (qnorm(blockTwo$hitRateP[blockTwo$accuracy=="hit"])) - (qnorm(blockTwo$hitRateP[blockTwo$accuracy=="FA"]))
blockTwo <- subset (blockTwo, accuracy=="hit")  # use it keep only one subject row for each block
blockTwo$dTag <- dTagTwo

# now chould combine blockOne and blockTwo to create data frame with d' for each block and subject
nback_finalOne <- rbind(blockOne,blockTwo)



#nback_finalKaraso<-rbind(nback_finalKaraso,nback_finalOne)

#nback_final$subject<-factor(nback_final$subject)
# should also calculate HRT

#save(nback_finalKaraso,file = "nback_finalKaraso") # saving the final data frame to a file (for use in scripts)


# if has duplicates use unique 
data_nBack <- unique(data_nBack)
save(data_nBack,file = 'data_nBack')

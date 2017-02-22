# calculating PTSD scores

# cluster B (should have one or more)
# items: 5,10,11,14,18
calcB <- function(x) { # simple function to test if items are 3+ or not
    ifelse(x>2, 1, 0)
}
clusterB <- ucla.dat[c(1,6,11,12,15,19)] # only cluster b variables
clusterBCalc <- apply(clusterB[,2:6], MARGIN = 1, FUN = calcB)
# should transform it back
clusterBCalc <- t(clusterBCalc)

# calculate Cluster C (should have one or more)
# item: 3,13
clusterC<- ucla.dat[c(1,4,14)]
clusterCcalc <- apply(clusterC[,2:3], MARGIN = 1, FUN = calcB)
clusterCcalc <- t(clusterCcalc)
# calculate cluster D (two or more)
# items: 23,(2*,9*,16* -- higher from those three) ,(15*,19* -- higher from those two),(6*,22*,25*,27* - higher),7,17,12


# calculate cluster E (two or more)
# items: 4, (20*, 26* -- the highest only), 1,24,8,21

# should add dissociative symptoms. 

# if score is 3 or 4 then symptom is present. If not - not present. 
# should also add total score of ptsd. 

ucla.dat$total<- rowSums(ucla.dat[,2:32], na.rm = TRUE) # rowSums sums per row. 

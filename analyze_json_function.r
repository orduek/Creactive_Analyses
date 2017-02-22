analyze_dat <- function (fileName) {
    file <- read.csv(fileName, sep = ";", quote = "")
    datName<-NULL
    for (i in 1:length(file)) {
        dat<- fromJSON(as.character(file[i,3]))
        dat$subject <- as.factor(file[i,2])
        datName<- rbind(datName,dat)
    }
    return(datName)
}
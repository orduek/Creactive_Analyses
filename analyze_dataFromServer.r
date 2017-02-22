# Reading JSON files for analysis
library(jsonlite)
source('/home/ord/Documents/R project/Creactive/analyze_json_function.r')
# Corsi
corsi_dat<-analyze_dat('/home/ord/Dropbox/CreActive/Data/fromServer/CREACTIVEAmbulatoryTasksCorsi(3).csv')

# reading nBack JSON file
nback_dat<-analyze_dat('/home/ord/Dropbox/CreActive/Data/fromServer/CREACTIVEAmbulatoryTasksNback(3).csv')

# reading dotComparison
dotComp_dat<- analyze_dat('/home/ord/Dropbox/CreActive/Data/fromServer/CREACTIVEAmbulatoryTasksDotComparison(2).csv')

goNogo_dat<- analyze_dat('/home/ord/Dropbox/CreActive/Data/fromServer/CREACTIVEAmbulatoryTasksGoNoGo(2).csv')

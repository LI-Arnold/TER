library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf)


### Charger les mesures des participants 

dataset <- lapply(Sys.glob("/home/user/Bureau/TER/Donnees/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",",stringsAsFactors=FALSE)
df <- do.call(rbind, dataset)

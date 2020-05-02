library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf)


### Charger les mesures des participants 

dataset <- lapply(Sys.glob("TER/Donnees/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",")
df <- do.call(rbind, dataset)
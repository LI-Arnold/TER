library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf)


### Charger les mesures des participants 

dataset <- lapply(Sys.glob("~/TER/Donnees/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",",stringsAsFactors=FALSE)
df <- do.call(rbind, dataset)

### convertir en numeric les valeurs de NO2, BC,humedite et temperature de carachter à numérique

df$NO2 <- as.numeric(df$NO2)
df$BC <- as.numeric(df$BC)	
df$Humidite<-as.numeric(df$Humidite)
df$Temperature <- as.numeric(df$Temperature)

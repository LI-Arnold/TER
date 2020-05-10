
library(tidyverse)
library(dplyr)
 
source("~/TER/Scripts/initialiser.r")

### changement de format de factor à time(POSIXct)
df$time <- as.POSIXlt(df$time)

### Enlever la partie secondes
df$time <- round(df$time,"mins")

### changement de format en character pour faire la jointure avec dfGPS.timestamp
df$time <- as.character(df$time )

### Charger les les donnees de GPS

datasetGPS <- lapply(Sys.glob("TER/Donnees/GPS/Participant*.csv"), read.csv, header=TRUE, sep=",",stringsAsFactors = FALSE)
dfGPS <- do.call(rbind,datasetGPS)

### changement de format de factor à time(POSIXct) 
dfGPS$timestamp<- as.POSIXct(dfGPS$timestamp)

### Enlever la partie secondes
dfGPS$timestamp<- round(dfGPS$timestamp,"mins")

### changement de format en character
dfGPS$timestamp <- as.character(dfGPS$timestamp )

### Enlever les redondances de timestamp
dfGPS<-dfGPS[! duplicated(dfGPS[, 2]), ]

### Jointure entre table des mesures et table de donnees GPS selon le id_participant et le time
GPS_Mesures<-merge(dfGPS, df, by.x = c("participant_virtual_id","timestamp"), by.y = c("participant_virtual_id","time"), all.y = TRUE)

### changement de format de character à numeric  
GPS_Mesures$Temperature<-as.integer(GPS_Mesures$Temperature)
GPS_Mesures$Humidite<-as.integer(GPS_Mesures$Humidite)
GPS_Mesures$NO2<-as.numeric(GPS_Mesures$NO2)
GPS_Mesures$BC<-as.numeric(GPS_Mesures$BC)

###  selection les colonnes avec des valeurs numeric 
	<-GPS_Mesures[,3:11]

### Matrice de correlation 
matriceCorr<-round(cor(Correlation, use = "complete.obs"),2)

### Visualisation de matriceCorr
PlotCorr<-corrplot(matriceCorr, type="upper",order="hclust", tl.col="black", tl.srt=25)





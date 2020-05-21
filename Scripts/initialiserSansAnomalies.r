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


### Charger la table des associations logiques entre événement et activité et la mettre dans un dataframe:
Activity_event<-read.csv("TER/Donnees/DonneesFiabilite.csv",header=TRUE,sep=";",stringsAsFactors = FALSE)

### Extraire les associations activity_event qui existent dans df et qui n'existent pas dans la table référence (activite_event)

ReqAnomaliesActivityEvent <- "Select *
					From df d 
					where d.event!='NULL' and not exists (select T.activity, T.event from Activity_event T where T.activity=d.activity and T.event=d.event)
					Order by 1;"
AnomaliesActivityEvent<-sqldf(ReqAnomaliesActivityEvent)

### Creation une nouvelle dataframe avec les mesures des polluants sans compter les anomalies de Activité_Evenements

ReqNouveauDF <- "Select * From df 
				except 
				select * from AnomaliesActivityEvent;"
dfSansAnomalies<-sqldf(ReqNouveauDF)
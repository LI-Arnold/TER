library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf) 

### Charger les mesures des participants 

dataset <- lapply(Sys.glob("TER/Donnees/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",",stringsAsFactors = FALSE)
df <- do.call(rbind, dataset)

### Nombre de correpondance entre activité et événement pour chaque participant :

ReqNbrMatch <-"Select participant_virtual_id, activity, event, count(*) as Nbr_Occurrences From df Group by activity, event,participant_virtual_id, activity;"
NbrMatch <- sqldf(ReqNbrMatch)

### Charger la table des associations logiques entre évènement et activité et la mettre dans un dataframe:

Activity_event<-read.csv("TER/Donnees/DonneesFiabilite.csv",header=TRUE,sep=";",stringsAsFactors = FALSE)
reqActivity_event <- "SELECT * FROM  Activity_event;"
activite_event <- sqldf(reqActivity_event)

### Extraire les associations activity_event qui existent dans df et qui n'existent pas dans la table référence (activite_event)

ReqAnomaliesActivityEvent <- "Select d.participant_virtual_id,d.time,d.activity,d.event 
					From df d 
					where not exists (select T.activity, T.event from activite_event T where T.activity=d.activity and T.event=d.event)
					Order by 1;"
AnomaliesActivityEvent<-sqldf(ReqAnomaliesActivityEvent)

### Calcul nbr d'anomalies entre activity et activité

NbrAnomalies<-"select activity,event,count(*) as nbr from AnomaliesActivityEvent group by activity,event;"

library(tidyverse)

source("~/TER/Scripts/initialiserSansAnomalies.r")
Questionnaire<-read.csv("~/TER/Donnees/questionnaire_participants.csv",header=TRUE,sep=",",stringsAsFactors=FALSE)

#~ convertir en numeric les valeurs de NO2 et BC

dfSansAnomalies$NO2 <- as.numeric(dfSansAnomalies$NO2)
dfSansAnomalies$BC <- as.numeric(dfSansAnomalies$BC)		
 
   #~ la moyenne de PM1.0 par activity pour chaque participant
   
req1 <- "SELECT Questionnaire.participant_virtual_id
     , AVG(\"PM1.0\") FILTER (WHERE activity = 'Domicile') 'Domicile'
     , AVG(\"PM1.0\") FILTER (WHERE activity = 'Bureau') 'Bureau'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Rue') 'Rue'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Voiture') 'Voiture'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Vélo') 'Vélo'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Bus') 'Bus'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Train') 'Train'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Restaurant') 'Restaurant'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Métro') 'Métro'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Magasin') 'Magasin'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Parc') 'Parc'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Cinéma') 'Cinéma'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Tramway') 'Tramway'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Inconnu') 'Inconnu'
		FROM Questionnaire,dfSansAnomalies WHERE Questionnaire.participant_virtual_id = dfSansAnomalies.participant_virtual_id	
		GROUP BY Questionnaire.participant_virtual_id;"
 ActivitePM1.0<-sqldf(req1)
 # Arrondir l'avg à deux chiffres après la virgule
 ActivitePM1.0<-ActivitePM1.0 %>% mutate_if(is.numeric, round, digits=2)
 
   #~ la moyenne de PM10 par activity pour chaque participant
   
req2 <- "SELECT Questionnaire.participant_virtual_id
     , AVG(\"PM10\") FILTER (WHERE activity = 'Domicile') Domicile
     , AVG(\"PM10\") FILTER (WHERE activity = 'Bureau') Bureau
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Rue') Rue
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Voiture') Voiture
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Vélo') Vélo
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Bus') Bus
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Train') Train
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Restaurant') Restaurant
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Métro') Métro
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Magasin') Magasin
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Parc') Parc
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Cinéma') Cinéma
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Tramway') Tramway
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Inconnu') Inconnu
	FROM Questionnaire,dfSansAnomalies WHERE Questionnaire.participant_virtual_id = dfSansAnomalies.participant_virtual_id	
		GROUP BY Questionnaire.participant_virtual_id;"
 ActivitePM10<-sqldf(req2)
  ActivitePM10<-ActivitePM10 %>% mutate_if(is.numeric, round, digits=2)
  
   #~ la moyenne de PM2.5 par activity pour chaque participant
   
req3 <- "SELECT Questionnaire.participant_virtual_id
     , AVG(\"PM2.5\") FILTER (WHERE activity = 'Domicile') 'Domicile'
     , AVG(\"PM2.5\") FILTER (WHERE activity = 'Bureau') 'Bureau'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Rue') 'Rue'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Voiture') 'Voiture'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Vélo') 'Vélo'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Bus') 'Bus'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Train') 'Train'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Restaurant') 'Restaurant'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Métro') 'Métro'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Magasin') 'Magasin'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Parc') 'Parc'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Cinéma') 'Cinéma'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Tramway') 'Tramway'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Inconnu') 'Inconnu'
	FROM Questionnaire,dfSansAnomalies WHERE Questionnaire.participant_virtual_id = dfSansAnomalies.participant_virtual_id		
		GROUP BY Questionnaire.participant_virtual_id;"
 ActivitePM2.5<-sqldf(req3)
 ActivitePM2.5<-ActivitePM2.5 %>% mutate_if(is.numeric, round, digits=2)
	
#~ la moyenne de NO2 par activity pour chaque participant

req4<-"SELECT Questionnaire.participant_virtual_id
     , AVG(NO2) FILTER (WHERE activity = 'Domicile') Domicile
     , AVG(NO2) FILTER (WHERE activity = 'Bureau') Bureau
	 , AVG(NO2) FILTER (WHERE activity = 'Rue') Rue
	 , AVG(NO2) FILTER (WHERE activity = 'Voiture') Voiture
	 , AVG(NO2) FILTER (WHERE activity = 'Vélo') Vélo
	 , AVG(NO2) FILTER (WHERE activity = 'Bus') Bus
	 , AVG(NO2) FILTER (WHERE activity = 'Train') Train
	 , AVG(NO2) FILTER (WHERE activity = 'Restaurant') Restaurant
	 , AVG(NO2) FILTER (WHERE activity = 'Métro') Métro
	 , AVG(NO2) FILTER (WHERE activity = 'Magasin') Magasin
	 , AVG(NO2) FILTER (WHERE activity = 'Parc') Parc	
	 , AVG(NO2) FILTER (WHERE activity = 'Cinéma') Cinéma
	 , AVG(NO2) FILTER (WHERE activity = 'Tramway') Tramway
	 , AVG(NO2) FILTER (WHERE activity = 'Inconnu') Inconnu
	FROM Questionnaire,dfSansAnomalies WHERE Questionnaire.participant_virtual_id = dfSansAnomalies.participant_virtual_id	
		GROUP BY Questionnaire.participant_virtual_id;"
 ActiviteNO2<-sqldf(req4)
 ActiviteNO2<-ActiviteNO2 %>% mutate_if(is.numeric, round, digits=2)
 
#~ la moyenne de BC par activity pour chaque participant

req5 <- "SELECT Questionnaire.participant_virtual_id
     , AVG(BC) FILTER (WHERE activity = 'Domicile') Domicile
     , AVG(BC) FILTER (WHERE activity = 'Bureau') Bureau
	 , AVG(BC) FILTER (WHERE activity = 'Rue') Rue
	 , AVG(BC) FILTER (WHERE activity = 'Voiture') Voiture
	 , AVG(BC) FILTER (WHERE activity = 'Vélo') Vélo
	 , AVG(BC) FILTER (WHERE activity = 'Bus') Bus
	 , AVG(BC) FILTER (WHERE activity = 'Train') Train
	 , AVG(BC) FILTER (WHERE activity = 'Restaurant') Restaurant
	 , AVG(BC) FILTER (WHERE activity = 'Métro') Métro
	 , AVG(BC) FILTER (WHERE activity = 'Magasin') Magasin
	 , AVG(BC) FILTER (WHERE activity = 'Parc') Parc
	 , AVG(BC) FILTER (WHERE activity = 'Cinéma') Cinéma
	 , AVG(BC) FILTER (WHERE activity = 'Tramway') Tramway
	 , AVG(BC) FILTER (WHERE activity = 'Inconnu') Inconnu
	FROM Questionnaire,dfSansAnomalies WHERE Questionnaire.participant_virtual_id = dfSansAnomalies.participant_virtual_id	
		GROUP BY Questionnaire.participant_virtual_id;"
 ActiviteBC<-sqldf(req5)
ActiviteBC<-ActiviteBC %>% mutate_if(is.numeric, round, digits=2) 


library(tidyverse)

source("~/TER/Scripts/initialiser.r")

#~ convertir en numeric les valeurs de NO2 et BC

df$NO2 <- as.numeric(df$NO2)
df$BC <- as.numeric(df$BC)		
 
   #~ la moyenne de PM1.0 par activity pour chaque participant
   
req1 <- "SELECT participant_virtual_id
     , AVG(\"PM1.0\") FILTER (WHERE activity = 'Domicile') 'PM1.0_Domicile'
     , AVG(\"PM1.0\") FILTER (WHERE activity = 'Bureau') 'PM1.0_Bureau'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Rue') 'PM1.0_Rue'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Voiture') 'PM1.0_Voiture'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Vélo') 'PM1.0_Vélo'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Bus') 'PM1.0_Bus'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Train') 'PM1.0_Train'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Restaurant') 'PM1.0_Restaurant'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Métro') 'PM1.0_Métro'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Magasin') 'PM1.0_Magasin'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Parc') 'PM1.0_Parc'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Cinéma') 'PM1.0_Cinéma'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Tramway') 'PM1.0_Tramway'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Inconnu') 'PM1.0_Inconnu'
		FROM df	
		GROUP BY participant_virtual_id;"
 ActivitePM1.0<-sqldf(req1)
 # Arrondir l'avg à deux chiffres après la virgule
 ActivitePM1.0<-ActivitePM1.0 %>% mutate_if(is.numeric, round, digits=2)
 
   #~ la moyenne de PM10 par activity pour chaque participant
   
req2 <- "SELECT participant_virtual_id
     , AVG(\"PM10\") FILTER (WHERE activity = 'Domicile') PM10_Domicile
     , AVG(\"PM10\") FILTER (WHERE activity = 'Bureau') PM10_Bureau
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Rue') PM10_Rue
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Voiture') PM10_Voiture
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Vélo') PM10_Vélo
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Bus') PM10_Bus
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Train') PM10_Train
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Restaurant') PM10_Restaurant
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Métro') PM10_Métro
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Magasin') PM10_Magasin
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Parc') PM10_Parc
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Cinéma') PM10_Cinéma
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Tramway') PM10_Tramway
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Inconnu') PM10_Inconnu
		FROM df	
		GROUP BY participant_virtual_id;"
 ActivitePM10<-sqldf(req2)
  ActivitePM10<-ActivitePM10 %>% mutate_if(is.numeric, round, digits=2)
  
   #~ la moyenne de PM2.5 par activity pour chaque participant
   
req3 <- "SELECT participant_virtual_id
     , AVG(\"PM2.5\") FILTER (WHERE activity = 'Domicile') 'PM2.5_Domicile'
     , AVG(\"PM2.5\") FILTER (WHERE activity = 'Bureau') 'PM2.5_Bureau'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Rue') 'PM2.5_Rue'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Voiture') 'PM2.5_Voiture'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Vélo') 'PM2.5_Vélo'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Bus') 'PM2.5_Bus'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Train') 'PM2.5_Train'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Restaurant') 'PM2.5_Restaurant'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Métro') 'PM2.5_Métro'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Magasin') 'PM2.5_Magasin'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Parc') 'PM2.5_Parc'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Cinéma') 'PM2.5_Cinéma'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Tramway') 'PM2.5_Tramway'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Inconnu') 'PM2.5_Inconnu'
		FROM df	
		GROUP BY participant_virtual_id;"
 ActivitePM2.5<-sqldf(req3)
 ActivitePM2.5<-ActivitePM2.5 %>% mutate_if(is.numeric, round, digits=2)
	
#~ la moyenne de NO2 par activity pour chaque participant

req4<-"SELECT participant_virtual_id
     , AVG(NO2) FILTER (WHERE activity = 'Domicile') NO2_Domicile
     , AVG(NO2) FILTER (WHERE activity = 'Bureau') NO2_Bureau
	 , AVG(NO2) FILTER (WHERE activity = 'Rue') NO2_Rue
	 , AVG(NO2) FILTER (WHERE activity = 'Voiture') NO2_Voiture
	 , AVG(NO2) FILTER (WHERE activity = 'Vélo') NO2_Vélo
	 , AVG(NO2) FILTER (WHERE activity = 'Bus') NO2_Bus
	 , AVG(NO2) FILTER (WHERE activity = 'Train') NO2_Train
	 , AVG(NO2) FILTER (WHERE activity = 'Restaurant') NO2_Restaurant
	 , AVG(NO2) FILTER (WHERE activity = 'Métro') NO2_Métro
	 , AVG(NO2) FILTER (WHERE activity = 'Magasin') NO2_Magasin
	 , AVG(NO2) FILTER (WHERE activity = 'Parc') NO2_Parc	
	 , AVG(NO2) FILTER (WHERE activity = 'Cinéma') NO2_Cinéma
	 , AVG(NO2) FILTER (WHERE activity = 'Tramway') NO2_Tramway
	 , AVG(NO2) FILTER (WHERE activity = 'Inconnu') NO2_Inconnu
		FROM df	
		GROUP BY participant_virtual_id;"
 ActiviteNO2<-sqldf(req4)
 ActiviteNO2<-ActiviteNO2 %>% mutate_if(is.numeric, round, digits=2)
 
#~ la moyenne de BC par activity pour chaque participant

req5 <- "SELECT participant_virtual_id
     , AVG(BC) FILTER (WHERE activity = 'Domicile') BC_Domicile
     , AVG(BC) FILTER (WHERE activity = 'Bureau') BC_Bureau
	 , AVG(BC) FILTER (WHERE activity = 'Rue') BC_Rue
	 , AVG(BC) FILTER (WHERE activity = 'Voiture') BC_Voiture
	 , AVG(BC) FILTER (WHERE activity = 'Vélo') BC_Vélo
	 , AVG(BC) FILTER (WHERE activity = 'Bus') BC_Bus
	 , AVG(BC) FILTER (WHERE activity = 'Train') BC_Train
	 , AVG(BC) FILTER (WHERE activity = 'Restaurant') BC_Restaurant
	 , AVG(BC) FILTER (WHERE activity = 'Métro') BC_Métro
	 , AVG(BC) FILTER (WHERE activity = 'Magasin') BC_Magasin
	 , AVG(BC) FILTER (WHERE activity = 'Parc') BC_Parc
	 , AVG(BC) FILTER (WHERE activity = 'Cinéma') BC_Cinéma
	 , AVG(BC) FILTER (WHERE activity = 'Tramway') BC_Tramway
	 , AVG(BC) FILTER (WHERE activity = 'Inconnu') BC_Inconnu
		FROM df	
		GROUP BY participant_virtual_id;"
 ActiviteBC<-sqldf(req5)
ActiviteBC<-ActiviteBC %>% mutate_if(is.numeric, round, digits=2) 

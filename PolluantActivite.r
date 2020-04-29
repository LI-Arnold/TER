library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf)
library(tidyverse)

dataset <- lapply(Sys.glob("participant-data-semain43/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",",stringsAsFactors = FALSE)
df <- do.call(rbind, dataset)


#~ conertir en int les valeurs de NO2 et BC

		
 
   #~ la moyenne de PM1.0 par activity pour chaque participant
req3 <- "SELECT participant_virtual_id
     , AVG(\"PM1.0\") FILTER (WHERE activity = 'Domicile') 'PM1.0_Domicile'
     , AVG(\"PM1.0\") FILTER (WHERE activity = 'Bureau') 'PM1.0_Bureau'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Rue') 'PM1.0_Rue'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Voiture') 'PM1.0_Voiture'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'VÃ©lo') 'PM1.0_Vélo'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Bus') 'PM1.0_Bus'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Train') 'PM1.0_Train'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Restaurant') 'PM1.0_Restaurant'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'MÃ©tro') 'PM1.0_Métro'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Magasin') 'PM1.0_Magasin'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Parc') 'PM1.0_Parc'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'CinÃ©ma') 'PM1.0_Cinéma'
	 , AVG(\"PM1.0\") FILTER (WHERE activity = 'Tramway') 'PM1.0_Tramway'
		FROM df	
		GROUP BY participant_virtual_id;"
 ActivitePM1.0<-sqldf(req3)
 
   #~ la moyenne de PM10 par activity pour chaque participant
req4 <- "SELECT participant_virtual_id
     , AVG(\"PM10\") FILTER (WHERE activity = 'Domicile') PM10_Domicile
     , AVG(\"PM10\") FILTER (WHERE activity = 'Bureau') PM10_Bureau
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Rue') PM10_Rue
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Voiture') PM10_Voiture
	 , AVG(\"PM10\") FILTER (WHERE activity = 'VÃ©lo') PM10_Vélo
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Bus') PM10_Bus
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Train') PM10_Train
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Restaurant') PM10_Restaurant
	 , AVG(\"PM10\") FILTER (WHERE activity = 'MÃ©tro') PM10_Métro
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Magasin') PM10_Magasin
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Parc') PM10_Parc
	 , AVG(\"PM10\") FILTER (WHERE activity = 'CinÃ©ma') PM10_Cinéma
	 , AVG(\"PM10\") FILTER (WHERE activity = 'Tramway') PM10_Tramway
		FROM df	
		GROUP BY participant_virtual_id;"
 ActivitePM10<-sqldf(req4)
 
   #~ la moyenne de PM2.5 par activity pour chaque participant
req5 <- "SELECT participant_virtual_id
     , AVG(\"PM2.5\") FILTER (WHERE activity = 'Domicile') 'PM2.5_Domicile'
     , AVG(\"PM2.5\") FILTER (WHERE activity = 'Bureau') 'PM2.5_Bureau'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Rue') 'PM2.5_Rue'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Voiture') 'PM2.5_Voiture'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'VÃ©lo') 'PM2.5_Vélo'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Bus') 'PM2.5_Bus'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Train') 'PM2.5_Train'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Restaurant') 'PM2.5_Restaurant'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'MÃ©tro') 'PM2.5_Métro'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Magasin') 'PM2.5_Magasin'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Parc') 'PM2.5_Parc'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'CinÃ©ma') 'PM2.5_Cinéma'
	 , AVG(\"PM2.5\") FILTER (WHERE activity = 'Tramway') 'PM2.5_Tramway'
		FROM df	
		GROUP BY participant_virtual_id;"
 ActivitePM2.5<-sqldf(req5)
	
#~ la moyenne de NO2 par activity pour chaque participant
req1<-"SELECT participant_virtual_id
     , AVG(NO2) FILTER (WHERE activity = 'Domicile') NO2_Domicile
     , AVG(NO2) FILTER (WHERE activity = 'Bureau') NO2_Bureau
	 , AVG(NO2) FILTER (WHERE activity = 'Rue') NO2_Rue
	 , AVG(NO2) FILTER (WHERE activity = 'Voiture') NO2_Voiture
	 , AVG(NO2) FILTER (WHERE activity = 'VÃ©lo') NO2_Vélo
	 , AVG(NO2) FILTER (WHERE activity = 'Bus') NO2_Bus
	 , AVG(NO2) FILTER (WHERE activity = 'Train') NO2_Train
	 , AVG(NO2) FILTER (WHERE activity = 'Restaurant') NO2_Restaurant
	 , AVG(NO2) FILTER (WHERE activity = 'MÃ©tro') NO2_Métro
	 , AVG(NO2) FILTER (WHERE activity = 'Magasin') NO2_Magasin
	 , AVG(NO2) FILTER (WHERE activity = 'Parc') NO2_Parc
	 , AVG(NO2) FILTER (WHERE activity = 'CinÃ©ma') NO2_Cinema
	 , AVG(NO2) FILTER (WHERE activity = 'Tramway') NO2_Tramway
		FROM df	
		GROUP BY participant_virtual_id;"
 ActiviteNO2<-sqldf(req1)
 
#~ la moyenne de BC par activity pour chaque participant
req2 <- "SELECT participant_virtual_id
     , AVG(BC) FILTER (WHERE activity = 'Domicile') BC_Domicile
     , AVG(BC) FILTER (WHERE activity = 'Bureau') BC_Bureau
	 , AVG(BC) FILTER (WHERE activity = 'Rue') BC_Rue
	 , AVG(BC) FILTER (WHERE activity = 'Voiture') BC_Voiture
	 , AVG(BC) FILTER (WHERE activity = 'VÃ©lo') BC_Vélo
	 , AVG(BC) FILTER (WHERE activity = 'Bus') BC_Bus
	 , AVG(BC) FILTER (WHERE activity = 'Train') BC_Train
	 , AVG(BC) FILTER (WHERE activity = 'Restaurant') BC_Restaurant
	 , AVG(BC) FILTER (WHERE activity = 'MÃ©tro') BC_Métro
	 , AVG(BC) FILTER (WHERE activity = 'Magasin') BC_Magasin
	 , AVG(BC) FILTER (WHERE activity = 'Parc') BC_Parc
	 , AVG(BC) FILTER (WHERE activity = 'CinÃ©ma') BC_Cinéma
	 , AVG(BC) FILTER (WHERE activity = 'Tramway') BC_Tramway
		FROM df	
		GROUP BY participant_virtual_id;"
 ActiviteBC<-sqldf(req2)	

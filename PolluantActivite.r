
library(sqldf)
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
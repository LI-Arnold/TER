library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf) 

dataset <- lapply(Sys.glob("participant-data-semain43/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",")
df <- do.call(rbind, dataset)

questionnaire<-read.csv("questionnaire_participants.csv",header=TRUE,sep=",")

#~ requête qui montre la moyenne des PM en fonction des differente activity

sql0 = "SELECT activity, ROUND(avg(\"PM2.5\"),2) AS 'MOY_PM2.5',ROUND(stdev(\"PM2.5\"),2) as 'Ecart(PM2.5)' , ROUND(avg(PM10),2) as 'MOY_PM10' ,ROUND(stdev(\"PM10\"),2) as 'Ecart(PM10)',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0',ROUND(stdev(\"PM1.0\"),2) as 'Ecart(PM1.0)',ROUND(avg(NO2),2) as 'MOY_NO2',ROUND(stdev(NO2),2) as 'Ecart(NO2)',ROUND(avg(BC),2) as 'MOY_BC',ROUND(stdev(BC),2) as 'Ecart(BC)'

		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		GROUP BY activity
		EXCEPT 

		SELECT activity, ROUND(avg(\"PM2.5\"),2) AS 'MOY_PM2.5',ROUND(stdev(\"PM2.5\"),2) as 'Ecart(PM2.5)' , ROUND(avg(PM10),2) as 'MOY_PM10' ,ROUND(stdev(\"PM10\"),2) as 'Ecart(PM10)',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0',ROUND(stdev(\"PM1.0\"),2) as 'Ecart(PM1.0)',ROUND(avg(NO2),2) as 'MOY_NO2',ROUND(stdev(NO2),2) as 'Ecart(NO2)',ROUND(avg(BC),2) as 'MOY_BC',ROUND(stdev(BC),2) as 'Ecart(BC)'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'NULL';"
		
activity<-sqldf(sql0)
		
#~ requête qui montre la moyenne des PM au Domicile en fonction des differente event
sql1 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Domicile'
		GROUP BY event
		EXCEPT 
		SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Domicile'
		AND event = 'NULL';"

Domicile<-sqldf(sql1)

#~ requête qui montre la moyenne des PM à la Rue en fonction des differente event
sql2 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Rue'
		GROUP BY event
		EXCEPT 
		SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Rue'
		AND event = 'NULL';"

Rue<-sqldf(sql2)

#~ requête qui montre la moyenne des PM au Restaurant en fonction des differente event
sql3 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Restaurant'
		GROUP BY event
		EXCEPT 
		SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Restaurant'
		AND event = 'NULL';"

Restaurant<-sqldf(sql3)

#~ requête qui montre la moyenne des PM au Bureau en fonction des differente event
sql4 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Bureau'
		GROUP BY event
		EXCEPT 
		SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Bureau'
		AND event = 'NULL';"

Bureau <-sqldf(sql4)


#~ requête qui montre la moyenne des temperature et humidity en fonction des differente activity

#~ sql5 = "SELECT activity, ROUND(AVG(Temperature),2) AS 'MOY_TEMP',ROUND(stdev(Temperature),2) as 'Ecart(Temperature)', ROUND(AVG(Humidity),2) AS 'MOY_HUM',ROUND(stdev(Humidity),2) as 'Ecart(Humidity)'
#~ 		FROM df, questionnaire
#~ 		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
#~ 		GROUP BY activity
#~ 		EXCEPT 
#~ 		SELECT activity, ROUND(AVG(Temperature),2) AS 'MOY_TEMP',ROUND(stdev(Temperature),2) as 'Ecart(Temperature)', ROUND(AVG(Humidity),2) AS 'MOY_HUM',ROUND(stdev(Humidity),2) as 'Ecart(Humidity)'
#~ 		FROM df, questionnaire
#~ 		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
#~ 		AND activity = 'NULL';"
		

#~ TempHum<-sqldf(sql5)

#~ requête qui montre la moyenne des PM en Velo en fonction des differente event
sql6 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Vélo'
		GROUP BY event
		EXCEPT 
		SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Vélo'
		AND event = 'NULL';"

Velo <-sqldf(sql6)

#~ requête qui montre la moyenne des PM en Voiture en fonction des differente event
sql7 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Voiture'
		GROUP BY event
		EXCEPT 
		SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Voiture'
		AND event = 'NULL';"

Voiture <-sqldf(sql7)

#~ requête qui montre la moyenne des PM en fonction de chaque participant
sql8 = "SELECT df.participant_virtual_id AS Participant, avg(\"PM2.5\") AS 'MOY_PM2.5',avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0',avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		GROUP BY df.participant_virtual_id
		EXCEPT 
		SELECT df.participant_virtual_id, avg(\"PM2.5\") AS 'MOY_PM2.5',avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0',avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'NULL';"
		
moy_participant<-sqldf(sql8)

#~ requête qui montre l'écart à la moyenne de chaque polluant
sql9 = "SELECT df.participant_virtual_id AS Participant, ROUND(stdev(\"PM2.5\"),2) as 'Ecart(PM2.5)' ,ROUND(stdev(\"PM10\"),2) as 'Ecart(PM10)',ROUND(stdev(\"PM1.0\"),2) as 'Ecart(PM1.0)',ROUND(stdev(NO2),2) as 'Ecart(NO2)',ROUND(stdev(BC),2) as 'Ecart(BC)'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		GROUP BY df.participant_virtual_id
		EXCEPT 
		SELECT df.participant_virtual_id, ROUND(stdev(\"PM2.5\"),2) as 'Ecart(PM2.5)' ,ROUND(stdev(\"PM10\"),2) as 'Ecart(PM10)',ROUND(stdev(\"PM1.0\"),2) as 'Ecart(PM1.0)',ROUND(stdev(NO2),2) as 'Ecart(NO2)',ROUND(stdev(BC),2) as 'Ecart(BC)'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'NULL';"
		
ecart_moy<-sqldf(sql9)

#~ requête qui montre la moyenne des PM du participant 9999932 en fonction des differente activity
sql10 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999932'
		GROUP BY activity
		EXCEPT 
		SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999932'
		AND activity = 'NULL';"

p9999932 <-sqldf(sql10)

#~ requête qui montre la moyenne des PM du participant 9999932 en fonction des differente activity
sql10 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999932'
		GROUP BY activity
		EXCEPT 
		SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999932'
		AND activity = 'NULL';"

p9999932 <-sqldf(sql10)

#~ requête qui montre la moyenne des BC des participant qui sont exposer en fonction des differente activity
sql11 = "SELECT activity, avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		GROUP BY activity
		EXCEPT 
		SELECT activity, avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'NULL';
		HAVING AVG(BC)= '0' "

BC <-sqldf(sql11)

#~ requête qui montre la moyenne des PM du participant 9999944 en fonction des differente activity
sql12 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999944'
		GROUP BY activity
		EXCEPT 
		SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999944'
		AND activity = 'NULL';"

p9999944 <-sqldf(sql12)

#~ requête qui montre la moyenne des PM du participant 9999946 en fonction des differente activity
sql13 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999946'
		GROUP BY activity
		EXCEPT 
		SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999946'
		AND activity = 'NULL';"

p9999946 <-sqldf(sql13)

sql14 ="SELECT  df.participant_virtual_id AS Participant,
        CASE 
        WHEN \"q_17.1\"='jamais'  THEN 'Non sportif' 
        ELSE 'Sportif'   
		END	as  Categorie
		FROM questionnaire,df 
		WHERE questionnaire.participant_virtual_id = df.participant_virtual_id AND \"q_17.1\" IS NOT NULL
		GROUP BY df.participant_virtual_id"
		
sportif <- sqldf(sql14)

sql16 ="SELECT  df.participant_virtual_id AS Participant,
		CASE
		WHEN  q_48_1='Oui' or q_48_2='Oui' or q_48_3='Oui' or q_48_4='Oui' or q_48_5='Oui' or q_48_6='Oui' or q_48_7='Oui' or q_48_8='Oui' or q_48_9='Oui' or q_49_1='Oui' or q_49_2='Oui' or q_49_3='Oui' or q_49_4='Oui' or q_49_5='Oui' or q_49_6='Oui' or q_49_7='Oui' or q_49_8='Oui' or q_49_9='Oui' 
		THEN 'Sensible a la pollution' 
		ELSE 'Non Sensible a la pollution'	
		END	as  Categorie
		FROM questionnaire,df 
		WHERE questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY df.participant_virtual_id ;"
		
sensible <- sqldf(sql16)

sql17 ="SELECT  df.participant_virtual_id AS Participant,
		CASE	
		WHEN  q_59_1<1995 and q_59_1>1985
		THEN 'Age entre 20 et 35'
		WHEN  q_59_1<1985 and q_59_1>1970
		THEN 'Age entre 35 et 50'
		WHEN  q_59_1<1970
		THEN 'Age plus de 50'	
		END	as  Categorie
		FROM questionnaire,df 
		WHERE questionnaire.participant_virtual_id = df.participant_virtual_id
		AND q_59_1 not null
		GROUP BY df.participant_virtual_id; "
		
age<- sqldf(sql17)

sql18 ="SELECT   df.participant_virtual_id AS Participant,
		CASE	
		WHEN  q_58='Un homme'
		THEN 'Un homme'
		WHEN  q_58='Une femme'
		THEN 'Une femme'	
		END	as  Categorie
		FROM questionnaire,df 
		WHERE questionnaire.participant_virtual_id = df.participant_virtual_id 
		AND q_58 IS NOT NULL
		GROUP BY df.participant_virtual_id; "

sexe <- sqldf(sql18)		
		
		
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
		
		

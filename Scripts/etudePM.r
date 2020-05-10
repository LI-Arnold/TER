

source("initialiser.r")

questionnaire<-read.csv("/home/user/Bureau/TER/Donnees/questionnaire_participants.csv",header=TRUE,sep=",")

#~ requête qui montre la moyenne des PM en fonction des differente activity

sql0 = "SELECT activity, ROUND(avg(\"PM2.5\"),2) AS 'MOY_PM2.5',ROUND(stdev(\"PM2.5\"),2) as 'Ecart(PM2.5)' , ROUND(avg(PM10),2) as 'MOY_PM10' ,ROUND(stdev(\"PM10\"),2) as 'Ecart(PM10)',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0',ROUND(stdev(\"PM1.0\"),2) as 'Ecart(PM1.0)',ROUND(avg(NO2),2) as 'MOY_NO2',ROUND(stdev(NO2),2) as 'Ecart(NO2)',ROUND(avg(BC),2) as 'MOY_BC',ROUND(stdev(BC),2) as 'Ecart(BC)'


		FROM df WHERE activity != 'NULL';"

		
activity<-sqldf(sql0)
		
#~ requête qui montre la moyenne des PM au Domicile en fonction des differente event
sql1 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Domicile'
		AND event != 'NULL'
		GROUP BY event;"

Domicile<-sqldf(sql1)

#~ requête qui montre la moyenne des PM à la Rue en fonction des differente event
sql2 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Rue'
		AND event != 'NULL'
		GROUP BY event;"

Rue<-sqldf(sql2)

#~ requête qui montre la moyenne des PM au Restaurant en fonction des differente event
sql3 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Restaurant'
		AND event != 'NULL'
		GROUP BY event;"

Restaurant<-sqldf(sql3)

#~ requête qui montre la moyenne des PM au Bureau en fonction des differente event
sql4 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Bureau'
		AND event != 'NULL'
		GROUP BY event;"

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
		AND event != 'NULL'
		GROUP BY event;"

Velo <-sqldf(sql6)

#~ requête qui montre la moyenne des PM en Voiture en fonction des differente event
sql7 = "SELECT activity, event , avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'Voiture'
		AND event != 'NULL'
		GROUP BY event;"

Voiture <-sqldf(sql7)

#~ requête qui montre la moyenne des PM en fonction de chaque participant
sql8 = "SELECT df.participant_virtual_id AS Participant, avg(\"PM2.5\") AS 'MOY_PM2.5',avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0',avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity != 'NULL'
		GROUP BY df.participant_virtual_id;"
		
moy_participant<-sqldf(sql8)

#~ requête qui montre l'écart à la moyenne de chaque polluant
sql9 = "SELECT df.participant_virtual_id AS Participant, ROUND(stdev(\"PM2.5\"),2) as 'Ecart(PM2.5)' ,ROUND(stdev(\"PM10\"),2) as 'Ecart(PM10)',ROUND(stdev(\"PM1.0\"),2) as 'Ecart(PM1.0)',ROUND(stdev(NO2),2) as 'Ecart(NO2)',ROUND(stdev(BC),2) as 'Ecart(BC)'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity != 'NULL'
		GROUP BY df.participant_virtual_id;"
		
ecart_moy<-sqldf(sql9)

#~ requête qui montre la moyenne des PM du participant 9999932 en fonction des differente activity
sql10 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999932'
 		AND df.activity != 'NULL'
		GROUP BY activity;"

p9999932 <-sqldf(sql10)

#~ requête qui montre la moyenne des PM du participant 9999932 en fonction des differente activity
sql10 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999932'
		AND activity != 'NULL'
		GROUP BY activity;"

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
		AND activity = 'NULL'
		GROUP BY activity
		HAVING AVG(BC)= '0' "

BC <-sqldf(sql11)

#~ requête qui montre la moyenne des PM du participant 9999944 en fonction des differente activity
sql12 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999944'
		AND activity != 'NULL'
		GROUP BY activity;"

p9999944 <-sqldf(sql12)

#~ requête qui montre la moyenne des PM du participant 9999946 en fonction des differente activity
sql13 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999946'
		AND activity != 'NULL'
		GROUP BY activity;"

p9999946 <-sqldf(sql13)

#~ requête qui montre la moyenne des PM du participant 9999964 en fonction des differente activity
sql19 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999964'
		AND activity != 'NULL'
		GROUP BY activity;"

p9999964 <-sqldf(sql19)

#~ requête qui montre la moyenne des PM du participant 9999965 en fonction des differente activity
sql20 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999965'
		AND activity != 'NULL'
		GROUP BY activity;"

p9999965 <-sqldf(sql20)

#~ requête qui montre la moyenne des PM du participant 9999966 en fonction des differente activity
sql21 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND df.participant_virtual_id = '9999966'
		AND activity != 'NULL'
		GROUP BY activity;"

p9999966 <-sqldf(sql21)

#~ requête qui affiche les participant sportif ou non 
sql14 ="SELECT  df.participant_virtual_id AS Participant,
        CASE 
        WHEN \"q_17.1\"='jamais'  THEN 'Non sportif' 
        ELSE 'Sportif'   
		END	as  Categorie
		FROM questionnaire,df 
		WHERE questionnaire.participant_virtual_id = df.participant_virtual_id AND \"q_17.1\" IS NOT NULL
		GROUP BY df.participant_virtual_id;"
		
sportif <- sqldf(sql14)

#~ requête qui affiche les participant sensible ou non 
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

#~ requête qui affiche les participant avec leurs catégorie d'age ou non 
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

#~ requête qui affiche le sexe du participant 
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
		

library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf) 

dataset <- lapply(Sys.glob("participant-data-semain43/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",")
df <- do.call(rbind, dataset)

questionnaire<-read.csv("questionnaire_participants.csv",header=TRUE,sep=",")

#~ requête qui montre la moyenne des PM en fonction des differente activity
sql0 = "SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		GROUP BY activity
		EXCEPT 
		SELECT activity, avg(\"PM2.5\") AS 'MOY_PM2.5' , avg(PM10) as 'MOY_PM10' ,avg(\"PM1.0\") as 'MOY_PM1.0', avg(NO2) as 'MOY_NO2',avg(BC) as 'MOY_BC'
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
sql5 = "SELECT activity, AVG(Temperature) AS 'MOY_TEMP', AVG(Humidity) AS 'MOY_HUM'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		GROUP BY activity
		EXCEPT 
		SELECT activity,  AVG(Temperature) AS 'MOY_TEMP', AVG(Humidity) AS 'MOY_HUM'
		FROM df, questionnaire
		WHERE df.participant_virtual_id = questionnaire.participant_virtual_id
		AND activity = 'NULL';"
		

TempHum<-sqldf(sql5)

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







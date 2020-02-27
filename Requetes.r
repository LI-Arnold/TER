library(RSQLite)
library(gsubfn)
library(proto) 
library(sqldf) 


dataset <- lapply(Sys.glob("participant-data-semain43/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",")
df <- do.call(rbind, dataset)
sql1 ="SELECT * from df;"
mesures_participants<-sqldf(sql1)

Questionnaire<-read.csv("questionnaire_participants.csv",header=TRUE,sep=",")
sql2 ="SELECT * FROM  Questionnaire;"
questionnaire<-sqldf(sql2)

sql3 ="SELECT  
        CASE 
        WHEN \"q_17.1\"='jamais'  THEN 'Non sportif' 
        WHEN \"q_17.1\" is NULL then 'Non sportif' 
        ELSE 'Sportif'   
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',avg(\"PM2.5\") as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',avg(PM10) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',avg(\"PM1.0\") as 'MOY_PM1.0', max(NO2) IS NOT NULL as 'MAX_NO2' , min(NO2) as 'MIN_NO2' , avg(NO2) as 'MOY_NO2' , max(BC) IS NOT NULL as 'MAX_BC',min(BC) as 'MIN_BC' ,avg(BC) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY Categorie;"

sql4 ="SELECT  
	    CASE  
        WHEN \"q_20.2\"='Non' THEN 'Non Fumeur' 
        ELSE 'Fumeur'  
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',avg(\"PM2.5\") as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',avg(PM10) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',avg(\"PM1.0\") as 'MOY_PM1.0' ,  max(NO2) IS NOT NULL as 'MAX_NO2',min(NO2) as 'MIN_NO2', avg(NO2) as 'MOY_NO2' , max(BC) IS NOT NULL as 'MAX_BC',min(BC) as 'MIN_BC' ,avg(BC) as 'MOY_BC' 
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id  = df.participant_virtual_id 
		GROUP BY Categorie;"


	
sql5 ="SELECT  
	    CASE 
		WHEN  q_21='Oui' THEN 'Expose a la fumee'
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',avg(\"PM2.5\") as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',avg(PM10) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',avg(\"PM1.0\") as 'MOY_PM1.0' ,  max(NO2) IS NOT NULL as 'MAX_NO2',min(NO2) as 'MIN_NO2', avg(NO2) as 'MOY_NO2' , max(BC) IS NOT NULL as 'MAX_BC',min(BC) as 'MIN_BC' ,avg(BC) as 'MOY_BC'   
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY Categorie 
		HAVING( q_21='Oui');"
	
sql6 ="SELECT
		CASE
		WHEN  q_48_1='Oui' or q_48_2='Oui' or q_48_3='Oui' or q_48_4='Oui' or q_48_5='Oui' or q_48_6='Oui' or q_48_7='Oui' or q_48_8='Oui' or q_48_9='Oui' or q_49_1='Oui' or q_49_2='Oui' or q_49_3='Oui' or q_49_4='Oui' or q_49_5='Oui' or q_49_6='Oui' or q_49_7='Oui' or q_49_8='Oui' or q_49_9='Oui' 
		THEN 'Sensible a la pollution' 
		ELSE 'Non Sensible a la pollution'	
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',avg(\"PM2.5\") as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',avg(PM10) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',avg(\"PM1.0\") as 'MOY_PM1.0' ,  max(NO2) IS NOT NULL as 'MAX_NO2',min(NO2) as 'MIN_NO2', avg(NO2) as 'MOY_NO2' , max(BC) IS NOT NULL as 'MAX_BC',min(BC) as 'MIN_BC' ,avg(BC) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY Categorie;"

resultat1<-sqldf(sql3)

resultat2<-sqldf(sql4)

resultat3<-sqldf(sql5)

resultat4<-sqldf(sql6)

resultatFinal<-rbind(resultat1,resultat3,resultat2,resultat4)


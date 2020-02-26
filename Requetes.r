library(sqldf) 
library(RSQLite)

dataset <- lapply(Sys.glob("Participant*.csv"), read.csv, header=TRUE, sep=",")
df <- do.call(rbind, dataset)
sql1 ="SELECT * from df;"
mesures_participants<-sqldf(sql1)

Questionnaire<-read.csv("questionnaire_participants.csv",header=TRUE,sep=",")
sql2 ="SELECT * FROM  Questionnaire;"
questionnaire<-sqldf(sql2)

sql3 ="SELECT  
        CASE 
          WHEN \"q_17.1\"='jamais'  THEN 'Non sportif' 
        when \"q_17.1\" is NULL then 'Non sportif' ELSE 'Sportif'  
		end 
		as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0' from Questionnaire,df 
	where Questionnaire.participant_virtual_id=df.participant_virtual_id group by Categorie;"
sql4 ="SELECT  
	CASE  
        WHEN \"q_20.2\"='Non' THEN 'Non Fumeur' ELSE 'Fumeur'  
 
	END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0' from Questionnaire,df 
	where Questionnaire.participant_virtual_id=df.participant_virtual_id group by Categorie;"

	sql5 ="SELECT  
	  CASE 
   	WHEN  q_21='Oui' THEN 'Expose'
	END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0' from Questionnaire,df 
	where Questionnaire.participant_virtual_id=df.participant_virtual_id group by Categorie having( q_21='Oui');"
	
		sql5 ="SELECT  
	  CASE 
   	WHEN  q_21='Oui' THEN 'Expose'
	END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0' from Questionnaire,df 
	where Questionnaire.participant_virtual_id=df.participant_virtual_id group by Categorie having( q_21='Oui');"
resultat1<-sqldf(sql3)

resultat2<-sqldf(sql4)

resultat3<-sqldf(sql5)

resultatFinal<-rbind(resultat1,resultat3,resultat2)

print(resultatFinal)
library(proto)
library(gsubfn)
library(RSQLite)
library(sqldf) 

dataset <- lapply(Sys.glob("participant-data-semain43/Measures/Participant*.csv"), read.csv, header=TRUE, sep=",")
df <- do.call(rbind, dataset)


Questionnaire<-read.csv("questionnaire_participants.csv",header=TRUE,sep=",")


sql3 ="SELECT  
        CASE 
        WHEN \"q_17.1\"='jamais'  THEN 'Non sportif' 
        ELSE 'Sportif'   
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND \"q_17.1\" IS NOT NULL
		GROUP BY Categorie;"

sql4 ="SELECT  
	    CASE  
        WHEN \"q_20.2\"='Non' THEN 'Non Fumeur'
		WHEN \"q_20.2\"='Oui' THEN 'Fumeur' 
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id  = df.participant_virtual_id AND \"q_20.2\" IS NOT NULL
		GROUP BY Categorie;"
	
sql5 ="SELECT  
	    CASE 
		WHEN  q_21='Oui' THEN 'Expose a la fumee'
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id
		GROUP BY Categorie HAVING(q_21 NOT NULL);"
	
sql6 ="SELECT
		CASE
		WHEN  q_48_1='Oui' or q_48_2='Oui' or q_48_3='Oui' or q_48_4='Oui' or q_48_5='Oui' or q_48_6='Oui' or q_48_7='Oui' or q_48_8='Oui' or q_48_9='Oui' or q_49_1='Oui' or q_49_2='Oui' or q_49_3='Oui' or q_49_4='Oui' or q_49_5='Oui' or q_49_6='Oui' or q_49_7='Oui' or q_49_8='Oui' or q_49_9='Oui' 
		THEN 'Sensible a la pollution' 
		ELSE 'Non Sensible a la pollution'	
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY Categorie;"
		
sql7 ="SELECT
		CASE
		WHEN  q_68_1='Oui' THEN 'Proprietaire' 
		WHEN  q_68_1='Non' THEN 'Locataire'	
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND q_68_1 IS NOT NULL
		GROUP BY Categorie;"
	
sql8 ="SELECT
		CASE
		WHEN  \"q_66.a\" like '%500%1000%' or \"q_66.a\"  like '%1000%1500%' or \"q_66.a\"  like '%1500%2000%' 
		THEN 'Revenu<2000' 
		WHEN  \"q_66.a\" like '%2000%3000%' or \"q_66.a\"  like '%3000%4000%' 
		THEN '2000<Revenu<4000' 
		WHEN  \"q_66.a\" like '%4000%5000%' or \"q_66.a\" like '%5000%6000%' or \"q_66.a\" like '%6000%7000%' or \"q_66.a\" like 'Plus de 7000%'  
		THEN 'Revenu>4000'	
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND \"q_66.a\" IS NOT NULL
		GROUP BY Categorie; "	
		
sql9 ="SELECT
		CASE
		WHEN  q_44_3_1>0 or q_44_4_1>0 or q_44_5_1>0 
		THEN 'Usager de transport en commun'  
		WHEN  q_44_3_1=0 and q_44_4_1=0 and q_44_5_1=0 
		THEN 'Non usager de transport en commun'		
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND q_44_4_1 IS NOT NULL
		GROUP BY Categorie; "
		
sql10 ="SELECT
		CASE	
		WHEN  q_44_1_1>0 or q_44_2_1>0
		THEN 'Usage doux de transport'	
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND q_44_4_1 IS NOT NULL
		GROUP BY Categorie; "

sql11 ="SELECT
		CASE	
		WHEN  q_59_1<1995 and q_59_1>1985
		THEN 'Age entre 20 et 35'
		WHEN  q_59_1<1985 and q_59_1>1970
		THEN 'Age entre 35 et 50'
		WHEN  q_59_1<1970
		THEN 'Age plus de 50'	
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id
		GROUP BY Categorie having(q_59_1 not null); "
		
sql12 ="SELECT
		CASE	
		WHEN  q_58='Un homme'
		THEN 'Un homme'
		WHEN  q_58='Une femme'
		THEN 'Une femme'	
		END	as  Categorie, min(\"PM2.5\") as 'MIN_P2.5' ,max(\"PM2.5\")  as 'MAX_PM2.5',ROUND(avg(\"PM2.5\"),2) as 'MOY_PM2.5',min(PM10) as 'MIN_PM10',max(PM10) as 'MAX_PM10',ROUND(avg(PM10),2) as 'MOY_PM10',min(\"PM1.0\") as 'MIN_PM1.0',max(\"PM1.0\") as 'MAX_PM1.0',ROUND(avg(\"PM1.0\"),2) as 'MOY_PM1.0', max(cast(NO2 AS INTEGER)) as 'MAX_NO2' , min(cast(NO2 AS INTEGER)) as 'MIN_NO2' , ROUND(avg(NO2),2) as 'MOY_NO2' , max(cast(BC AS INTEGER)) as 'MAX_BC',min(cast(BC AS INTEGER)) as 'MIN_BC' ,ROUND(avg(BC),2) as 'MOY_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND q_58 IS NOT NULL
		GROUP BY Categorie; "
		
resultat1<-sqldf(sql3)

resultat2<-sqldf(sql4)

resultat3<-sqldf(sql5)

resultat4<-sqldf(sql6)

resultat5<-sqldf(sql7)

resultat6<-sqldf(sql8)

resultat7<-sqldf(sql9)

resultat8<-sqldf(sql10)

resultat9<-sqldf(sql11)

resultat10<-sqldf(sql12)

resultatFinal<-rbind(resultat1,resultat2,resultat3,resultat4,resultat5,resultat6,resultat7,resultat8,resultat9,resultat10)


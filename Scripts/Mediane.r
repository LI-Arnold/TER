
source("~/TER/Scripts/initialiser.r")

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
		END	as  Categorie,
 		(SELECT  \"PM2.5\" FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\"  LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id) / 2 )
		as 'Mediane_PM2.5',
		(SELECT  PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT   COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY Categorie;"

sql4 ="SELECT  
	    CASE  
        WHEN \"q_20.2\"='Non' THEN 'Non Fumeur' 
        ELSE 'Fumeur'  
		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id  = df.participant_virtual_id 
		GROUP BY Categorie;"


	
sql5 ="SELECT  
	    CASE 
		WHEN  q_21='Oui' THEN 'Expose a la fumee'
		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND q_21='Oui'
		GROUP BY Categorie;"
	
sql6 ="SELECT
		CASE
		WHEN  q_48_1='Oui' or q_48_2='Oui' or q_48_3='Oui' or q_48_4='Oui' or q_48_5='Oui' or q_48_6='Oui' or q_48_7='Oui' or q_48_8='Oui' or q_48_9='Oui' or q_49_1='Oui' or q_49_2='Oui' or q_49_3='Oui' or q_49_4='Oui' or q_49_5='Oui' or q_49_6='Oui' or q_49_7='Oui' or q_49_8='Oui' or q_49_9='Oui' 
		THEN 'Sensible a la pollution' 
		ELSE 'Non Sensible a la pollution'	
		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY Categorie;"
		
sql7 ="SELECT
		CASE
		WHEN  q_68_1='Oui' 
		THEN 'Proprietaire' 
		ELSE 'Locataire'	
		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
		GROUP BY Categorie;"
	
sql8 ="SELECT
		CASE
		WHEN  \"q_66.a\" like '%500%1000%' or \"q_66.a\"  like '%1000%1500%' or \"q_66.a\"  like '%1500%2000%' 
		THEN 'Revenu<2000' 
		WHEN  \"q_66.a\" like '%2000%3000%' or \"q_66.a\"  like '%3000%4000%' 
		THEN '2000<Revenu<4000' 
		WHEN  \"q_66.a\" like '%4000%5000%' or \"q_66.a\" like '%5000%6000%' or \"q_66.a\" like '%6000%7000%' or \"q_66.a\" like 'Plus de 7000%'  
		THEN 'Revenu>4000'	
		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND \"q_66.a\" IS NOT NULL
		GROUP BY Categorie; "	
		
sql9 ="SELECT
		CASE
		WHEN  q_44_3_1>0 or q_44_4_1>0 or q_44_5_1>0 
		THEN 'Usager de transport en commun'  
		WHEN  q_44_3_1=0 and q_44_4_1=0 and q_44_5_1=0 
		THEN 'Non usager de transport en commun'	
		WHEN  q_44_1_1>0 or q_44_2_1>0
		THEN 'Usage doux de transport'	
		END	as  Categorie, 
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND q_44_4_1 IS NOT NULL
		GROUP BY Categorie; "
		
sql10 ="SELECT
		CASE	
 		WHEN  q_44_1_1>0 or q_44_2_1>0
 		THEN 'Usage doux de transport'	
 		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
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
		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
		FROM Questionnaire,df 
		WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id AND q_59_1 IS NOT NULL
		GROUP BY Categorie; "
		
sql12 ="SELECT
		CASE	
		WHEN  q_58='Un homme'
		THEN 'Un homme'
		WHEN  q_58='Une femme'
		THEN 'Une femme'	
		END	as  Categorie,
 		(SELECT \"PM2.5\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM2.5\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM2.5\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM2.5',
		(SELECT PM10  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY PM10 LIMIT 1
		OFFSET (SELECT  COUNT(PM10)  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM10',
		(SELECT \"PM1.0\"  FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ORDER BY \"PM1.0\" LIMIT 1
		OFFSET (SELECT  COUNT(\"PM1.0\")  FROM Questionnaire,df  WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id ) / 2) 
		as 'Mediane_PM1.0',
		(SELECT NO2 FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY NO2 LIMIT 1 OFFSET (SELECT COUNT(NO2) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_NO2',
 		(SELECT BC FROM Questionnaire,df WHERE Questionnaire.participant_virtual_id = df.participant_virtual_id 
 	    ORDER BY BC LIMIT 1 OFFSET (SELECT COUNT(BC) FROM Questionnaire q1,df df1  WHERE q1.participant_virtual_id=df1.participant_virtual_id ) / 2)
 		AS 'mediane_BC'
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

mediane<-rbind(resultat1,resultat3,resultat2,resultat4,resultat5,resultat6,resultat7,resultat8,resultat9,resultat10)

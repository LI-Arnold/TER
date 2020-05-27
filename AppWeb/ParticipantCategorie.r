library(tidyverse)
Questionnaire<-read.csv("~/TER/Donnees/questionnaire_participants.csv",header=TRUE,sep=",",stringsAsFactors=FALSE)

#~ requête qui affiche les participant sportif ou non 
sql14 ="SELECT  participant_virtual_id AS Participant,
        CASE 
        WHEN \"q_17.1\"='jamais'  THEN 'Non' 
        ELSE 'Oui'   
		END	as  Sportif
		FROM Questionnaire
		GROUP BY participant_virtual_id;"
		
sportif <- sqldf(sql14)

#~ requête qui affiche les participant sensible ou non 
sql16 ="SELECT  participant_virtual_id AS Participant,
		CASE
		WHEN  q_48_1='Oui' or q_48_2='Oui' or q_48_3='Oui' or q_48_4='Oui' or q_48_5='Oui' or q_48_6='Oui' or q_48_7='Oui' or q_48_8='Oui' or q_48_9='Oui' or q_49_1='Oui' or q_49_2='Oui' or q_49_3='Oui' or q_49_4='Oui' or q_49_5='Oui' or q_49_6='Oui' or q_49_7='Oui' or q_49_8='Oui' or q_49_9='Oui' 
		THEN 'Oui' 
		ELSE 'Non'	
		END	as  'Sensible a la pollution'
		FROM Questionnaire
		GROUP BY participant_virtual_id ;"
		
sensible <- sqldf(sql16)

#~ requête qui affiche les participant avec leurs catégorie d'age
sql17 ="SELECT  participant_virtual_id AS Participant,
		CASE	
		WHEN  q_59_1<1995 and q_59_1>1985
		THEN 'Age entre 20 et 35'
		WHEN  q_59_1<1985 and q_59_1>1970
		THEN 'Age entre 35 et 50'
		WHEN  q_59_1<1970
		THEN 'Age plus de 50'	
		END	as  Age
		FROM Questionnaire
		GROUP BY participant_virtual_id; "
		
age<- sqldf(sql17)

#~ requête qui affiche le sexe du participant 
sql18 ="SELECT  participant_virtual_id AS Participant,
		CASE	
		WHEN  q_58='Un homme'
		THEN 'Un homme'
		WHEN  q_58='Une femme'
		THEN 'Une femme'	
		END	as  Sexe
		FROM Questionnaire
		GROUP BY participant_virtual_id; "

sexe <- sqldf(sql18)		
		
#~ Requête pour afficher les fumeurs et non fumeurs
sql19 ="SELECT  participant_virtual_id AS Participant,
	    CASE  
        WHEN \"q_20.2\"='Non' THEN 'Non'
		WHEN \"q_20.2\"='Oui' THEN 'OUI' 
		END	as  Fumeur
		FROM Questionnaire
		GROUP BY participant_virtual_id;"
fumee <-sqldf(sql19)
				
#~ Requête pour afficher les exposees à la fumée
sql20 ="SELECT  participant_virtual_id AS Participant,
	    CASE 
		WHEN  q_21='Oui' THEN 'Oui'
		END	as  Expose_a_fumee
		FROM Questionnaire
		GROUP BY participant_virtual_id;"
exposeFumee <-sqldf(sql20)

#~ Requête pour afficher les locataires et les propriétaires
sql21 ="SELECT  participant_virtual_id AS Participant,
	    CASE
		WHEN  q_68_1='Oui' THEN 'Proprietaire' 
		WHEN  q_68_1='Non' THEN 'Locataire'
		END	as  Logement
		FROM Questionnaire
		GROUP BY participant_virtual_id;"
locaProp<-sqldf(sql21)

#~ Requête pour afficher les participants selon leurs revenus
sql22 ="SELECT  participant_virtual_id AS Participant,
	    CASE
		WHEN  \"q_66.a\" like '%500%1000%' or \"q_66.a\"  like '%1000%1500%' or \"q_66.a\"  like '%1500%2000%' 
		THEN 'Revenu<2000' 
		WHEN  \"q_66.a\" like '%2000%3000%' or \"q_66.a\"  like '%3000%4000%' 
		THEN '2000<Revenu<4000' 
		WHEN  \"q_66.a\" like '%4000%5000%' or \"q_66.a\" like '%5000%6000%' or \"q_66.a\" like '%6000%7000%' or \"q_66.a\" like 'Plus de 7000%'  
		THEN 'Revenu>4000'	
		END	as  Revenu
		FROM Questionnaire
		GROUP BY participant_virtual_id;"
revenu <-sqldf(sql22)

#~ Requête pour afficher les participants selon l'usage du transport en commun
sql23 ="SELECT  participant_virtual_id AS Participant,
		CASE
		WHEN  q_44_3_1>0 or q_44_4_1>0 or q_44_5_1>0 
		THEN 'Oui'  
		WHEN  q_44_3_1=0 and q_44_4_1=0 and q_44_5_1=0 
		THEN 'Non'
		END	as  'usager transport en commun'
		FROM Questionnaire
		GROUP BY participant_virtual_id;"
TransportCom <-sqldf(sql23)


#~ Requête pour afficher les participants selon l'usage doux du transport 
sql24 ="SELECT  participant_virtual_id AS Participant,
		CASE	
		WHEN  q_44_1_1>0 or q_44_2_1>0
		THEN 'Oui'	
		END	as  'Usage doux transport'
		FROM Questionnaire
		GROUP BY participant_virtual_id; "
usageDoux <-sqldf(sql24)


	
sensible<-as.data.frame(sensible)
sportif <-as.data.frame(sportif)
usageDoux<-as.data.frame(usageDoux)
TransportCom<-as.data.frame(TransportCom)
revenu<-as.data.frame(revenu)
locaProp<-as.data.frame(locaProp)
exposeFumee<-as.data.frame(exposeFumee)
fumee<-as.data.frame(fumee)
sexe<-as.data.frame(sexe)
age<-as.data.frame(age)


CategorieParticipant <- inner_join(sensible,sportif,by="Participant")  
CategorieParticipant <- inner_join(CategorieParticipant,usageDoux,by="Participant") 
CategorieParticipant <- inner_join(CategorieParticipant,TransportCom,by="Participant") 
CategorieParticipant <- inner_join(CategorieParticipant, revenu,by="Participant") 
CategorieParticipant <- inner_join(CategorieParticipant,locaProp,by="Participant") 
CategorieParticipant <- inner_join(CategorieParticipant,exposeFumee ,by="Participant") 
CategorieParticipant <- inner_join(CategorieParticipant,fumee,by="Participant") 
CategorieParticipant <- inner_join(CategorieParticipant,sexe,by="Participant") 
CategorieParticipant <- inner_join(CategorieParticipant,age,by="Participant") 


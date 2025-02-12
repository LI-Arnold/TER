
### Charger Table des mesures
source("~/TER/Scripts/initialiserSansAnomalies.r")
Questionnaire<-read.csv("~/TER/Donnees/questionnaire_participants.csv",header=TRUE,sep=",",stringsAsFactors=FALSE)

######################################  Partie 1 : Les diagrammes de Polluant par rapport activité ############################################


### Librairie pour créer les plots
library(ggplot2)

#~ convertir en numeric les valeurs de NO2 et BC

dfSansAnomalies$NO2 <- as.numeric(dfSansAnomalies$NO2)
dfSansAnomalies$BC <- as.numeric(dfSansAnomalies$BC)	

### Requete pour calculer la moyenne des polluants pour chaque activité

ReqMoyPolluantActivite <- "select activity,ROUND(AVG(\"PM2.5\"),2) as 'Moyenne_PM2.5',ROUND(avg(PM10),2) as 'Moyenne_PM10',ROUND(AVG(\"PM1.0\"),2) as 'Moyenne_PM1.0'
,ROUND(AVG(NO2),2) as 'Moyenne_NO2',ROUND(AVG(BC),2) as 'Moyenne_BC'
from Questionnaire,dfSansAnomalies WHERE Questionnaire.participant_virtual_id = dfSansAnomalies.participant_virtual_id group by activity;"

MoyPolluantActivite <- sqldf(ReqMoyPolluantActivite)

# Régler les lettres accentuées pour l'affichage de plot
MoyPolluantActivite[3,"activity"]<-"Cinéma"
MoyPolluantActivite[7,"activity"]<-"Métro"
MoyPolluantActivite[15,"activity"]<-"Vélo"

### Vecteur de couleurs pour bien identifier les poucentages sur le pie chart
 colors <- c("#55DDE0", "#33658A", "#2F4858", "#F6AE2D", "#F26419", "#999999", "green", "violet", "orange", "pink", "cyan","#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF","grey")

	
### Pourcentage de PM10 pour chaque activité :
 piePM10Activity<- ggplot(MoyPolluantActivite, aes(x="", y=Moyenne_PM10, fill=activity))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_PM10/ sum(Moyenne_PM10))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Activité", x = NULL, y = NULL,  title = "Mesures de PM10 par activité en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)
	
 ### Pourcentage de PM2.5 pour chaque activité :
 piePM2.5Activity<- ggplot(MoyPolluantActivite, aes(x="", y=Moyenne_PM2.5, fill=activity))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_PM2.5/ sum(Moyenne_PM2.5))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Activité", x = NULL, y = NULL,  title = "Mesures de PM2.5 par activité en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)
	
	 ### Pourcentage de PM1.0 pour chaque activité :
 piePM1.0Activity<- ggplot(MoyPolluantActivite, aes(x="", y=Moyenne_PM1.0, fill=activity))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_PM1.0/ sum(Moyenne_PM1.0))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Activité", x = NULL, y = NULL,  title = "Mesures de PM1.0 par activité en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)
	
	 ### Pourcentage de NO2 pour chaque activité :
 pieNO2Activity<- ggplot(MoyPolluantActivite, aes(x="", y=Moyenne_NO2, fill=activity))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_NO2/ sum(Moyenne_NO2))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Activité", x = NULL, y = NULL,  title = "Mesures de NO2 par activité en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)
	
	 ### Pourcentage de BC pour chaque activité :
 pieBCActivity<- ggplot(MoyPolluantActivite, aes(x="", y=Moyenne_BC, fill=activity))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_BC/ sum(Moyenne_BC))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Activité", x = NULL, y = NULL,  title = "Mesures de BC par activité en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)
	

######################################  Partie 2 : Les diagramme de Polluants par rapport événement ############################################


### Requete pour calculer la moyenne des polluants pour chaque événement

ReqMoyPolluantEvent <- "select event,ROUND(AVG(\"PM2.5\"),2) as 'Moyenne_PM2.5',ROUND(avg(PM10),2) as 'Moyenne_PM10',ROUND(AVG(\"PM1.0\"),2) as 'Moyenne_PM1.0'
,ROUND(AVG(NO2),2) as 'Moyenne_NO2',ROUND(AVG(BC),2) as 'Moyenne_BC'
from dfSansAnomalies group by event;"

MoyPolluantEvent <- sqldf(ReqMoyPolluantEvent)

# Régler les lettres accentuées pour l'affichage de plot
MoyPolluantEvent[1,"event"]<-"Allumage De Cheminée"
MoyPolluantEvent[2,"event"]<-"Arrêter De Cuisiner"
MoyPolluantEvent[4,"event"]<-"Fermeture De Fenêtre"
MoyPolluantEvent[8,"event"]<-"Ouverture De Fenêtre"

### Pourcentage de PM10 pour chaque événement :
 piePM10Event<- ggplot(MoyPolluantEvent, aes(x="", y=Moyenne_PM10, fill=event))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_PM10/ sum(Moyenne_PM10))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Evénement", x = NULL, y = NULL,  title = "Mesures de PM10 par event en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)

 ### Pourcentage de PM2.5 pour chaque événement :
 piePM2.5Event<- ggplot(MoyPolluantEvent, aes(x="", y=Moyenne_PM2.5, fill=event))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_PM2.5/ sum(Moyenne_PM2.5))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Evénement", x = NULL, y = NULL,  title = "Mesures de PM2.5 par event en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)

 ### Pourcentage de PM1.0 pour chaque événement :
 piePM1.0Event<- ggplot(MoyPolluantEvent, aes(x="", y=Moyenne_PM1.0, fill=event))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_PM1.0/ sum(Moyenne_PM1.0))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Evénement", x = NULL, y = NULL,  title = "Mesures de PM1.0 par event en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)

 ### Pourcentage de BC pour chaque événement :
 pieBCEvent<- ggplot(MoyPolluantEvent, aes(x="", y=Moyenne_BC, fill=event))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_BC/ sum(Moyenne_BC))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Evénement", x = NULL, y = NULL,  title = "Mesures de BC par event en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)

 ### Pourcentage de NO2 pour chaque événement :
 pieNO2Event<- ggplot(MoyPolluantEvent, aes(x="", y=Moyenne_NO2, fill=event))+
     geom_bar(width=1, stat = "identity")+geom_text(aes(label =  round(100 * Moyenne_NO2/ sum(Moyenne_NO2))) , position = position_stack(vjust = 0.5)) +
     labs(fill = "Evénement", x = NULL, y = NULL,  title = "Mesures de NO2 par event en % ") +  coord_polar("y", start=0)+
	scale_fill_manual(values = colors)

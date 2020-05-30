
source("~/TER/Scripts/initialiserSansAnomalies.r")

### Charger les données du questionnaire
Questionnaire<-read.csv("~/TER/Donnees/questionnaire_participants.csv",header=TRUE,sep=",",stringsAsFactors=FALSE)


### table des mesures pour chaque participant au questionnaire
 reqDf<-" SELECT *
  		FROM Questionnaire,dfSansAnomalies 
  		WHERE Questionnaire.participant_virtual_id = dfSansAnomalies.participant_virtual_id";
dfVariance<-sqldf(reqDf)

### Convertir en factor les variables qualitatives
dfVariance$activity <- as.factor(dfVariance$activity)
dfVariance$event <- as.factor(dfVariance$event)

### Appliquer modele Anova à deux facteurs (event et activity) pour PM2.5
modelePM2.5<- aov( PM2.5 ~ activity + event ,data=dfVariance)

### Affichage les resultats de l'anova
summary(modelePM2.5)

### Appliquer modele Anova à deux facteurs (event et activity) pour PM1.0
modelePM1.0<- aov( PM1.0 ~ activity + event ,data=dfVariance)
summary(modelePM1.0)

### Appliquer modele Anova à deux facteurs (event et activity) pour PM10
modelePM10<- aov( PM10 ~ activity + event ,data=dfVariance)
summary(modelePM10)

### Appliquer modele Anova à deux facteurs (event et activity) pour NO2
modeleNO2<- aov( NO2 ~ activity + event ,data=dfVariance)
summary(modeleNO2)

### Appliquer modele Anova à deux facteurs (event et activity) pour BC
modeleBC<- aov( BC ~ activity + event ,data=dfVariance)
summary(modeleBC)
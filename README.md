# TER
-------------
Analyse des données du questionnaire et des mesures des polluants  

Les packages R utilisés dans les scripts du projet :
RSQLite, gsubfn, proto, sqldf, ggplot2, tidyverse, dplyr, corrplot, knitr, plotly, plyr, shiny, shinydashboard, DT, shinyWidgets  
Pour installer un package R: install.packages("nom du package")  

## L'exécution :   

Pour exécuter le script R  

source("~/TER/Scripts/Nom de script.r", encoding="utf-8") 

setwd("chemin jusqu'au dossier TER/Scripts") : pour changer le dossier de travail de R  

## L'affichage :  

+ Première méthode :   
Chargement des variables d'environnement avec la commande :  
load("~/TER/Nom de workspace.RData")  
Ensuite choisissez la variable à afficher sur l'onglet Global Environment de RStudio   

+ Deuxième méthode :  
Après l'exécution des scripts, en tapant sur la ligne de commandes :  
View(PolluantParCategorie) les différentes requetes selon chaque catégorie  
View(df) table contenant toutes les mesures de tous les participants  
View(questionnaire) table du questionnaire  

## Lancer la mini-application :  

pour lancer l'application web faut d'abord charger le jeu de données sous RStudio, ca sera plus simple qu'exécuter plusieurs scripts:   
load('\~/TER/AppWeb/appShiny.RData')  
ensuite entrez la commande :   runApp('\~/TER/AppWeb')  

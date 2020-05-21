# TER
-------------
Analyse des données du questionnaire et des mesures des polluants  
## L'exécution :  

Analyse des données du questionnaire et des mesures des polluants  
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
Après l'exécution des scripts en tapant sur la ligne de commandes :  
View(resultatFinal) les différentes requetes selon chaque catégorie  
View(df) table contenant toutes les mesures de tous les participants  
View(questionnaire) table du questionnaire  



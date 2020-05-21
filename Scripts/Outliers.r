library(ggplot2)
library(dplyr)
source("~/TER/Scripts/initialiserSansAnomalies.r")

################################################### Détection Outliers des polluants  avec les plots ####################################################
	
BoxplotBC <- ggplot(dfSansAnomalies, aes( x=activity,y=BC, fill=activity, colour=activity)) +
    geom_boxplot(alpha=0.5)+  
    ylab(label = " BC") +
    theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))+
    theme(legend.position="none")+
    theme_classic()+
    ggtitle("Boxplot avec les observations de BC")
	
BoxplotNO2 <- ggplot(dfSansAnomalies, aes( x=activity,y=NO2, fill=activity, colour=activity)) +
    geom_jitter(width=0.25)+
    geom_boxplot(alpha=0.5, outlier.shape=NA)+  
    ylab(label = "NO2") +
    theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))+
    theme(legend.position="none")+
    theme_classic()+
    ggtitle("Boxplot avec les observations de NO2")
	
BoxplotPM1.0 <- ggplot(dfSansAnomalies, aes( x=activity,y=PM1.0, fill=activity, colour=activity)) +
    geom_jitter(width=0.25)+
    geom_boxplot(alpha=0.5, outlier.shape=NA)+  
    ylab(label = "PM1.0") +
    theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))+
    theme(legend.position="none")+
    theme_classic()+
    ggtitle("Boxplot avec les observations de PM1.0")
	
Boxplot10 <- ggplot(dfSansAnomalies, aes( x=activity,y=PM10, fill=activity, colour=activity)) +
    geom_jitter(width=0.25)+
    geom_boxplot(alpha=0.5, outlier.shape=NA)+  
    ylab(label = "PM10") +
    theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))+
    theme(legend.position="none")+
    theme_classic()+
    ggtitle("Boxplot avec les observations de PM10")
	
Boxplot2.5 <- ggplot(dfSansAnomalies, aes( x=activity,y=PM2.5, fill=activity, colour=activity)) +
    geom_boxplot(alpha=0.5)+  
    ylab(label = "PM2.5") +
    theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))+
    theme(legend.position="none")+
    theme_classic()+
    ggtitle("Boxplot avec les observations de PM2.5")
	
BoxplotHumidite <- ggplot(dfSansAnomalies, aes( x=activity,y=Humidite, fill=activity, colour=activity)) +
    geom_boxplot(alpha=0.5)+  
    ylab(label = "Humidité") +
    theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))+
    theme(legend.position="none")+
    theme_classic()+
    ggtitle("Boxplot avec les observations d'humidité")

BoxplotTemperature<- ggplot(dfSansAnomalies, aes( x=activity,y=Temperature, fill=activity, colour=activity)) +
    geom_jitter(width=0.25)+
    geom_boxplot(alpha=0.5, outlier.shape=NA)+  
    ylab(label = "Température") +
    theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))+
    theme(legend.position="none")+
    theme_classic()+
    ggtitle("Boxplot avec les observations de température")	
	

########################################################## Traitement Outliers BC ##########################################################

--------------------1ier traitement de Outliers de BC pour l'activité NULL :---------------------------

## table mesure de BC pour l'activité null
dfBCActiviteNull <- dfSansAnomalies %>% filter(activity=="NULL")

## Récupération des valeurs des outliers
outlier_BC_valeurs <- boxplot.stats(dfBCActiviteNull$BC)$out

##  Récupérer les indices des outliers
outlier_BC_idx <-which(dfSansAnomalies$BC %in% c(outlier_BC_valeurs))

## dataframe qui contient les lignes des valeurs abberantes
dfBC_Outlier <- dfSansAnomalies[outlier_BC_idx ,]

 ## fonction qui teste si la valeur > mediane est outliers ou non avec  IQR = écart interquartile : thirdQt(75%) - firstQt(25%) 

   is_outlier_sup <- function(x) {
     return( x > quantile(x, 0.75,na.rm = TRUE) + 1.5 * IQR(x,na.rm = TRUE))
 }
  ## Calculer le troisème quartile
 thirdQt <- quantile(dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"] , 0.75,na.rm = TRUE)
 
 ## remplacer les valeurs "abberantes" > mediane par le troisième quartile
dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"] <- ifelse(is_outlier_sup(dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"]), thirdQt ,dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"])
 
 ## test par un plot
  boxplot(dfSansAnomalies$BC,horizontal = TRUE)
 
 ## fonction qui teste si la valeur < mediane est outliers ou non
 is_outlier_inf <- function(x) {
     return(x < quantile(x, 0.25,na.rm = TRUE) - 1.5 * IQR(x,na.rm = TRUE) )
 }

 ## Calculer le premier quartile
 firstQt <- quantile(dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"] , 0.25,na.rm = TRUE)
 
 ## remplacer les valeurs "abberantes" < mediane par le premier quartile
dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"] <- ifelse(is_outlier_inf(dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"]), firstQt ,dfSansAnomalies[dfSansAnomalies$activity == "NULL" , "BC"])

 boxplot( dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"],horizontal = TRUE)
 
 --------------------2ème traitement de Outliers de BC pour l'activité Voiture:-------------------------
 
 thirdQt <- quantile(dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"] , 0.75,na.rm = TRUE)
 
 firstQt <- quantile(dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"] , 0.25,na.rm = TRUE)
 
 dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"] <- ifelse(is_outlier_sup(dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"]), thirdQt ,dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"])
 
 dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"] <- ifelse(is_outlier_inf(dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"]), firstQt ,dfSansAnomalies[dfSansAnomalies$activity == "Voiture" , "BC"])

  --------------------3ème traitement de Outliers de BC globalement -------------------------------
  

outlier_BC_valeurs <- boxplot.stats(dfSansAnomalies$BC)$out

outlier_BC_idx <-which(dfSansAnomalies$BC %in% c(outlier_BC_valeurs))

dfBC_Outlier <- dfSansAnomalies[outlier_BC_idx ,]

 thirdQt <- quantile(dfSansAnomalies$BC, 0.75,na.rm = TRUE)
  
 firstQt <- quantile(dfSansAnomalies$BC , 0.25,na.rm = TRUE)
  
 dfSansAnomalies$BC  <- ifelse(is_outlier_sup(dfSansAnomalies$BC ), thirdQt ,dfSansAnomalies$BC)
 
dfSansAnomalies$BC  <- ifelse(is_outlier_inf(dfSansAnomalies$BC ), firstQt ,dfSansAnomalies$BC )

 ########################################################## Traitement Outliers Températutre ##########################################################

##  Récupérer les indices des outliers
outlier_Temperature_idx <-which(dfSansAnomalies$Temperature  > 50 |  dfSansAnomalies$Temperature  < -50 )

## dataframe qui contient les lignes des valeurs abberantes
df_Temp_Outlier <- dfSansAnomalies[outlier_Temperature_idx ,]

 is_Outlier_Temp <- function(x){
	return (x > 50 | x  < -50)
}

## Remplacement par le median
 dfSansAnomalies$Temperature <- ifelse(is_Outlier_Temp(dfSansAnomalies$Temperature) , median(dfSansAnomalies$Temperature,na.rm = TRUE)  ,dfSansAnomalies$Temperature)

 ########################################################## Traitement Outliers Humidité ##########################################################
 
 ##  Récupérer les indices des outliers
outlier_Humidite_idx <-which(dfSansAnomalies$Temperature  > 100 |  dfSansAnomalies$Temperature  < 0 )

## dataframe qui contient les lignes des valeurs abberantes
df_Humidite_Outlier <- dfSansAnomalies[outlier_Humidite_idx ,]

is_Outlier_Hum <- function(x){
	return(x > 100 | x  < 0)
}

## Remplacement par le median
 dfSansAnomalies$Humidite <- ifelse(is_Outlier_Hum(dfSansAnomalies$Humidite),median(dfSansAnomalies$Humidite,na.rm = TRUE),dfSansAnomalies$Humidite)

 
 
 
 
 
 
 
 
 


f <- read.csv2("questionnaire_participants.csv",header = TRUE,sep=",")

a<-min(f$participant_virtual_id,na.rm = FALSE)
print(a)


a<-max(f$participant_virtual_id,na.rm = FALSE)
print(a)

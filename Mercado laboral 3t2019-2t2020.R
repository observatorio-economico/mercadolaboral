##Mercado laboral hasta el segundo trimestre 2020
setwd("~/GitHub/mercadolaboral")
wd()
library(eph)
library(tidyverse)

#Segundo trimestre 2020
ephi<- get_microdata(year=2020, trimester = 2, type = "individual")
ephh<- get_microdata(year=2020, trimester = 2, type = "hogar")

eph2t<- left_join(ephi, ephh)

#Primer trimestre 2020 
ephi<- get_microdata(year=2020, trimester = 1, type = "individual")
ephh<- get_microdata(year=2020, trimester = 1, type = "hogar")

eph1t<- left_join(ephi, ephh)

#Cuarto 2019

ephi<- get_microdata(year=2019, trimester = 4, type = "individual")
ephh<- get_microdata(year=2019, trimester = 4, type = "hogar")

eph4t2019<- left_join(ephi, ephh)

#Tercero 2019
ephi<- get_microdata(year=2019, trimester = 3, type = "individual")
ephh<- get_microdata(year=2019, trimester = 3, type = "hogar")

eph3t2019<- left_join(ephi, ephh)


ephtotal <- bind_rows(eph2t, eph1t, eph4t2019, eph3t2019)

#Quitar duplicados:
ephtotalsd <- ephtotal %>% distinct(., CODUSU, NRO_HOGAR, COMPONENTE, .keep_all = T) 

#Empezamos: 
#Tasa de participacion laboral:

#Generamos la PEA
ephtotalsd <- ephtotalsd %>%  mutate(PEA= case_when(ESTADO==3 ~ 0,
                                                    ESTADO==4 ~ 0,
                                                    ESTADO==1 ~ 1,
                                                    ESTADO==2 ~ 1),
                                     OCUPADOS= case_when(ESTADO==1 ~ 1,
                                                         ESTADO==2 ~ 0,
                                                         ESTADO==3 ~ 0,
                                                         ESTADO==4 ~ 0),
                                     DESOCUPADOS= case_when(PEA==1 ~ 0,
                                                            ESTADO==2 ~ 1))
                                


#Para comprobar: 
table (ephtotalsd$ESTADO, ephtotalsd$PEA)

######Tasa de participacion laboral de la poblacion total #####
#Primero se filtra la base
tablapeapt <- ephtotalsd %>% filter (AGLOMERADO==12 & ESTADO!=0)
#Ahora armamos la tabla (cantidad de 1 sobre cantidad de 0 y 1) y se agrupa entre 0 y 1 (PEA==1), ademas se agrega la cantidad de habitantes dentro de la PEA.
tablapeapt <- tablapeapt %>% group_by(PEA) %>%  summarise((sum(PONDERA)/sum(tablapeapt$PONDERA)), sum(PONDERA))
tablapeapt

######Tasa de participacion laboral por sexo######
#Primero, se filtra la base:
tablapeasexo<- ephtotalsd %>% filter (AGLOMERADO==12 & ESTADO!=0 & PEA==1)
tablapeasexo <- tablapeasexo %>% group_by(PEA, CH04) %>%  summarise(sum(PONDERA), sum(PONDERA)/sum(tablapeasexo$PONDERA %*% tablapeasexo$PEA))
tablapeasexo 

#Proporcion de mujeres que conforman la PEA sobre el total de mujeres:
tablapeamujeres <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & CH04==2)
tablapeamujeres <- tablapeamujeres %>% group_by(PEA) %>%  summarise(sum(PONDERA)/sum(tablapeamujeres$PONDERA))
tablapeamujeres

#Proporcion de hombres que conforman la PEA sobre el total de hombres:
tablapeahombres <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & CH04==1)
tablapeahombres <- tablapeahombres %>% group_by(PEA) %>% summarise(sum(PONDERA)/sum(tablapeahombres$PONDERA))
tablapeahombres

####Tasa de participacion laboral por edad y sexo #####
#15-24 años

edad15a24 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=24 & CH06>=15)

#Hombres
hombres <- edad15a24 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad15a24 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#25-34 años
edad25a34 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=34 & CH06>=25)

#Hombres
hombres <- edad25a34 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad25a34 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#35-44
edad35a44 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=44 & CH06>=35)

#Hombres
hombres <- edad35a44 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad35a44 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#45-59
edad45a59 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=59 & CH06>=45)

#Hombres
hombres <- edad45a59 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad45a59 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#Mayores o iguales a 60 años
edad60 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06>=60)

#Hombres
hombres <- edad60 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad60 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

####Tasa de participacion laboral por sexo y nivel educativo####

#Primaria incompleta

primariaincompleta <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED==1)
#Hombres:
hombres <- primariaincompleta %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres:
mujeres <- primariaincompleta %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#Primaria completa
primariacompleta <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED==2)
#Hombres:
hombres <- primariacompleta %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres:
mujeres <- primariacompleta %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#Secundaria incompleta
secundariaincompleta <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED==3)
#Hombres:
hombres <- secundariaincompleta %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres:
mujeres <- secundariaincompleta %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#Secundaria completa
secundariacompleta <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED==4)
#Hombres:
hombres <- secundariacompleta %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres:
mujeres <- secundariacompleta %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#Superior incompleto
superiorincompleto <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED==5)
#Hombres:
hombres <- superiorincompleto %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres:
mujeres <- superiorincompleto %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

#Superior completo
superiorcompleto <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED==6)
#Hombres:
hombres <- superiorcompleto %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres:
mujeres <- superiorcompleto %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

####Tasa de participacion laboral por sexo y  quintil de ingreso####

install.packages("Hmisc")
library(Hmisc)

ephcorr <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0)
deflactor <- read.csv("deflactor.csv", header=T, sep=";", dec=".")
deflactor <- read.csv("C:/Users/Bianca/Documents/GitHub/mercadolaboral/deflactor.csv", header=T, sep=";", dec=".")

ephcorr <- left_join(ephcorr, deflactor)
ephcorr <- ephcorr %>%  mutate(IPCFR = IPCF/DEFLACTOR)
ephcorr <- ephcorr %>%  mutate(cuantilp=as.numeric(cut(IPCFR, wtd.quantile(IPCFR, weights = PONDIH, probs = seq(0,1,length=6), na.rm = T), include.lowest = F)))
table(ephcorr$cuantilp)

#Quintil 1
quintil1 <- ephcorr %>% filter(cuantilp==1)
#Hombres
hombres <- quintil1 %>%  filter (CH04==1)
hombres <- hombres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(hombres$PONDIH))
hombres

#Mujeres
mujeres <- quintil1 %>%  filter (CH04==2)
mujeres <- mujeres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(mujeres$PONDIH))
mujeres

#Quintil 2
quintil2 <- ephcorr %>% filter(cuantilp==2)
#Hombres
hombres <- quintil2 %>%  filter (CH04==1)
hombres <- hombres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(hombres$PONDIH))
hombres

#Mujeres
mujeres <- quintil2 %>%  filter (CH04==2)
mujeres <- mujeres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(mujeres$PONDIH))
mujeres

table(ephcorr$cuantilp)
dim(ephcorr)

#Quintil 3
quintil3 <- ephcorr %>% filter(cuantilp==3)
#Hombres
hombres <- quintil3 %>%  filter (CH04==1)
hombres <- hombres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(hombres$PONDIH))
hombres

#Mujeres
mujeres <- quintil3 %>%  filter (CH04==2)
mujeres <- mujeres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(mujeres$PONDIH))
mujeres

#Quintil 4
quintil4 <- ephcorr %>% filter(cuantilp==4)
#Hombres
hombres <- quintil4 %>%  filter (CH04==1)
hombres <- hombres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(hombres$PONDIH))
hombres

#Mujeres
mujeres <- quintil4 %>%  filter (CH04==2)
mujeres <- mujeres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(mujeres$PONDIH))
mujeres

#Quintil 5
quintil5 <- ephcorr %>% filter(cuantilp==5)
#Hombres
hombres <- quintil5 %>%  filter (CH04==1)
hombres <- hombres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(hombres$PONDIH))
hombres

#Mujeres
mujeres <- quintil5 %>%  filter (CH04==2)
mujeres <- mujeres %>% group_by(PEA) %>% summarise(sum(PONDIH)/sum(mujeres$PONDIH))
mujeres


####Cantidad de horas trabajadas####
horastrabtotales <- ephtotalsd %>% mutate(horastrabtotales= PP3E_TOT + PP3F_TOT)
#15-24 años
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & CH06<=24 & CH06>=15 & !is.na(horastrabtotales))
horastrab <- horastrab %>%  group_by(CH04) %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
horastrab

#25-34
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & CH06<=34 & CH06>=25 & !is.na(horastrabtotales))
horastrab <- horastrab %>%  group_by(CH04) %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
horastrab

#35 a 44
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & CH06<=44 & CH06>=35 & !is.na(horastrabtotales))
horastrab <- horastrab %>%  group_by(CH04) %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
horastrab

#45 a 59
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & CH06<=59 & CH06>=45 & !is.na(horastrabtotales))
horastrab <- horastrab %>%  group_by(CH04) %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
horastrab

#mayores de 60
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & CH06>=60 & !is.na(horastrabtotales))
horastrab <- horastrab %>%  group_by(CH04) %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
horastrab

#Total mujeres y hombres
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & !is.na(horastrabtotales))
horastrab <- horastrab %>%  group_by(CH04) %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
horastrab

#Total de la poblacion
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & !is.na(horastrabtotales))
horastrab <- horastrab %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
horastrab




##Mercado laboral hasta el segundo trimestre 2020

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
                                                    ESTADO==2 ~ 1)
                                     )

#Para comprobar: 
table (ephtotalsd$ESTADO, ephtotalsd$PEA)

######Tasa de participacion laboral de la poblacion total: #####
#Primero se filtra la base
tablapeapt <- ephtotalsd %>% filter (AGLOMERADO==12 & ESTADO!=0)
#Ahora armamos la tabla (cantidad de 1 sobre cantidad de 0 y 1) y se agrupa entre 0 y 1 (PEA==1), ademas se agrega la cantidad de habitantes dentro de la PEA.
tablapeapt <- tablapeapt %>% group_by(PEA) %>%  summarise((sum(PONDERA)/sum(tablapeapt$PONDERA)), sum(PONDERA))
tablapeapt

######Tasa de participacion laboral por sexo:######
#Primero, se filtra la base:
tablapeasexo<- ephtotalsd %>% filter (AGLOMERADO==12 & ESTADO!=0 & PEA==1)
tablapeasexo <- tablapeasexo %>% group_by(PEA, CH04) %>%  summarise(sum(PONDERA), sum(PONDERA)/sum(tablapeasexo$PONDERA %*% tablapeasexo$PEA))
tablapeasexo 

######Proporcion de mujeres que conforman la PEA sobre el total de mujeres:#####
tablapeamujeres <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & CH04==2)
tablapeamujeres <- tablapeamujeres %>% group_by(PEA) %>%  summarise(sum(PONDERA)/sum(tablapeamujeres$PONDERA))
tablapeamujeres

######Proporcion de hombres que conforman la PEA sobre el total de hombres:#####
tablapeahombres <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & CH04==1)
tablapeahombres <- tablapeahombres %>% group_by(PEA) %>% summarise(sum(PONDERA)/sum(tablapeahombres$PONDERA))
tablapeahombres

######Tasa de participacion laboral por edad y sexo: #####
######15-24 años#####

edad15a24 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=24 & CH06>=15)

#Hombres
hombres <- edad15a24 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad15a24 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

######25-34 años######
edad25a34 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=34 & CH06>=25)

#Hombres
hombres <- edad25a34 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad25a34 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

####35-44####
edad35a44 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=44 & CH06>=35)

#Hombres
hombres <- edad35a44 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad35a44 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

####45-59####
edad45a59 <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0 & CH06<=59 & CH06>=45)

#Hombres
hombres <- edad45a59 %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres
mujeres <- edad45a59 %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>%  summarise (sum(PONDERA)/sum(mujeres$PONDERA))
mujeres

####Mayores o iguales a 60 años####
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

####Primaria completa####
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

####Secundaria completa####
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

####Superior completo####
superiorcompleto <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED==6)
#Hombres:
hombres <- superiorcompleto %>%  filter(CH04==1)
hombres <- hombres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(hombres$PONDERA))
hombres

#Mujeres:
mujeres <- superiorcompleto %>%  filter(CH04==2)
mujeres <- mujeres %>%  group_by(PEA) %>% summarise(sum(PONDERA)/sum(mujeres$PONDERA))
mujeres


##Mercado laboral hasta el segundo trimestre 2020
setwd("~/GitHub/mercadolaboral")

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

#Arreglos en la base del tercer trimestre 2020
#3t
eph3ti<- get_microdata(year=2020, trimester=3, type="individual")
eph3tih <- get_microdata(year=2020, trimester=3, type="hogar")

#2t 
eph2ti<- get_microdata(year=2020, trimester=2, type="individual")
eph2tih <- get_microdata(year=2020, trimester=2, type="hogar")

eph3t <- left_join(eph3ti, eph3tih)
eph3t$PP04B_COD <- as.character(eph3t$PP04B_COD)
eph3t$PP11B_COD <- as.character(eph3t$PP11B_COD)
eph3t$PP11D_COD <- as.character(eph3t$PP11D_COD)
eph2t <- left_join(eph2ti, eph2tih)

ephtotal <- bind_rows(eph3t, eph2t)

#Y listo

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
                                       DESOCUPADOS= case_when(ESTADO==1 ~ 0,
                                                              ESTADO==2 ~ 1),
                                       EMPLEADOS= case_when(PP04A==1 ~ "Empleados Publicos",
                                                            PP04A==2 ~ "Empleados privados",
                                                            PP04A==3 ~ "Otros",
                                                            TRUE ~ NA_character_),
                                       PP04B_COD=as.character(PP04B_COD),
                                       PP04B_COD=case_when(nchar(PP04B_COD)==4~PP04B_COD,
                                                       nchar(PP04B_COD)==1~ paste0("0",PP04B_COD,"00"),
                                                       nchar(PP04B_COD)==2~ paste0(PP04B_COD,"00"),
                                                       nchar(PP04B_COD)==3~ paste0("0",PP04B_COD)),
                                       SECTOR= substr(PP04B_COD,1,2),
                                       INFORMALES=case_when( CAT_OCUP==3 & PP07H==2 ~ 1,
                                                             CAT_OCUP==3 & PP07H==1 ~ 0),
                                       PP04D_COD = as.character(PP04D_COD),
                                       PP04D_COD = case_when(nchar(PP04D_COD) == 5 ~ PP04D_COD,
                                                             nchar(PP04D_COD) == 4 ~ paste0("0", PP04D_COD),
                                                             nchar(PP04D_COD) == 3 ~ paste0("00", PP04D_COD),
                                                             nchar(PP04D_COD) == 2 ~ paste0("000", PP04D_COD),
                                                             nchar(PP04D_COD) == 1 ~ paste0("0000", PP04D_COD)),
                                       CALIFICACION = substr(PP04D_COD, 5, 5),
                                       CALIFICACION = case_when(CALIFICACION=="1" ~ "Profesionales",
                                                                CALIFICACION=="2" ~ "Técnicos",
                                                                CALIFICACION=="3" ~ "Operativos",
                                                                CALIFICACION=="4" ~ "No Calificados",
                                                                TRUE ~ "0"),
                                       CALIFICACION = factor(CALIFICACION, c("No Calificados", "Operativos", "Técnicos", "Profesionales")),
                                       TIPOCALIFICACION= case_when(CALIFICACION=="Profesionales" | CALIFICACION== "Técnicos" ~ "Calificado",
                                                                          CALIFICACION=="No Calificados" | CALIFICACION=="Operativos" ~ "No calificado"))
                                
table(ephtotalsd$CALIFICACION, ephtotalsd$TIPOCALIFICACION)

#Para comprobar: 
table (ephtotalsd$ESTADO, ephtotalsd$PEA)

######Tasa de participacion laboral de la poblacion total #####
#Primero se filtra la base
tablapeapt <- ephtotalsd %>% filter (AGLOMERADO==12 & ESTADO!=0)
#Ahora armamos la tabla (cantidad de 1 sobre cantidad de 0 y 1) y se agrupa entre 0 y 1 (PEA==1), ademas se agrega la cantidad de habitantes dentro de la PEA.
tablapeapt <- tablapeapt %>% group_by(PEA) %>%  summarise((sum(PONDERA)/sum(tablapeapt$PONDERA)), sum(PONDERA), sum(tablapeapt$PONDERA))
tablapeapt

######Tasa de participacion laboral por sexo######
#Primero, se filtra la base:
tablapeasexo<- ephtotalsd %>% filter (AGLOMERADO==12 & ESTADO!=0 & PEA==1)
tablapeasexo <- tablapeasexo %>% group_by(CH04) %>%  summarise(sum(PONDERA), sum(PONDERA)/sum(tablapeasexo$PONDERA))
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

#25-34 a?os
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

#Mayores o iguales a 60 a?os
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
primariacompleta <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED %in% c(2,3))
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
secundariacompleta <- ephtotalsd %>%  filter(AGLOMERADO==12 & ESTADO!=0 & NIVEL_ED %in% c(4,5))
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

#install.packages("Hmisc")
library(Hmisc)

ephcorr <- ephtotalsd %>% filter(AGLOMERADO==12 & ESTADO!=0)
deflactor <- read.csv("deflactor.csv", header=T, sep=";", dec=".")
#deflactor <- read.csv("C:/Users/Bianca/Documents/GitHub/mercadolaboral/deflactor.csv", header=T, sep=";", dec=".")

ephcorr <- left_join(ephcorr, deflactor)
ephcorr <- ephcorr %>%  mutate(IPCFR = IPCF/DEFLACTOR)
ephcorr <- ephcorr %>%  mutate(cuantilp=as.numeric(cut(IPCFR, wtd.quantile(IPCFR, weights = PONDIH, probs = seq(0,1,length=6), na.rm = T), include.lowest = T)))
table(ephcorr$cuantilp)
#ephcorr %>% group_by(cuantilp) %>% summarise(sum(PONDIH))
#ephcorr %>% summarise(IPCFR %*%PONDIH/sum(PONDIH), mean(IPCFR), wtd.mean(IPCFR, weights = PONDIH, na.rm = T) )

#wtd.quantile(ephcorr$IPCFR, weights = ephcorr$PONDIH, probs = seq(0,1,length=6), na.rm = T)
#quantile(ephcorr$IPCFR,probs = seq(0,1,length=6), na.rm=T )

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
#15-24 a?os
horastrab <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & CH06<=24 & CH06>=15 & !is.na(horastrabtotales))
horastrab <- horastrab %>%  group_by(CH04) %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA), wtd.mean(horastrabtotales,weights = PONDERA))
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

####Tasa de empleo####
empleo <- ephtotalsd %>% filter(AGLOMERADO==12 & !is.na(OCUPADOS))
empleo <- empleo %>%  group_by(OCUPADOS) %>%  summarise(percent(sum(PONDERA)/sum(empleo$PONDERA), digits = 2))
empleo

####Tasa de desocupacion####
desocupacion <- ephtotalsd %>% filter(AGLOMERADO==12 & !is.na(DESOCUPADOS))
desocupacion <- desocupacion %>%  group_by(DESOCUPADOS) %>%  summarise(sum(PONDERA)/sum(desocupacion$PONDERA))
desocupacion

#Composicion del empleo
####Empleados publicos y privados####
empleados <- ephtotalsd %>% filter(AGLOMERADO==12 & !is.na(EMPLEADOS) & OCUPADOS==1)
table(empleados$EMPLEADOS)
empleados <- empleados %>%  group_by(EMPLEADOS) %>%  summarise(sum(PONDERA))
empleados
empleados <- empleados %>% mutate(proporcion=`sum(PONDERA)`/sum(empleados$`sum(PONDERA)`))
empleados

####Composicion del empleo publico por sexo####

composicionempleados <- ephtotalsd %>% filter(AGLOMERADO==12 & !is.na(EMPLEADOS) & PP04A==1)
composicionempleados <- composicionempleados %>%  group_by(CH04) %>%  summarise(sum(PONDERA))
composicionempleados <- composicionempleados %>% mutate(proporcion=`sum(PONDERA)`/sum(composicionempleados$`sum(PONDERA)`))
composicionempleados
####Composicion del empleo privado por sexo####

composicionempleados <- ephtotalsd %>% filter(AGLOMERADO==12 & !is.na(EMPLEADOS) & PP04A==2)
composicionempleados <- composicionempleados %>%  group_by(CH04) %>%  summarise(sum(PONDERA))
composicionempleados <- composicionempleados %>% mutate(proporcion=`sum(PONDERA)`/sum(composicionempleados$`sum(PONDERA)`))
composicionempleados
  
####Carga laboral####
#Sector publico

cargalaboralpub <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & !is.na(horastrabtotales) & PP04A==1)
cargalaboralpub <- cargalaboralpub %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
cargalaboralpub

#Sector privado
cargalaboralpriv <- horastrabtotales %>% filter (AGLOMERADO==12 & ESTADO!=0 & !is.na(horastrabtotales) & PP04A==2)
cargalaboralpriv <- cargalaboralpriv %>% summarise(horastrabtotales%*%PONDERA/sum(PONDERA))
cargalaboralpriv

####Promedio de edad por sector####

promedioedad<- ephtotalsd %>% filter(AGLOMERADO==12 &  OCUPADOS==1)
promedioedad<- promedioedad %>% group_by(EMPLEADOS) %>% summarise((CH06%*%PONDERA)/sum(PONDERA), wtd.mean(CH06, weights = PONDERA))
promedioedad

####Composición por sectores del sector público####

#class(ephtotalsd$PP04B_COD)
#caract<- ephtotalsd %>% filter (nchar(PP04B_COD)<4 & OCUPADOS==1 )
#comprobacion<- caract %>% group_by(PP04B_COD) %>% count()
#table(ephtotalsd$calif)
caract<- ephtotalsd %>% group_by(SECTOR) %>% filter(OCUPADOS==1) %>% count()
caes<- read.csv("SECTORESCAES.csv", sep = ";", colClasses = "character")
sectores<- left_join(ephtotalsd,caes)

corro<- sectores %>% select(SECTOR_ACT,SECTOR, PP04B_COD, CH11, ESTADO, OCUPADOS, PONDERA)
table(sectores$CH11, sectores$ESTADO)

spublico<- sectores %>% filter(AGLOMERADO==12 & PP04A==1)
spublico <- spublico %>% group_by(SECTOR_ACT) %>% summarise(formattable::percent(sum(PONDERA)/sum(spublico$PONDERA)), sum(PONDERA))

####informalidad####
#por sexo y edad no se usa

informalidad<- ephtotalsd %>% filter(AGLOMERADO==12 & !is.na(INFORMALES))
informales<- informalidad %>% filter(INFORMALES==1)
informales1<- informales %>% group_by(CH04) %>% summarise(sum(PONDERA)/sum(informales$PONDERA))
informales1

formales<- informalidad %>% filter(INFORMALES==0)
formales<- formales %>% group_by(CH04) %>% summarise(sum(PONDERA)/(sum(formales$PONDERA)))
formales

#Por sexo y edad

##15 a 24
informalesh15_24<- ephtotalsd %>% filter(CH06>=15 & CH06<=24 & AGLOMERADO==12 & CH04==1 & !is.na(INFORMALES))  
informalesh15_24 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesh15_24$PONDERA))

informalesm15_24<-  ephtotalsd %>% filter(CH06>=15 & CH06<=24 & AGLOMERADO==12 & CH04==2 & !is.na(INFORMALES))  
informalesm15_24 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesm15_24$PONDERA))

#25-34
informalesh25_34<- ephtotalsd %>% filter(CH06>=25 & CH06<=34 & AGLOMERADO==12 & CH04==1 & !is.na(INFORMALES))  
informalesh25_34 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesh25_34$PONDERA))

informalesm25_34<-  ephtotalsd %>% filter(CH06>=25 & CH06<=34 & AGLOMERADO==12 & CH04==2 & !is.na(INFORMALES))  
informalesm25_34 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesm25_34$PONDERA))

#35-44
informalesh35_44<- ephtotalsd %>% filter(CH06>=35 & CH06<=44 & AGLOMERADO==12 & CH04==1 & !is.na(INFORMALES))  
informalesh35_44 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesh35_44$PONDERA))

informalesm35_44<-  ephtotalsd %>% filter(CH06>=35 & CH06<=44 & AGLOMERADO==12 & CH04==2 & !is.na(INFORMALES))  
informalesm35_44 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesm35_44$PONDERA))

#45-59
informalesh45_59<- ephtotalsd %>% filter(CH06>=45 & CH06<=59 & AGLOMERADO==12 & CH04==1 & !is.na(INFORMALES))  
informalesh45_59 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesh45_59$PONDERA))

informalesm45_59<-  ephtotalsd %>% filter(CH06>=45 & CH06<=59 & AGLOMERADO==12 & CH04==2 & !is.na(INFORMALES))  
informalesm45_59 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesm45_59$PONDERA))

#60 0 +
informalesh60<- ephtotalsd %>% filter(CH06>=60  & AGLOMERADO==12 & CH04==1 & !is.na(INFORMALES))  
informalesh60 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesh60$PONDERA))

informalesm60<-  ephtotalsd %>% filter(CH06>=60  & AGLOMERADO==12 & CH04==2 & !is.na(INFORMALES))  
informalesm60 %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalesm60$PONDERA))

#Total
informalestot<- ephtotalsd %>% filter( AGLOMERADO==12  & !is.na(INFORMALES))  
informalestot %>% group_by(INFORMALES) %>%  summarise(sum(PONDERA)/sum(informalestot$PONDERA))

#por sexo
informalestoth<- ephtotalsd %>% filter( AGLOMERADO==12  & !is.na(INFORMALES) & CH04==1)
informalestoth %>% group_by(INFORMALES) %>% summarise(sum(PONDERA)/sum(informalestoth$PONDERA))

informalestotm<- ephtotalsd %>% filter( AGLOMERADO==12  & !is.na(INFORMALES) & CH04==2)
informalestotm %>% group_by(INFORMALES) %>% summarise(sum(PONDERA)/sum(informalestotm$PONDERA))

#### Tasa de informalidad laboral desagregada por sector de actividad ####

inforporsector<- function(i) {
  infor <- sectores %>% filter(AGLOMERADO==12  & !is.na(INFORMALES) & SECTOR_ACT==i)
  infor <- infor %>% group_by(INFORMALES) %>%  summarise(formattable::percent(sum(PONDERA)/sum(infor$PONDERA), digits=2))
  return(infor)
}
  
nombres<-(unique(sectores$SECTOR_ACT))
nombres


sectores %>% filter(SECTOR_ACT=="EXPLOTACIÓN DE MINAS Y CANTERAS" & AGLOMERADO==12  & !is.na(INFORMALES)) %>% group_by(INFORMALES) %>% summarise(n())


infoyco<-inforporsector("INFORMACIÓN Y COMUNICACIÓN")
enseñanza<-inforporsector("ENSEÑANZA")
construccion<-inforporsector("CONSTRUCCIÓN")
adminpub<-inforporsector("ADMINISTRACIÓN PÚBLICA Y DEFENSA; PLANES DE SEGURO SOCIAL OBLIGATORIO" )
cientifi<-inforporsector("ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS")
salud<-inforporsector("SALUD HUMANA Y SERVICIOS SOCIALES")
financiera<-inforporsector("ACTIVIDADES FINANCIERAS Y DE SEGUROS" )
inforporsector("COMERCIO AL POR MAYOR Y AL POR MENOR; REPARACIÓN DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS")
inforporsector("INDUSTRIA MANUFACTURERA")
inforporsector("TRANSPORTE Y ALMACENAMIENTO" )
inforporsector("ARTES, ENTRETENIMIENTO Y RECREACIÓN")
inforporsector("AGRICULTURA, GANADERÍA, CAZA, SILVICULTURA Y PESCA")
inforporsector("ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE\nPERSONAL DOMÉSTICO" )
inforporsector("OTRAS ACTIVIDADES DE SERVICIOS")
inforporsector("ACTIVIDADES DE ORGANIZACIONES Y ORGANISMOS\nEXTRATERRITORIALES")
inforporsector("ACTIVIDADES ADMINISTRATIVAS Y SERVICIOS DE APOYO" )
inforporsector("ACTIVIDADES DE ORGANIZACIONES Y ORGANISMOS\nEXTRATERRITORIALES")
inforporsector("ACTIVIDADES ADMINISTRATIVAS Y SERVICIOS DE APOYO")
inforporsector("ALOJAMIENTO Y SERVICIOS DE COMIDAS")
inforporsector("EXPLOTACIÓN DE MINAS Y CANTERAS")
inforporsector("SUMINISTRO DE ELECTRICIDAD, GAS, VAPOR Y AIRE\nACONDICIONADO")
inforporsector("SUMINISTRO DE AGUA; ALCANTARILLADO, GESTIÓN DE DESECHOS Y ACTIVIDADES DE SANEAMIENTO")
inforporsector("ACTIVIDADES INMOBILIARIAS" )



#### Calificación por sector ####

califporsector<- function(i) {
  calif <- sectores %>% filter(AGLOMERADO==12  & !is.na(TIPOCALIFICACION) & SECTOR_ACT==i)
  calif <- calif %>% group_by(TIPOCALIFICACION) %>%  summarise(formattable::percent(sum(PONDERA)/sum(calif$PONDERA), digits=2))
  return(calif)
}

#Para comprobar
#nombres<-(unique(sectores$SECTOR_ACT))
#nombres
#sectores %>% filter(SECTOR_ACT=="EXPLOTACIÓN DE MINAS Y CANTERAS" & AGLOMERADO==12  & !is.na(TIPOCALIFICACION)) %>% group_by(TIPOCALIFICACION) %>% summarise(n())

infoyco<-califporsector("INFORMACIÓN Y COMUNICACIÓN")
enseñanza<-califporsector("ENSEÑANZA")
construccion<-califporsector("CONSTRUCCIÓN")
adminpub<-califporsector("ADMINISTRACIÓN PÚBLICA Y DEFENSA; PLANES DE SEGURO SOCIAL OBLIGATORIO" )
cientifi<-califporsector("ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS")
salud<-califporsector("SALUD HUMANA Y SERVICIOS SOCIALES")
financiera<-califporsector("ACTIVIDADES FINANCIERAS Y DE SEGUROS" )
califporsector("COMERCIO AL POR MAYOR Y AL POR MENOR; REPARACIÓN DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS")
califporsector("INDUSTRIA MANUFACTURERA")
califporsector("TRANSPORTE Y ALMACENAMIENTO" )
califporsector("ARTES, ENTRETENIMIENTO Y RECREACIÓN")
califporsector("AGRICULTURA, GANADERÍA, CAZA, SILVICULTURA Y PESCA")
califporsector("ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE\nPERSONAL DOMÉSTICO" )
califporsector("OTRAS ACTIVIDADES DE SERVICIOS")
califporsector("ACTIVIDADES DE ORGANIZACIONES Y ORGANISMOS\nEXTRATERRITORIALES")
califporsector("ACTIVIDADES ADMINISTRATIVAS Y SERVICIOS DE APOYO" )
califporsector("ACTIVIDADES DE ORGANIZACIONES Y ORGANISMOS\nEXTRATERRITORIALES")
califporsector("ACTIVIDADES ADMINISTRATIVAS Y SERVICIOS DE APOYO")
califporsector("ALOJAMIENTO Y SERVICIOS DE COMIDAS")
califporsector("EXPLOTACIÓN DE MINAS Y CANTERAS")
califporsector("SUMINISTRO DE ELECTRICIDAD, GAS, VAPOR Y AIRE\nACONDICIONADO")
califporsector("SUMINISTRO DE AGUA; ALCANTARILLADO, GESTIÓN DE DESECHOS Y ACTIVIDADES DE SANEAMIENTO")
califporsector("ACTIVIDADES INMOBILIARIAS" )
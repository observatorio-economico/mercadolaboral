use "C:\Users\Bianca\Desktop\MUNI\DATOS\CARPETA MIA\EPH mergeadas\Interanuales\SinDupli_3t2019_2t2020.dta", clear

* Tasa de informalidad laboral desagregada por sector de actividad

gen informales=.
replace informales =1 if cat_ocup==3 & pp07h==2
replace informales =0 if cat_ocup==3 & pp07h==1

tab pp04b_cod if aglomerado==12
tostring pp04b_cod, replace

************cambiados al SEGUNDO trimestre 2020**************
replace pp04b_cod="0100" if pp04b_cod=="1"
replace pp04b_cod="4800" if pp04b_cod=="48"
replace pp04b_cod="4500" if pp04b_cod=="45"
replace pp04b_cod="4900" if pp04b_cod=="49"
replace pp04b_cod="0102" if pp04b_cod=="102"
replace pp04b_cod="0103" if pp04b_cod=="103"
replace pp04b_cod="0104" if pp04b_cod=="104"
replace pp04b_cod="0300" if pp04b_cod=="300"

************************************************************
replace pp04b_cod="4500" if pp04b_cod=="45"
replace pp04b_cod="0100" if pp04b_cod=="1"
replace pp04b_cod="1000" if pp04b_cod=="10"
replace pp04b_cod="0101" if pp04b_cod=="101"
replace pp04b_cod="0102" if pp04b_cod=="102"
replace pp04b_cod="0103" if pp04b_cod=="103"
replace pp04b_cod="0104" if pp04b_cod=="104"
replace pp04b_cod="1500" if pp04b_cod=="15"
replace pp04b_cod="2000" if pp04b_cod=="20"
replace pp04b_cod="0200" if pp04b_cod=="200"
replace pp04b_cod="2600" if pp04b_cod=="26"
replace pp04b_cod="0300" if pp04b_cod=="300"
replace pp04b_cod="3500" if pp04b_cod=="35"
replace pp04b_cod="0300" if pp04b_cod=="300"
replace pp04b_cod="4800" if pp04b_cod=="48"
replace pp04b_cod="5600" if pp04b_cod=="56"
replace pp04b_cod="0800" if pp04b_cod=="800"
replace pp04b_cod="9500" if pp04b_cod=="95"

	 
gen str2 CodAct = ""
replace CodAct = substr(pp04b_cod,1,2) 

g Agricultura=0
replace Agricultura=1 if CodAct=="01"
replace Agricultura=1 if CodAct=="02"
replace Agricultura=1 if CodAct=="03"

g Mineria=0
replace Mineria=1 if CodAct=="05"
replace Mineria=1 if CodAct=="06"
replace Mineria=1 if CodAct=="07"
replace Mineria=1 if CodAct=="08"
replace Mineria=1 if CodAct=="09"


g Manuf=0
replace Manuf=1 if CodAct=="10"
replace Manuf=1 if CodAct=="11"
replace Manuf=1 if CodAct=="12"
replace Manuf=1 if CodAct=="13"
replace Manuf=1 if CodAct=="14"
replace Manuf=1 if CodAct=="15"
replace Manuf=1 if CodAct=="16"
replace Manuf=1 if CodAct=="17"
replace Manuf=1 if CodAct=="18"
replace Manuf=1 if CodAct=="19"
replace Manuf=1 if CodAct=="20"
replace Manuf=1 if CodAct=="21"
replace Manuf=1 if CodAct=="22"
replace Manuf=1 if CodAct=="23"
replace Manuf=1 if CodAct=="24"
replace Manuf=1 if CodAct=="25"
replace Manuf=1 if CodAct=="26"
replace Manuf=1 if CodAct=="27"
replace Manuf=1 if CodAct=="28"
replace Manuf=1 if CodAct=="29"
replace Manuf=1 if CodAct=="30"
replace Manuf=1 if CodAct=="31"
replace Manuf=1 if CodAct=="32"
replace Manuf=1 if CodAct=="33"

g SuminElect=0
replace SuminElect=1 if CodAct=="35"

g SuminAgua=0
replace SuminAgua=1 if CodAct=="36"
replace SuminAgua=1 if CodAct=="37"
replace SuminAgua=1 if CodAct=="38"
replace SuminAgua=1 if CodAct=="39"

g Construccion=0
replace Construccion=1 if CodAct=="40"

g Autom=0
replace Autom=1 if CodAct=="45"
replace Autom=1 if CodAct=="48"

g Transporte=0
replace Transporte=1 if CodAct=="49"
replace Transporte=1 if CodAct=="50"
replace Transporte=1 if CodAct=="51"
replace Transporte=1 if CodAct=="52"
replace Transporte=1 if CodAct=="53"

g AlojyComida=0
replace AlojyComida=1 if CodAct=="55"
replace AlojyComida=1 if CodAct=="56"

g Comunicacion=0
replace Comunicacion=1 if CodAct=="58"
replace Comunicacion=1 if CodAct=="59"
replace Comunicacion=1 if CodAct=="60"
replace Comunicacion=1 if CodAct=="61"
replace Comunicacion=1 if CodAct=="62"
replace Comunicacion=1 if CodAct=="63"

g Financiera=0
replace Financiera=1 if CodAct=="64"
replace Financiera=1 if CodAct=="65"
replace Financiera=1 if CodAct=="66"

g Inmobiliarias=0
replace Inmobiliarias=1 if CodAct=="68"

g Profesionales=0
replace Profesionales=1 if CodAct=="69"
replace Profesionales=1 if CodAct=="70"
replace Profesionales=1 if CodAct=="71"
replace Profesionales=1 if CodAct=="72"
replace Profesionales=1 if CodAct=="73"
replace Profesionales=1 if CodAct=="74"
replace Profesionales=1 if CodAct=="75"

g Admin=0
replace Admin=1 if CodAct=="77"
replace Admin=1 if CodAct=="78"
replace Admin=1 if CodAct=="79"
replace Admin=1 if CodAct=="80"
replace Admin=1 if CodAct=="81"
replace Admin=1 if CodAct=="82"

g AdminPublica=0
replace AdminPublica=1 if CodAct=="83"
replace AdminPublica=1 if CodAct=="84"

g Enseñanza=0
replace Enseñanza=1 if CodAct=="85"

g Salud=0
replace Salud=1 if CodAct=="86"
replace Salud=1 if CodAct=="87"
replace Salud=1 if CodAct=="88"

g Arte=0
replace Arte=1 if CodAct=="90"
replace Arte=1 if CodAct=="91"
replace Arte=1 if CodAct=="92"
replace Arte=1 if CodAct=="93"

g OtrosServ=0
replace OtrosServ=1 if CodAct=="94"
replace OtrosServ=1 if CodAct=="95"
replace OtrosServ=1 if CodAct=="96"

g ActHogares=0
replace ActHogares=1 if CodAct=="97"
replace ActHogares=1 if CodAct=="98"

g ActExtrater=0
replace ActExtrater=1 if CodAct=="99"

*********************************************************
*Agricultura
tab informales if (aglomerado==12 & estado!=0 & Agricultura==1) [fw=pondera]
*Mineria
tab informales if (aglomerado==12 & estado!=0 & Mineria==1) [fw=pondera]
*Manufactura
tab informales if (aglomerado==12 & estado!=0 & Manuf==1) [fw=pondera]
*Suministro electrico
tab informales if (aglomerado==12 & estado!=0 & SuminElect==1) [fw=pondera]
*Suministro Agua
tab informales if (aglomerado==12 & estado!=0 & SuminAgua==1) [fw=pondera]
*Construccion
tab informales if (aglomerado==12 & estado!=0 & Construccion==1) [fw=pondera]
*Automotriz
tab informales if (aglomerado==12 & estado!=0 & Autom==1) [fw=pondera]
*Transporte
tab informales if (aglomerado==12 & estado!=0 & Transporte==1) [fw=pondera]
*Alojamiento y comida
tab informales if (aglomerado==12 & estado!=0 & AlojyComida==1) [fw=pondera]
*Comunicaciones
tab informales if (aglomerado==12 & estado!=0 & Comunicacion==1) [fw=pondera]
*Financiera
tab informales if (aglomerado==12 & estado!=0 & Financiera==1) [fw=pondera]
*Inmobiliaria
tab informales if (aglomerado==12 & estado!=0 & Inmobiliarias==1) [fw=pondera]
*Profesionales
tab informales if (aglomerado==12 & estado!=0 & Profesionales==1) [fw=pondera]
*Administrativas
tab informales if (aglomerado==12 & estado!=0 & Admin==1) [fw=pondera]
*Administracion publica
tab informales if (aglomerado==12 & estado!=0 & AdminPublica==1) [fw=pondera]
*Enseñanza
tab informales if (aglomerado==12 & estado!=0 & Enseñanza==1) [fw=pondera]
*Salud
tab informales if (aglomerado==12 & estado!=0 & Salud==1) [fw=pondera]
*Arte
tab informales if (aglomerado==12 & estado!=0 & Arte==1) [fw=pondera]
*Otros servicios
tab informales if (aglomerado==12 & estado!=0 & OtrosServ==1) [fw=pondera]
*Actividad de los hogares
tab informales if (aglomerado==12 & estado!=0 & ActHogares==1) [fw=pondera]
*Actividades extraterritoriales
tab informales if (aglomerado==12 & estado!=0 & ActExtrater==1) [fw=pondera]







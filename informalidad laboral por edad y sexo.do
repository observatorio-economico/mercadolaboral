use "C:\Users\Bianca\Desktop\MUNI\DATOS\CARPETA MIA\EPH mergeadas\Interanuales\SinDupli_3t2019_2t2020.dta", clear

* Tasa de informalidad laboral (total y curvas por edad y sexo)

gen informales=.
replace informales =1 if cat_ocup==3 & pp07h==2
replace informales =0 if cat_ocup==3 & pp07h==1


* Hogares
tab informales if (aglomerado==12 & ch03==1 & estado!=0) [fw=pondera]
* Personas
tab informales if (aglomerado==12 & estado!=0) [fw=pondera] 

*Total y por Sexo (individual)
*Total

tab informales if (aglomerado==12 & estado!=0) [fw=pondera]
*Hombres
tab informales if (aglomerado==12 & estado!=0 & ch04==1) [fw=pondera]

*Mujeres
tab informales if (aglomerado==12 & estado!=0 & ch04==2) [fw=pondera]


* Por sexo y edad

** 15 - 24
** Hombres
tab informales if (aglomerado==12 & ch04==1 & ch06>=15 & ch06<=24 & estado!=0) [fw=pondera] 

**Mujeres
tab informales if (aglomerado==12 & ch04==2 & ch06>=15 & ch06<=24 & estado!=0) [fw=pondera] 

** 25-34
**Hombres
tab informales if (aglomerado==12 & ch04==1 & ch06>=25 & ch06<=34 & estado!=0) [fw=pondera] 

**Mujeres
tab informales if (aglomerado==12 & ch04==2 & ch06>=25 & ch06<=34 & estado!=0) [fw=pondera] 

**35-44
**Hombres
tab informales if (aglomerado==12 & ch04==1 & ch06>=35 & ch06<=44 & estado!=0) [fw=pondera] 

**Mujeres
tab informales if (aglomerado==12 & ch04==2 & ch06>=35 & ch06<=44 & estado!=0) [fw=pondera] 

**45-59
**Hombres
tab informales if (aglomerado==12 & ch04==1 & ch06>=45 & ch06<=59 & estado!=0) [fw=pondera] 

**Mujeres
tab informales if (aglomerado==12 & ch04==2 & ch06>=45 & ch06<=59 & estado!=0) [fw=pondera] 

**Mayores a 60
**Hombres
tab informales if (aglomerado==12 & ch04==1 & ch06>=60 & estado!=0) [fw=pondera] 

**Mujeres
tab informales if (aglomerado==12 & ch04==2 & ch06>=60 & estado!=0) [fw=pondera] 

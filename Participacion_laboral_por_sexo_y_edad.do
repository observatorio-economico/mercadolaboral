** Calculo tasas participacion laboral 

use "C:\Users\Bianca\Desktop\MUNI\DATOS\CARPETA MIA\EPH mergeadas\Interanuales\SinDupli_3t2019_2t2020.dta", clear

gen PEA=.
replace PEA=0 if estado==3
replace PEA=0 if estado==4
replace PEA=1 if estado==1
replace PEA=1 if estado==2

** Tasa participacion Pob. Total
tab PEA if (aglomerado==12 & estado!=0) [fw=pondera]
tab PEA ch04 if (aglomerado==12 & estado!=0) [fw=pondera]

** Tasa part. por edad y sexo

** 15 - 24
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=15 & ch06<=24 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=15 & ch06<=24 & ch04==2) [fw=pondera]

** 25-34
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=25 & ch06<=34 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=25 & ch06<=34 & ch04==2) [fw=pondera]

**35-44
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=35 & ch06<=44 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=35 & ch06<=44 & ch04==2) [fw=pondera]

**45-59
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=45 & ch06<=59 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=45 & ch06<=59 & ch04==2) [fw=pondera]

**Mayores a 60
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=60 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & ch06>=60 & ch04==2) [fw=pondera]

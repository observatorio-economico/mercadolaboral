** Calculo tasas participacion laboral 

use "C:\Users\Bianca\Desktop\MUNI\DATOS\CARPETA MIA\EPH mergeadas\Interanuales\SinDupli_3t2019_2t2020.dta", clear



gen PEA=.
replace PEA=0 if estado==3
replace PEA=0 if estado==4
replace PEA=1 if estado==1
replace PEA=1 if estado==2

** Tasa participacion Pob. Total
tab PEA if (aglomerado==12 & estado!=0) [fw=pondera]
tab PEA if (aglomerado==12 & estado!=0 & ch04==1) [fw=pondera]
tab PEA if (aglomerado==12 & estado!=0 & ch04==2) [fw=pondera]

** Tasa part. por edad y nivel educativo

** Primaria incompleta
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==1 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==1 & ch04==2) [fw=pondera]

** Primaria completa
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==2 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==2 & ch04==2) [fw=pondera]

** Secundaria incompleta
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==3 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==3 & ch04==2) [fw=pondera]

** Secundaria completa
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==4 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==4 & ch04==2) [fw=pondera]

** Superior universitaria incompleta
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==5 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==5 & ch04==2) [fw=pondera]

** Superior universitaria completa
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==6 & ch04==1) [fw=pondera]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & nivel_ed==6 & ch04==2) [fw=pondera]




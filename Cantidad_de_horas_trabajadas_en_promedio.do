** Carga laboral

use "C:\Users\Bianca\Desktop\MUNI\DATOS\CARPETA MIA\EPH mergeadas\Interanuales\SinDupli_3t2019_2t2020.dta", clear



** Por sexo y edad

g TotalHoras_Ctes = pp3e_tot + pp3f_tot if aglomerado==12 & estado!=0

**15-24 
**Hombres
g TotalHoras_15_24_H = TotalHoras_Ctes if ch04==1 & ch06>=15 & ch06<=24
sum TotalHoras_15_24_H [fw=pondera]
display r(mean)

**Mujeres
g TotalHoras_15_24_M = TotalHoras_Ctes if ch04==2 & ch06>=15 & ch06<=24
sum TotalHoras_15_24_M [fw=pondera]
display r(mean)

**25-34
**Hombres
g TotalHoras_25_34_H = TotalHoras_Ctes if ch04==1 & ch06>=25 & ch06<=34
sum TotalHoras_25_34_H [fw=pondera]
display r(mean)

**Mujeres
g TotalHoras_25_34_M = TotalHoras_Ctes if ch04==2 & ch06>=25 & ch06<=34
sum TotalHoras_25_34_M [fw=pondera]
display r(mean)

**35-44
**Hombres
g TotalHoras_35_44_H = TotalHoras_Ctes if ch04==1 & ch06>=35 & ch06<=44
sum TotalHoras_35_44_H [fw=pondera]
display r(mean)

**Mujeres
g TotalHoras_35_44_M = TotalHoras_Ctes if ch04==2 & ch06>=35 & ch06<=44
sum TotalHoras_35_44_M [fw=pondera]
display r(mean)

**45-59
**Hombres
g TotalHoras_45_59_H = TotalHoras_Ctes if ch04==1 & ch06>=45 & ch06<=59
sum TotalHoras_45_59_H [fw=pondera]
display r(mean)

**Mujeres
g TotalHoras_45_59_M = TotalHoras_Ctes if ch04==2 & ch06>=45 & ch06<=59
sum TotalHoras_45_59_M [fw=pondera]
display r(mean)

**Mas de 60
**Hombres
g TotalHoras_mas60_H = TotalHoras_Ctes if ch04==1 & ch06>=60
sum TotalHoras_mas60_H [fw=pondera]
display r(mean)

**Mujeres
g TotalHoras_mas60_M = TotalHoras_Ctes if ch04==2 & ch06>=60
sum TotalHoras_mas60_M [fw=pondera]
display r(mean)

****EN total, sin diferenciar por sexo
*Hombres

sum TotalHoras_Ctes if ch04==1 [fw=pondera]
*Mujeres


sum TotalHoras_Ctes if ch04==2 [fw=pondera]

*Total 

sum TotalHoras_Ctes  [fw=pondera]


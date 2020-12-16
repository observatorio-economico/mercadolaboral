** Calculo tasas participacion laboral 

use "C:\Users\Bianca\Desktop\MUNI\DATOS\CARPETA MIA\EPH mergeadas\Interanuales\SinDupli_3t2019_2t2020.dta", clear

gen PEA=.
replace PEA=0 if estado==3
replace PEA=0 if estado==4
replace PEA=1 if estado==1
replace PEA=1 if estado==2

** Tasa participacion Pob. Total
tab PEA if (aglomerado==12 & estado!=0) [fw=pondih]
tab PEA if (aglomerado==12 & estado!=0 & ch04==1) [fw=pondih]
tab PEA if (aglomerado==12 & estado!=0 & ch04==2) [fw=pondih]


** Tasa part. por sexo y quintil de ingreso

gen ipcfR=.
replace ipcfR= ipcf/1.229466026 if trimestre==3 & ano4==2019
replace ipcfR= ipcf/1.397053248 if trimestre==4 & ano4==2019
replace ipcfR= ipcf/1.538301945 if trimestre==1 & ano4==2020
replace ipcfR= ipcf/1.649265277 if trimestre==2 & ano4==2020
xtile QuintilesIPCFR = ipcfR if aglomerado==12[fw=pondih], nq(5)



** Quintil 1
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==1 & ch04==1) [fw=pondih]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==1 & ch04==2) [fw=pondih]

** Quintil 2 
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==2 & ch04==1) [fw=pondih]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==2 & ch04==2) [fw=pondih]

** Quintil 3
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==3 & ch04==1) [fw=pondih]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==3 & ch04==2) [fw=pondih]

** Quintil 4
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==4 & ch04==1) [fw=pondih]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==4 & ch04==2) [fw=pondih]

** Quintil 5
** Hombres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==5 & ch04==1) [fw=pondih]
**Mujeres
tab PEA if (aglomerado==12 & estado!=0 & QuintilesIPCFR==5 & ch04==2) [fw=pondih]


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

#Y listo, con esta forma no hace falta bajar los archivos del INDEC. 


---
header-includes:
   - \usepackage{pdfpages}
   - \usepackage[default]{open sans}
   - \usepackage[T1]{fontenc}
   - \usepackage{graphicx}
   - \usepackage{fancyhdr}
   - \usepackage{hyperref}
   - \usepackage{xcolor}
   - \usepackage{sidecap}
   - \usepackage[spanish]{babel}
   - \pagestyle{fancy}
   - \renewcommand{\headrulewidth}{0pt}
   - \fancyhead{}
   - \setlength{\headheight}{23pt}
   - \lhead{\includegraphics[width=7cm,height=140cm]{"./logos/logo_oecc.pdf"}}
   - \fancyfoot{}
   - \lfoot{\includegraphics[width=5.0cm,height=140cm]{"./logos/muni.jpg"}}
   - \rfoot{\thepage}
   - \definecolor{graycustom}{HTML}{7b7b7e}
   - \usepackage{floatrow}
   - \floatsetup[figure]{capposition=top}
   - \renewcommand{\arraystretch}{1.5}
   - \usepackage{svg}
   - \usepackage{amsmath}

mainfont: Open Sans
output: 
  pdf_document: default
  keep_tex: true
includes:
fig_caption: yes

html_document:
    df_print: paged
---




\newline

\textcolor{graycustom}{\Large Consideraciones metodológicas}
\newline

El Observatorio Económico de la Municipalidad de Corrientes lleva a cabo diversos informes socio-demográficos, utilizando como fuente principal la base de microdatos de la Encuesta Permanente de Hogares elaborada por el Instituto Nacional de Estadísticas y Censos (INDEC) y presentada con una periodicidad trimestral. La misma se realiza a través de cuestionarios presenciales que luego son volcados a bases de datos para ser utilizados por el público en general.

A raíz del decreto N.º 297/2020 que establece el aislamiento social, preventivo y obligatorio por la pandemia causada por el virus SARS-COV2, y con el objetivo de no interrumpir el operativo continuo, el INDEC pasó de la modalidad presencial a la telefónica para contactar y realizar la entrevista a los hogares.

Esto implica que, a partir del Cuarto trimestre del 2020, el relevamiento habitual de la EPH se ha visto afectado no solo por el cambio de modalidad de entrevista, sino también por la cobertura de la muestra, ya que la misma se redujo a las viviendas que tenían un número de teléfono conocido o cuyo número se pudo obtener mediante estrategias que no implicaban contacto personal. Ambos aspectos impactan en la cantidad de hogares sin respuesta y ocasionan sesgos en las estimaciones.

Gracias a los esfuerzos del INDEC para asegurar la difusión de las estadísticas y aminorar los posibles sesgos producidos en los datos del trimestre, el Observatorio Económico pudo llevar a cabo este informe. Sin embargo, creemos oportuno realizar las aclaraciones metodológicas antes descritas.

Por último, este trabajo se ha hecho considerando a los datos del cuarto trimestre de 2021, con excepción de los apartados de informalidad por sectores y calificación laboral por sectores, que se hicieron trabajando en conjunto con las bases del tercer trimestre del 2021.








\newpage 
\textcolor{graycustom}{\Large Mercado de trabajo: 
Tasas e indicadores socioeconómicos (EPH)}
\newline

Según las proyecciones de INDEC basadas en el último Censo de población, la cantidad de habitantes total de la ciudad en el año 2021 es de 414927 personas. De ese total el 48.83% son hombres y el restante 51.17%, mujeres.

De acuerdo con los datos publicados por el INDEC, basados también en el último Censo Nacional de Población, Hogares y Viviendas (2010), la población por edades se compone de la siguiente manera:




\begin{table}

\caption{\label{tab:unnamed-chunk-5}Composición de la población}
\centering
\fontsize{9}{11}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{18em}>{\raggedleft\arraybackslash}p{14em}>{\raggedleft\arraybackslash}p{14em}}
\toprule
\begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Edad}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Hombres}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Mujeres}}}\endgroup\\
\midrule
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{0-14}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{28.00\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{25.00\%}}\\
15-24 & 21.00\% & 20.00\%\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{25-34}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{16.00\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{16.00\%}}\\
35-44 & 11.00\% & 12.00\%\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{45-59}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{15.00\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{15.00\%}}\\
\addlinespace
Mayor o igual a 60 & 9.00\% & 12.00\%\\
\bottomrule
\end{tabular}
\end{table}


![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 

\newpage 
\textcolor{graycustom}{\Large Indicadores de participación laboral}
\newline

Los resultados del primer trimestre de 2022 para la Ciudad de Corrientes muestran que la tasa de actividad es del 43.14%.

Del total de personas que conforman la PEA, el 57.68% son hombres y el42.32% mujeres. Por otro lado, se observa que del total de mujeres, el 34.94% forman parte de la PEA, mientras que en el caso de los hombres el porcentaje que forma parte de la PEA alcanza el 52.11%.

La población económicamente activa (PEA), a su vez, está compuesta por los ocupados y desocupados. Este último grupo presiona activamente sobre el mercado laboral en búsqueda de una ocupación.

La definición vista de PEA, no incluye al trabajo no remunerado (doméstico, voluntario y de subsistencia). Esto implica que, en la medición de la actividad de la EPH, no se considera activa a la población que realiza producción o tratamiento de bienes exclusivamente para autoconsumo. Esto trae inconvenientes en cuanto a la subestimación de la participación femenina en la actividad económica. Por la importancia que tiene este tópico en las brechas de género, el tema es tratado especialmente en el "Informe de Género" realizado por el Observatorio Económico de la Ciudad de Corrientes.

A continuación, se aprecian los porcentajes, tanto de hombres como de mujeres, que forman parte de la PEA, desagregados por rangos de edad.











\begin{table}

\caption{\label{tab:unnamed-chunk-11}Participación laboral por sexo y edad}
\centering
\fontsize{9}{11}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{18em}>{\raggedleft\arraybackslash}p{14em}>{\raggedleft\arraybackslash}p{14em}}
\toprule
\begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Edad}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Hombres}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Mujeres}}}\endgroup\\
\midrule
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{15-24 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{37.48\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{24.32\%}}\\
25-34 años & 85.91\% & 55.17\%\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{35-44 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{94.06\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{76.56\%}}\\
45-59 años & 93.29\% & 61.69\%\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{Igual o mayor a 60 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{38.78\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{10.56\%}}\\
\bottomrule
\end{tabular}
\end{table}


![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-12-1.pdf)<!-- --> 

Se puede observar que, para todos los rangos etarios existe una brecha en la tasa de actividad que muestra que hay menos mujeres participando en el mercado laboral, en comparación a los hombres.

A modo de observación, para ambos sexos, el porcentaje máximo de participación se encuentra entre los 35 a 44 años.

Tanto en la tabla como en el Gráfico 3 se exponen los porcentajes tanto de hombres como de mujeres pertenecientes a la PEA, desagregados por el nivel de educación alcanzado, junto con las respectivas brechas. Se entiende como brecha a la diferencia entre el porcentaje de hombres y mujeres que conforman la PEA para cada nivel educativo.



\begin{table}

\caption{\label{tab:unnamed-chunk-14}Participación laboral por sexo y nivel educativo}
\centering
\fontsize{9}{11}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{12em}>{\raggedleft\arraybackslash}p{10em}>{\raggedleft\arraybackslash}p{10em}>{\raggedleft\arraybackslash}p{10em}}
\toprule
\begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Nivel}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Hombres}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Mujeres}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Brecha}}}\endgroup\\
\midrule
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{Primaria Completa}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{53.08\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{22.19\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{30.89\%}}\\
Secundaria Completa & 69.67\% & 45.01\% & 24.66\%\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{Superior Completo}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{80.19\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{74.03\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{6.16\%}}\\
\bottomrule
\end{tabular}
\end{table}



![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-15-1.pdf)<!-- --> 



Nuevamente, hay una brecha positiva en la participación para todos los niveles, siendo la mas importante para personas con primario completo, para el que la brecha llega a 30.89%.

Los valores que se presentan y grafican a continuación corresponden al promedio de horas semanales que trabajan tanto hombres como mujeres, desagregados por edad.






\begin{table}

\caption{\label{tab:unnamed-chunk-18}Carga laboral semanal por sexo y edad}
\centering
\fontsize{9}{11}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{12em}>{\raggedleft\arraybackslash}p{10em}>{\raggedleft\arraybackslash}p{10em}>{\raggedleft\arraybackslash}p{10em}}
\toprule
\begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Edad}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Hombres}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Mujeres}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Brecha}}}\endgroup\\
\midrule
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{15-24 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{34.11}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{30.96}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{3.16}}\\
25-34 años & 36.34 & 29.28 & 7.06\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{35-44 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{41.04}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{30.54}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{10.50}}\\
45-59 años & 38.80 & 31.30 & 7.50\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{Igual o mayor a 60 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{35.24}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{19.04}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{16.20}}\\
\bottomrule
\end{tabular}
\end{table}


![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-19-1.pdf)<!-- --> 

Se observa que para todos los rangos etarios los hombres tienen una carga laboral superior a las mujeres, dándose las brechas más grandes para las personas de 35 a 44 años.

Por último, la tasa de empleo en la Ciudad de Corrientes para el trimestre en cuestión asciende 41.29%, esta tasa se calcula como el cociente entre el total de ocupados y la población total de referencia. Por su parte, la tasa de desocupación, que se calcula como el cociente entre desocupados y la Población Económicamente Activa (PEA), es del 4.29%.






![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-22-1.pdf)<!-- --> 

\newpage
\textcolor{graycustom}{\Large Empleo público y privado}
\newline

Del total de empleados de la ciudad, el porcentaje de empleados públicos es de 18.87% siendo 81.13% trabajadores pertenecientes al sector privado.




![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-24-1.pdf)<!-- --> 

En el sector público, el promedio de edad de los trabajadores es de 44 años, mientras que en el sector privado es de 39, trabajando 31 y 35 horas semanales en promedio en el sector público y privado, respectivamente. A su vez, el Estado cuenta con una calificación laboral del 54.06%, mientras que el sector privado, tan solo del 19.72%.

Por otro lado, el sector público se compone de una participación de 56.57% mujeres y 43.43% hombres. Mientras que, en el sector privado, el porcentaje de hombres llega al 60.89%.















\newline
\newline
**Gráfico 7**
\newline
![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-30-1.pdf)<!-- --> 

En términos de la composición por sectores en el empleo público (Gráfico 9), la "Administración Pública" cuenta con la mayor participación laboral, ocupando un 49.40% del total de empleos públicos, seguida por la "Enseñanza" en todos sus niveles, con un 28.82% del total de empleos y en tercer lugar el rubro de la "Salud", con un 13.95% de la participación.




![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-32-1.pdf)<!-- --> 
\newpage
\textcolor{graycustom}{\Large Tasas de informalidad laboral}

Para el análisis del trabajo no registrado, se construye una tasa de informalidad que relaciona la cantidad de personas que poseen un empleo en relación de dependencia, pero no perciben aportes jubilatorios por el mismo. En la tabla y el gráfico siguiente se presenta información relacionada a la población que trabaja de manera informal desagregada tanto por edad como por sexo:








\begin{table}

\caption{\label{tab:unnamed-chunk-36}Informalidad laboral por sexo y edad}
\centering
\fontsize{9}{11}\selectfont
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{18em}>{\raggedleft\arraybackslash}p{14em}>{\raggedleft\arraybackslash}p{14em}}

\begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Edad}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Hombres}}}\endgroup & \begingroup\fontsize{12}{14}\selectfont \cellcolor[HTML]{29aee4}{\textcolor{white}{\textbf{Mujeres}}}\endgroup\\
\midrule
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{15-24 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{82.38\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{82.52\%}}\\
25-34 años & 60.73\% & 67.61\%\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{35-44 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{38.61\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{47.36\%}}\\
45-59 años & 40.68\% & 29.09\%\\
\cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{+60 años}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{33.71\%}} & \cellcolor[HTML]{F0FFFF}{\cellcolor{gray!6}{39.61\%}}\\

\end{tabular}
\end{table}

![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-37-1.pdf)<!-- --> 





![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-39-1.pdf)<!-- --> 



![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-40-1.pdf)<!-- --> 

Al analizar la informalidad laboral por sector de actividad, los menores valores se encuentran en el sector de enseñanza (8.54%); el sector de administración pública y defensa, planes de seguro social obligatorio (18.43%);suministro de Agua, alcantarillado, gestión de desechos y actividades de saneamiento (28.97%) transporte y almacenamiento (35.25%) y por último salud humana y servicios sociales (36.95%) . Por otro lado, los valores más altos están en el sector de suministro de gas, vapor y aire acondicionado; construcción; personal doméstico y actividades para consumo propio; otras actividades de servicio; y actividades inmobiliarias. 

\newpage
\textcolor{graycustom}{\Large Tasas de calificación laboral}
\newline

En la EPH se clasifica a los empleados en cuatro categorías: profesionales, técnicos, operarios y trabajadores no calificados. A efectos de este análisis se consideran calificados a los profesionales o técnicos, mientras que a los no calificados se le suman los operarios para determinar la categoría final de no calificados.






Del total de la población de la ciudad, solo el 26.09% son calificados, mientras que el 73.91% restante son no calificados. Del total de los hombres, el 23.38% son calificados, mientras que del total de las mujeres el porcentaje de calificación es del 30.00%.





![](Informe-Mercado-Laboral_files/figure-latex/unnamed-chunk-44-1.pdf)<!-- --> 


Al analizar la calificación laboral por sector de actividad para este trimestre los valores más altos están en los rubros de enseñanza (83.50%); profesionales, científicos y técnicos (79.50%); salud humana y servicios sociales(73.50%); información y comunicación (73.47%) y arte, entretenimiento y recreación (54.87).

#Agosto, 2013. Nadro.

#PD: Hay que decir que las predicciones son de mentis, que la idea es que se puedan tener distintos modelos
#y que se tunnen con distintos parámetros

#En la misma carpeta donde estén los archivos ui.R y server.R debe estar muestra_nadro2.csv
#(o, para esa iteración de la aplicación, el base_simulada.csv)
#para evitar problemas y hay que sustituir el path a esa carpeta en setwd y runApp acá abajo: 

# Datos_market tbn hay que agregarla al directorio


setwd("/Users/PandoraMac/Documents/Nadro/nadro/")
#install.packages("shiny")
install.packages("forecast")
install.packages("arules")
install.packages("arulesViz")
library(shiny)
runApp("/Users/PandoraMac/Documents/Nadro/nadro/")


#Esto no hay que correrlo, pero lo dejo por si uno quiere correr cosas en R aparte de la App para verificar o 
#probar formatos, antes de mandarlo a la App de Shiny

library(ggplot2)
s<-as.data.frame(read.csv("/Users/PandoraMac/Documents/Nadro/base_simulada2.csv",sep=','),header=TRUE,
                 colClasses=c("character","character","character","character","character",
                              "double","double","double","double","double","double"))


datos<-function(){s}
meses<-substr(datos()$dia,4,5)
anios<-substr(datos()$dia,7,10)
dias<-datos()$dia2
#Por meses
pre.agg1<-aggregate(datos()[,c(6:11)],list(FactorA=meses,FactorB=anios),sum)
agg1<-cbind(pre.agg1[,c(1:2)],round(pre.agg1[,c(3:8)]/1000000,2))
#Por días
agg2<-aggregate(datos()[,c(6:11)],list(FactorA=anios,FactorB=substr(datos()$dia,1,5)),sum)


#http://stackoverflow.com/questions/13592225/how-can-i-pass-data-between-functions-in-a-shiny-app
#http://stackoverflow.com/questions/17204735/shiny-chart-space-allocation

#Para opciones en los filtros que dependen de otro filtro...
#https://github.com/wch/testapp/blob/master/setinput/ui.R
#https://github.com/wch/testapp/blob/master/setinput/server.R
#http://glimmer.rstudio.com/winstontest/setinput/

#Para análisis de series de tiempo
#http://a-little-book-of-r-for-time-series.readthedocs.org/en/latest/src/timeseries.html
#http://cran.r-project.org/web/views/TimeSeries.html
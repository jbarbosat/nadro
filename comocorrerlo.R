#Agosto, 2013. Nadro.

#En la misma carpeta donde estén los archivos ui.R y server.R debe estar muestra_nadro2.csv
#(o, para esa iteración de la aplicación, el base_simulada.csv)
#para evitar problemas y hay que sustituir el path a esa carpeta en setwd y runApp acá abajo: 

setwd("/Users/PandoraMac/Documents/Nadro/Shiny/")
#install.packages("shiny")
library(shiny)
runApp("/Users/PandoraMac/Documents/Nadro/Shiny/")


#Esto no hay que correrlo, pero lo dejo por si uno quiere correr cosas en R aparte de la App para verificar o 
#probar formatos, antes de mandarlo a la App de Shiny

library(ggplot2)
s<-as.data.frame(read.csv("base_simulada.csv",sep=','),header=TRUE,
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

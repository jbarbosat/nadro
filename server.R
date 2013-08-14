library(shiny)
library(ggplot2)
library(forecast)
library(arules)
library(arulesViz)
##################################################################################################  
#Leemos los datos
s<-as.data.frame(read.csv("/Users/PandoraMac/Documents/Nadro/base_simulada2.csv",sep=','),header=TRUE,
                           colClasses=c("character","character","character","character","character",
                                        "double","double","double","double","double","double"))

# s<-as.data.frame(read.csv("base_simulada2.csv",sep=','),header=TRUE,
#                  colClasses=c("character","character","character","character","character",
#                               "double","double","double","double","double","double"))

shinyServer(function(input, output, clientData, session) {
  
  observe({
    
  
  ##################################################################################################  
  #Leemos e interpretamos las variables que nos van a servir para filtrar 
  #Como ahorita estamos trabajando con una base simulada, hay cosas comentadas. 
  #Ya que estemos en la base verdera, habrá que tener catálogos de las cosas.
  #Uno pone en las opciones "Abarrotes" pero en la base
  #aparece como "A", así que es necesario.
  #--------------------------------------------------------------------------------------------------  
  #Sectores. #Si eligieron uno, suistituiremos el nombre x la letra q aparece en la base. Cat_GpoClientes.xls
  #Además, el sector determina las opciones que aparecen en cliente.
  
  Sector<-sprintf(reactive({input$isector})())
  #   if (Sector!="Todo"){
  #     cat_sectores<-read.csv("cat_sectores.csv") #columnas = idsector y sector
  #     Sector<-cat_sectores[grep(Sector,cat_sectores[,2]),1]
  #   }
  
  if(Sector=="Todos")
    tablaClientes<-as.character(s$cliente)
  else
    tablaClientes<-as.character(s$cliente[s$sector==Sector])
  
  clientesValidos<-unique(tablaClientes)
  #default<-sprintf(reactive({input$cliente})())
  updateSelectInput(session, inputId="cliente", 
                    choices = c("Todos",clientesValidos),
                    selected="Todos")
  
  #--------------------------------------------------------------------------------------------------  
  #Cliente. #Si eligieron uno, sustituimos el nombre x el número de id q aparece en la base. Cat_Cadena.xls
  Cliente<-sprintf(reactive({input$cliente})())
  #   if (Cliente!="Todo"){
  #     clientes<-cbind(c("4002713","4000008","4000105","4000010","4000003"),
  #                     c("CONTROLADORA DE FARMACIAS S.A.P.I.","NUEVA WAL MART DE MEXICO S DE RL DE","KLYN'S FARMACIAS SA DE CV",
  #                       "SUPERMERCADOS INTNALES H.E.B. SA DE","TIENDAS SORIANA SA DE CV"))
  #     
  #     cliente<-clientes[grep(Cliente,clientes[,2]),1]
  #   }
  #--------------------------------------------------------------------------------------------------  
  #Material. #Si eligieron uno, sustituimos el nombre x el número de id q aparece en la base. Cat_Materiales.xls
  Material<-sprintf(reactive({input$material})())
  #   if (Material!="Todo"){
  #     cat_materiales<-read.csv("cat_materiales.csv") #columnas = idmaterial y material
  #     Material<-cat_materiales[grep(Material,cat_materiales[,2]),1]
  #   }
  
  ##################################################################################################
  #Datos
  #Vamos filtrando los datos, según las opciones de los filtros
  
  datos1<-reactive({s})
  
  datos2<-datos1
  if(Sector!="Todos"){
    datos2<-reactive({datos1()[datos1()$sector==Sector,]})
  }
  datos3<-datos2
  if(Cliente!="Todos"){
    datos3<-reactive({datos2()[datos2()$cliente==Cliente,]})
  }
  datos<-datos3
  if(Material!="Todos"){
    datos<-reactive({datos3()[datos3()$producto==Material,]})
  }
  
  #--------------------------------------------------------------------------------------------------  
  #Datos 2
  #Vamos a crear de una vez una tabla con agregados y con cosas en el tiempo para de ahí sacar las columnas y plottear felizmente
  
  meses<-substr(datos()$dia,4,5)
  anios<-substr(datos()$dia,7,10)
  dias<-datos()$dia2
  #Por meses
  pre.agg1<-aggregate(datos()[,c(6:11)],list(FactorA=meses,FactorB=anios),sum)
  agg1<-cbind(pre.agg1[,c(1:2)],round(pre.agg1[,c(3:8)]/1000000,2))
  #Por días
  agg2<-aggregate(datos()[,c(6:11)],list(FactorA=anios,FactorB=substr(datos()$dia,1,5)),sum)
  #agg3<-aggregate(datos()[,c(6:11)],list(FactorA=anios,FactorB=datos()$dia),sum)
  ##################################################################################################  
  #Graficas y Outputs
  #ventas
    v.columna<-5 #de agg1
    v.pre.tabla1 <- reshape(agg1[,c(1,2,v.columna)], idvar = "FactorB", timevar = "FactorA", direction = "wide")
    v.indices<-order(names(v.pre.tabla1))
    v.tabla<-v.pre.tabla1[,v.indices]
    #tabla<-cbind(pre.tabla2[,1],round(pre.tabla2[,2:13]/1000000,2))
    names(v.tabla)<-c("Year","Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")
    row.names(v.tabla)<-NULL
  
  output$VentasAggrTabla<-renderTable({ 
    print(v.tabla,justify="center")
  })
  

    #vt.nombres<-paste(c("Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"),rep(c("-11","-12","-13"),each=12),sep="")
    #vt.tabla<-(v.tabla)
    vt.vector<-na.omit(unlist(c(v.tabla[1,-1],v.tabla[2,-1],v.tabla[3,-1])))
    vt.serie<-ts(vt.vector,frequency=12, start=c(2011,1))    
    vt.serieHW<-HoltWinters(vt.serie, beta=FALSE, gamma=FALSE)
    vt.seriePred<-forecast.HoltWinters(vt.serieHW, h=12)
  output$VentasTPlot<-renderPlot({ 
    plot.forecast(vt.seriePred,ylab="VPRS (Millones de pesos)",xlab="Tiempo",main="Datos mensuales y proyecciones",tck=1,col="red",lwd=2)
    
#     vt.columna<-5 #de agg2
#     vt.pre.tabla1 <- reshape(agg2[,c(1,2,vt.columna)], idvar = "FactorB", timevar = "FactorA", direction = "wide")
#     vt.pre.tabla2<-vt.pre.tabla1[order(substr(vt.pre.tabla1[,1],4,5)),]
#     vt.indices<-order(names(vt.pre.tabla2))
#     vt.tabla<-vt.pre.tabla2[,vt.indices]
#     #tabla<-cbind(Fecha=pre.tabla3[,1],pre.tabla3[,2:4]/1000000)
#
# #Primera gráfica fea que hice    
# #     plot(vt.tabla[,2],xlab="Tiempo", #ylim=c(min(na.exclude(tabla)),max(na.exclude(tabla))),
# #          ylab="Precios", type="l",xaxt="n",tck = 1)
# #     mtext(text=paste(c("2011","2012","2013")), side=3, 
# #         at=c(100,180,260),
# #         col=c("black","red","blue"),cex=1.5)
# #     axis(side=1,at=seq(1,366,by=10),labels=(vt.tabla$FactorB[seq(1,366,by=10)]),cex.axis=0.8, las=2)
# #     lines(vt.tabla[,3],col="red")
# #     lines(vt.tabla[,4],col="blue")
# #     
# 
# #GGplot, que no quedó muy bien
#     fecha<-rep(vt.tabla[1:300,1],3)
#     anio<-rep(c("2011","2012","2013"),each=length(fecha)/3)
#     valor<-c(vt.tabla[1:300,2],vt.tabla[1:300,3],vt.tabla[1:300,4])
#     
#     #valor2<-runif(3*length(fecha))
#     #valor2[seq(5,90,by=5)]<-"NA"
#     prueba<-as.data.frame(cbind(fecha,anio,valor))
#     #id = seq_along(anio)
#     plot(ggplot(prueba, aes(x=as.numeric(rep(1:300,3)), y=as.vector(valor),group=anio,colour=anio))+geom_line())
#          #+scale_y_continuous(breaks = as.character(round(seq(as.double(min(as.vector(prueba$valor),na.rm=TRUE)), as.double(max(as.vector(prueba$valor),na.rm=TRUE)), length.out=10),1))))
# 
#                                #c("1288995.0", "1336383.0", "1383771.0", "1431160.0", "1478548.0", "1525936.0", "1573324.0", "1620713.0", "1668101.0", "1715489.0")))
#     #qplot(rep(1:30,3), as.vector(valor2), data=prueba, group=anio, geom="line")
#     
#      
  })
  
  output$Prueba1 <- renderPrint({
    print(reactive({input$cliente})())
  })
  
  ##################################################################################################  
  #Graficas y Outputs
  #Costos
  
  c.columna<-c(7,8)
  c.pre.tabla2 <- reshape(agg1[,c(1,2,c.columna)], idvar = "FactorA", timevar = "FactorB", direction = "wide")
  c.pre.tabla3<-(t(c.pre.tabla2))
  c.indices<-as.numeric(c.pre.tabla2[,1])
  c.tabla<-c.pre.tabla3[-1,c.indices]
  c.Year<-row.names(c.tabla)
  c.tabla<-(cbind(c.Year,c.tabla))
  dimnames(c.tabla)[[2]]<-c("Year","Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")
  #tabla$Mes<-c("Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")
  #dimnames(c.tabla)[[1]]<-NULL
  
  output$CostosAggrTabla<-renderTable({ 
    print(c.tabla[,-1],justify="center")
  })
  
  output$CostosM1Plot<-renderPlot({ 
    cm1.vector<-as.double(na.omit(unlist(c(c.tabla[1,-1],c.tabla[3,-1],c.tabla[5,-1]))))
    cm1.serie<-ts(cm1.vector,frequency=12, start=c(2011,1))    
    cm1.serieHW<-HoltWinters(cm1.serie, beta=FALSE, gamma=FALSE)
    cm1.seriePred<-forecast.HoltWinters(cm1.serieHW, h=12)
    plot.forecast(cm1.seriePred,ylab="VPR1 (Millones de pesos)",xlab="Tiempo",main="VPR1 - Datos mensuales y proyecciones",tck=1,col="red",lwd=2)
  })  
  
  

    cm2.vector<-as.double(na.omit(unlist(c(c.tabla[2,-1],c.tabla[4,-1],c.tabla[6,-1]))))
    cm2.serie<-ts(cm2.vector,frequency=12, start=c(2011,1))    
    cm2.serieHW<-HoltWinters(cm2.serie, beta=FALSE, gamma=FALSE)
    cm2.seriePred<-forecast.HoltWinters(cm2.serieHW, h=12)
  
  output$CostosM2Plot<-renderPlot({ 
    plot.forecast(cm2.seriePred,ylab="VPR2 (Millones de pesos)",xlab="Tiempo",main="VPR2 - Datos mensuales y proyecciones",tck=1,col="red",lwd=2)
  })  
  
  
  
  output$CostosHPlot<-renderPlot({ 
    costos<-rowSums(matrix(as.numeric(as.matrix(c.tabla[,-1])),nrow=6,ncol=12),na.rm=TRUE)
    variables<-as.data.frame(matrix(unlist(strsplit(as.character(c.tabla[,1]),".",fixed=TRUE)),nrow=6,ncol=2,byrow=TRUE))
    c.tabla.hist<-as.data.frame(cbind(variables,as.numeric(costos)))
    c.tabla.hist<-(cbind(variables,costos))
    plot(ggplot(c.tabla.hist, aes(x = V1, y=costos)) + geom_bar(position="dodge",stat="identity",width=.5)  + facet_wrap( ~V2) + xlab("")+ ylab("Costos"))
  })
  
  
  ct.columna<-c(7,8) #de agg2
  ct.pre.tabla1 <- reshape(agg2[,c(1,2,ct.columna)], idvar = "FactorB", timevar = "FactorA", direction = "wide")
  ct.pre.tabla2<-ct.pre.tabla1[order(substr(ct.pre.tabla1[,1],4,5)),]
  ct.indices<-order(names(ct.pre.tabla2))
  ct.tabla<-ct.pre.tabla2[,ct.indices]
  #tabla<-cbind(Fecha=pre.tabla3[,1],pre.tabla3[,2:4]/1000000)
  
  output$Costos1TPlot<-renderPlot({ 
    plot(ct.tabla[,2],xlab="Tiempo", ylim=c(min(ct.tabla[,c(2:4)],na.rm=TRUE),max(ct.tabla[,c(2:4)],na.rm=TRUE)),
         ylab="VPR1", type="l",xaxt="n",main="VPR1",tck = 1)
    mtext(text=paste(c("2011","2012","2013")), side=3, 
          at=c(100,180,260),
          col=c("black","red","blue"),cex=1.5)
    axis(side=1,at=seq(1,366,by=10),labels=(ct.tabla$FactorB[seq(1,366,by=10)]),cex.axis=0.8, las=2)
    lines(ct.tabla[,3],col="red")
    lines(ct.tabla[,4],col="blue")
  })
  
  output$Costos2TPlot<-renderPlot({ 
    plot(ct.tabla[,5],xlab="Tiempo", ylim=c(min(ct.tabla[,c(5:7)],na.rm=TRUE),max(ct.tabla[,c(5:7)],na.rm=TRUE)),
         ylab="VPR2", type="l",xaxt="n",main="VPR2",tck = 1)
    mtext(text=paste(c("2011","2012","2013")), side=3, 
          at=c(100,180,260),
          col=c("black","red","blue"),cex=1.5)
    axis(side=1,at=seq(1,366,by=10),labels=(ct.tabla$FactorB[seq(1,366,by=10)]),cex.axis=0.8, las=2)
    lines(ct.tabla[,6],col="red")
    lines(ct.tabla[,7],col="blue")
  })
  
  #VPR1 y 2 para 2013
  output$CostosTPlot<-renderPlot({ 
    plot(ct.tabla[,7],xlab="Tiempo", ylim=c(min(ct.tabla[,c(4,7)],na.rm=TRUE),max(ct.tabla[,c(4,7)],na.rm=TRUE)),
         ylab="Costos", type="l",xaxt="n",tck = 1)
    mtext(text=paste(c("VPR1 2013","VPR2 2013")), side=3, 
          at=c(140,220),
          col=c("black","red"),cex=1.5)
    axis(side=1,at=seq(1,366,by=10),labels=(ct.tabla$FactorB[seq(1,366,by=10)]),cex.axis=0.8, las=2)
    lines(ct.tabla[,4],col="red")
  })
  
  
  output$Prueba2 <- renderPrint({
    print(reactive({input$cliente})())
  })
  
  ##################################################################################################  
  #Graficas y Outputs
  #Descuentos
  #13    ZDFI -606438.55  SD Ds Financiero
  #24    ZPG5  -97403.57  SDPromoNad Gral Fact
  
  output$DescAggrTabla<-renderTable({ 
    columna<-c(3,4)
    pre.tabla2 <- reshape(agg1[,c(1,2,columna)], idvar = "FactorA", timevar = "FactorB", direction = "wide")
    pre.tabla3<-as.data.frame(t(pre.tabla2))
    indices<-as.numeric(pre.tabla2[,1])
    tabla<-pre.tabla3[-1,indices]
    Year<-row.names(tabla)
    tabla<-cbind(Year,tabla)
    names(tabla)<-c("Year","Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")
    #tabla$Mes<-c("Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")
    row.names(tabla)<-NULL
    print(tabla,justify="center")
  })
  
  columna0<-c(3,4) #de agg2
  pre.tabla10 <- reshape(agg2[,c(1,2,columna0)], idvar = "FactorB", timevar = "FactorA", direction = "wide")
  pre.tabla20<-pre.tabla10[order(substr(pre.tabla10[,1],4,5)),]
  indices0<-order(names(pre.tabla20))
  tabla0<-pre.tabla20[,indices0]
  #tabla<-cbind(Fecha=pre.tabla3[,1],pre.tabla3[,2:4]/1000000)
  

    dm1.vector<-as.double(na.omit(unlist(c(tabla0[1,-1],tabla0[3,-1],tabla0[5,-1]))))/1000
    dm1.serie<-ts(dm1.vector,frequency=12, start=c(2011,1))    
    dm1.serieHW<-HoltWinters(dm1.serie, beta=FALSE, gamma=FALSE)
    dm1.seriePred<-forecast.HoltWinters(dm1.serieHW, h=12)
  
  output$DescM1Plot<-renderPlot({ 
    plot.forecast(dm1.seriePred,ylab="ZDFI (Millones de pesos)",xlab="Tiempo",main="ZDFI - Datos mensuales y proyecciones",tck=1,col="red",lwd=2)
  })  
  
  
  output$DescM2Plot<-renderPlot({ 
    dm2.vector<-as.double(na.omit(unlist(c(tabla0[2,-1],tabla0[4,-1],tabla0[6,-1]))))/1000
    dm2.serie<-ts(dm2.vector,frequency=12, start=c(2011,1))    
    dm2.serieHW<-HoltWinters(dm2.serie, beta=FALSE, gamma=FALSE)
    dm2.seriePred<-forecast.HoltWinters(dm2.serieHW, h=12)
    plot.forecast(dm2.seriePred,ylab="ZPG5 (Millones de pesos)",xlab="Tiempo",main="ZPG5 - Datos mensuales y proyecciones",tck=1,col="red",lwd=2)
  })  
  
  
  
  output$Desc1TPlot<-renderPlot({ 
    plot(tabla0[,2],xlab="Tiempo", ylim=c(min(tabla0[,c(2:4)],na.rm=TRUE),max(tabla0[,c(2:4)],na.rm=TRUE)),
         ylab="ZDFI", type="l",xaxt="n",main="ZDFI",tck = 1)
    mtext(text=paste(c("2011","2012","2013")), side=3, 
          at=c(100,180,260),
          col=c("black","red","blue"),cex=1.5)
    axis(side=1,at=seq(1,366,by=10),labels=(tabla0$FactorB[seq(1,366,by=10)]),cex.axis=0.8, las=2)
    lines(tabla0[,3],col="red")
    lines(tabla0[,4],col="blue")
  })
  
  output$Desc2TPlot<-renderPlot({ 
    plot(tabla0[,5],xlab="Tiempo", ylim=c(min(tabla0[,c(5:7)],na.rm=TRUE),max(tabla0[,c(5:7)],na.rm=TRUE)),
         ylab="ZPG5", type="l",xaxt="n",main="ZPG5",tck = 1)
    mtext(text=paste(c("2011","2012","2013")), side=3, 
          at=c(100,180,260),
          col=c("black","red","blue"),cex=1.5)
    axis(side=1,at=seq(1,366,by=10),labels=(tabla0$FactorB[seq(1,366,by=10)]),cex.axis=0.8, las=2)
    lines(tabla0[,6],col="red")
    lines(tabla0[,7],col="blue")
  })
  
  #ZDFI y ZPG5 para 2013
  output$DescTPlot<-renderPlot({ 
    plot(tabla0[,7],xlab="Tiempo", ylim=c(min(tabla0[,c(4,7)],na.rm=TRUE),max(tabla0[,c(4,7)],na.rm=TRUE)),
         ylab="Descuentos", type="l",xaxt="n",tck = 1)
    mtext(text=paste(c("ZDFI 2013","ZPG5 2013")), side=3, 
          at=c(140,220),
          col=c("black","red"),cex=1.5)
    axis(side=1,at=seq(1,366,by=10),labels=(tabla0$FactorB[seq(1,366,by=10)]),cex.axis=0.8, las=2)
    lines(tabla0[,4],col="red")
  })
  
  
  output$Prueba3 <- renderPrint({
    print(reactive({input$cliente})())
  })
  
  ##################################################################################################  
  #Graficas y Outputs
  #Ventas, costos
  
  output$VCPlot<-renderPlot({
    ts.plot(vt.serie,cm2.serie,gpars=list(tck=1),col=c("red","blue"),lwd=2,xlab="Tiempo")
    mtext(text=c("Ventas(VPRS)","Costo Cedido (VPR1)"), side=3, 
          at=c(2011.5,2012.5),
          col=c("red","blue"),cex=1.5)
  })
  
  output$RentPlot<-renderPlot({
    ts.plot(vt.serie/cm2.serie,gpars=list(tck=1),col=c("red"),lwd=2,ymin=.9,main="Ventas/Costo Cedido",ylab="Tiempo")
    abline(h=1,lwd=2)
  })
  
  
  output$Prueba4 <- renderPrint({
    print(reactive({input$cliente})())
  })
  
  
  ##################################################################################################  
  #Market basket
  #Filtré e hice cosas. Escribí en un csv el resultado pa no tener que volver a calcular
  #pero de todos modos alentó todo, así que mejor guardé un objeto con las últimas reglas que necesito y load.
  
# #   datosoriginales<-as.data.frame(read.csv("/Users/PandoraMac/Documents/Nadro/Datos/muestra_nadro2.csv",sep=','),header=FALSE,as.is = TRUE)
# #   #Filtré ventas que sí tengan importe
# #   datosSub<-subset(datosoriginales,(V33=="VPRS" & V1.1!="NA"))
# # #   #Cruzamos facturas con ventas!=0 y clientes, para ver cuántos artículos tiene cada factura.
# # #   vector<-as.vector(table(datosSub[,12],datosSub[,30]))
# # #   vector2<-vector[vector!=0]
# # #   hist(vector2)
# # #   vector3<-vector2[vector2==20]
# # #   hist(vector3)
# #   
# #   #aggregate por el importe total de ventas de las facturas.
# #   agg4<-aggregate(datosSub[,36],list(FactorA=datosSub[,30]),sum)
# #   agg5<-agg4[order(agg4$x,decreasing=TRUE),]
# #   #Elegimos las primeras 20, arbitrariamente. De 178k a 25k pesos.
# #   head(agg5,20)
# #   #Ahora un subset de datosSub para sacar los 20 tickets.
# #   pre.datos.market<-subset(datosSub, (V30==agg5$FactorA[1] |V30==agg5$FactorA[2] |V30==agg5$FactorA[3]
# #                                 |V30==agg5$FactorA[4] |V30==agg5$FactorA[5] |V30==agg5$FactorA[6]
# #                                 |V30==agg5$FactorA[7] |V30==agg5$FactorA[8] |V30==agg5$FactorA[9]
# #                                 |V30==agg5$FactorA[10] |V30==agg5$FactorA[11] |V30==agg5$FactorA[12]
# #                                 |V30==agg5$FactorA[13] |V30==agg5$FactorA[14] |V30==agg5$FactorA[15]
# #                                 |V30==agg5$FactorA[16] |V30==agg5$FactorA[17] |V30==agg5$FactorA[18]
# #                                      |V30==agg5$FactorA[19] |V30==agg5$FactorA[20]) )
# #   head(pre.datos.market)
# #   datos.market<-as.data.frame(pre.datos.market[,c(30,23)])
# #   names(datos.market)<-c("Factura","Material")
# #   head(datos.market)
# #   write.csv(datos.market,"datos_market.csv",row.names=FALSE)
#   
#   datos.market<-read.csv("/Users/PandoraMac/Documents/Nadro/datos_market.csv")
#   #head(datos.market)
#   datos.market[,1]<-as.factor(datos.market[,1])
#   datos.market[,2]<-as.factor(datos.market[,2])
#   datos.market<-unique(datos.market)
#   
#   #datos.market2<-read.csv("datos_market2.csv")
#   datos.trans<-as(split(datos.market[,2], datos.market[,1]), "transactions")
#   inspect(datos.trans[1:5])
#   #Distintas combinaciones de soporte y longitudes
#   freq.itemsets <- apriori(datos.trans, parameter = list(supp = 0.15,maxlen = 6,
#                                                          target = "frequent itemsets"))
#   freq.itemsets
#   # len 6 supp .07  13949919
#   #len 6 supp .15 216201
#   freq.itemsets.sort <-sort(freq.itemsets, by = "support")
#   inspect(freq.itemsets.sort[1:10]) #son artículos solitos
#   
#   reglas.1 <- apriori(datos.trans, parameter = list(supp = 0.15, maxlen=6,
#                                                   target = "rules", ext=TRUE))
#   reglas.1
#   #soporte del antecedente big
#   reglas.2 <- subset(reglas.1, lhs.support > 0.25)
#   reglas.2
#   reglas.3 <- subset(reglas.2, lift > 3)
#   reglas.3
#   reglas.4 <- sort(reglas.3, by = "lift")
#  save(file="MarketBasket.RData",reglas.4)
  
  load("MarketBasket.RData")
  
  output$Reglas<-renderPlot({
    par(mar = c(0, 0, 0, 0))
    plot(reglas.4[1:10], method = "graph", control = list(type = "items",main="Top 10 Reglas"))    
  })
  
  output$IdMatMB<-renderTable({
    ids<-c( 1408,  1441,  2127  ,2164 , 6079 , 6091  ,7357,  7388  ,7443 , 9592, 10489, 11400, 14685, 15761)
    nombres<-c("BAYRO 10 G CRA 40 G",
              "ACTRON-400 400 MG CAPS 30",
              "RIOPAN GEL 10 ML SB 20",
              "TECTA 40 MG TAB 14 CAPAENTER 171",
              "TYLEX 750 MG TAB 20",
              "EVRA 6MG/600MCG PARCHES 3",
              "EUTIROX 100 MG TAB 50",
              "EUTIROX 25 MCG TAB 50",
              "GAVINDO TAB 30",
              "JANUMET 50/850MG CPR56 RECUB",
              "DOLAC 10 MG TAB 10",
              "TAPAZOL 5 MG TAB 20",
              "METAMIZOL 5G/100ML JBE 120ML",
              "DOLO-NEUROBION FORTE DC1X3ML"
      )
    info<-c("Antiinflamatorio, analgésico",
            "Antiinflamatorio, analgésico",
            "Antiácido",
            "Antiulceroso",
            "Analgesico y antipiretico",
            "Anticonceptivo",
            "Hormona tiroidea T-4 (L-tiroxina)",
            "Hormona tiroidea T-4 (L-tiroxina)",
            "Complejo B",
            "Tratamiendo de diabetes mellitus tipo 2",
            "Analgésico",
            "Hipertiroidismo",
            "Antipirético",
            "Antiinflamatorio, analgésico"
       )
    mb.tabla<-cbind(ids,nombres,info)
    print(mb.tabla,justify="center") 
  })
  
  output$Prueba6 <- renderPrint({
    print(reactive({input$cliente})())
  })
  
  ##################################################################################################  
  #Tops
  
  #Top Productos
  output$TopProducto<-renderPlot({
    producto<-c(24,23,20, 19,18,15,10,9,8,7)
    barplot(producto, main="Top 10 Productos", horiz=TRUE,
            col=gray(0:10/10),, names.arg=c("LACTACYD","VARTALON","ASPIRINA-PROTEC","CELEBREX ","DOLO-NEUROBION FORTE", "EVRA","CIALIS","ULSEN","KRYTANTEK","MICARDIS PLUS"), cex.names=0.7,las=1,xlim=c(0,25))
  })
  
  #Top clientes
  output$TopCliente<-renderPlot({
    sucursales<-c(48,40,39,38,35,30,22,20,15,11)
    #(palette(blue(seq(0,.9,len=10))))
    barplot(sucursales, main="Top 10 Clientes", horiz=TRUE, 
            col=gray(0:10/10),
            names.arg=c("NUEVA WALMART","TIENDAS SORIANA","SUPER ISSSTE","TIENDAS CHEDRAHUI","PETROLEOS MEXICANO", "AXA SALUD","COSTCO","SUPERAMA","PEPSICO","SPORT CITY"), cex.names=0.7,las=1,xlim=c(0,50))
  })  
  
  #Top sector
  output$TopSector<-renderPlot({
    sector<-c(30,40,10,45,35,30,60,20,15,60,95,70,53,68,80,78,60,20)
    barplot(sector, main="Ventas por Sector", col=gray(0:18/18),
            horiz=TRUE, names.arg=c("INDUSTRIA","COMERCIO","ABARROTES","COMERCIAL","EXCLUSIVO", "FARMARED","GOBIERNO","HOSPITAL","INSTITUCIONAL","GENERICOS INTER","MAYOR","NADROLOGISTICA","POTENCIAL","SUBROGADOS","SANATORIOS","INTERCOMPAÑIA","PROVEEDORES","OTROS"), cex.names=0.5,las=1,xlim=c(0,100))
  })
  
 output$DescTopCl<-renderPlot({
    ####GRÀFICA DE PUNTOS-RADIOS PARA CONOCER QUE TANTO DESCUENTO ESTÀN APLICANDO EN POR VENTAS EN EL TOP 10 DE SUCURSALES ########
    dfx <-data.frame(ev1=1:10, ev2=sample(10:99, 10), ev3=10:1)
    symbols(x=dfx$ev1, y=dfx$ev2, circles=dfx$ev3, inches=1/3, main="Descuentos vs Ventas",ylab="Ventas (MDP)", xlab=NA, bg=rainbow(5), fg=NULL,lwd.ticks=2, col.ticks = "blue", xaxt = 'n',cex.axis=.8, )
    axis(1, at=1:10, labels=c("NUEVA WALMART","TIENDAS SORIANA","SUPER ISSSTE","TIENDAS CHEDRAHUI","PEMEX", "AXA SALUD","COSTCO","SUPERAMA","PEPSICO","SPORT CITY"),cex.axis=.6,las=2)
 })
  
  ##################################################################################################  

  })
    
})


% 21-oct-2013
% Cálculo de inventarios y ventas para clientes agrupados por tipo para la zona norte de pepsi y 3 productos
% Makefile: pandoc -s -V geometry:margin=0.7in -V lang=spanish 3_inventariosyventas.md -o InventariosVentas.pdf

Después de filtrar en el exploratorio los sku's colados y después de hacer en seriesdetiempo 
las agrupaciones por semana y tipo de cliente, en este archivo ahora se trata de producir 
un archivo con las ventas y devoluciones promedio de cada tipo de cliente y de cada fecha. 
Después, con estos promedios, calcularemos inventarios y ventas a consumidores finales.

**NOTA IMPORTANTE 1:** Para calcular los inventarios de los clientes (tienditas) y sus ventas a los
consumidores (gente que compra papas en las tienditas), estamos tomando valor absoluto de ventas y 
devoluciones porque hay valores negativos. Suponemos que tiene que ver con promociones en las que la
gente llega al OXXO y canjea un cupón de "papitas gratis". No nos importa distinguir entre papas 
consumidas y pagadas y papas consumidas y gratis porque al final es demanda de papas. Quizá tenga más
sentido omitir los valores negativos, pero a mí me late que no.

**NOTA IMPORTANTE 2:** Sumamos las cosas por semana y por cliente y luego promediamos por tipo y por
semana.


Churrumais
--------------------------------------------------------------------------------------------------


```r
setwd("/Users/PandoraMac/Documents/David/pepsi2/Datos Norte 3 papitas/")
nombres<-c("tipo_cliente","anio_semana","vta_din2","vta_uni2","dev_din2","dev_uni2")
s<-as.data.frame(read.table("churrumais3.dat", sep="|",header=FALSE,
                 colClasses=c(rep("character",2),rep("numeric",4))))
s[,2]<-paste(substr(s[,2],4,8),"-",substr(s[,2],1,2),sep="")
names(s)<-nombres
s2<-s[order(s$anio_semana),]
datos<-subset(s2,s2$tipo_cliente!="")
datos$tipo_cliente[datos$tipo_cliente=="CINE / TEATRO"]<-"CINE_TEATRO"
datos$tipo_cliente[datos$tipo_cliente=="LONCHERIA / FOND"]<-"LONCHERIA_FONDA"
length(table(datos$tipo_cliente))
[1] 89

head(datos)
          tipo_cliente anio_semana vta_din2 vta_uni2   dev_din2   dev_uni2
7062                 1     2011-52  13.4800   4.0000 0.00000000 0.00000000
7063         ABARROTES     2011-52  22.5336   6.6891 0.04035095 0.01197358
7064               BAR     2011-52  25.2750   7.5000 0.00000000 0.00000000
7065           BODEGAS     2011-52  23.2530   6.9000 0.00000000 0.00000000
7066 CASETA TELEFONICA     2011-52   6.7400   2.0000 0.00000000 0.00000000
7067   CENTRO DEPORTIV     2011-52  18.5350   5.5000 0.00000000 0.00000000

myfunction<-function(x){
  png(file = paste("/Users/PandoraMac/Documents/David/nadro_pepsi_git/pepsi/Exploratorio datos 2 norte/images/churrumais/venta_dev_",paste(unlist(strsplit(x$tipo_cliente[1]," ")),collapse=""),".png",sep=""),
  width = 5, height = 3, units = "in", res= 800, pointsize = 4)
  ventas<-x[4:nrow(x),4]
  devols<-x[1:(nrow(x)-3),6]
  plot(ts(cbind(ventas+devols,ventas-devols,ventas)),plot.type = c("single"),col=c("red","blue","black"),,xaxt = "n")
  axis(1,at=1:length(ventas),labels=x$anio_semana[4:nrow(x)],las=2,cex=.2)
  title(main=x$tipo_cliente[1],sub="Devoluciones con un lag de 3 semanas")
  dev.off()
}
by(datos,datos$tipo_cliente,myfunction)

```




Fritos
--------------------------------------------------------------------------------------------------


```r
setwd("/Users/PandoraMac/Documents/David/pepsi2/Datos Norte 3 papitas/")
nombres<-c("tipo_cliente","anio_semana","vta_din2","vta_uni2","dev_din2","dev_uni2")
s<-as.data.frame(read.table("fritos3.dat", sep="|",header=FALSE,
                 colClasses=c(rep("character",2),rep("numeric",4))))
s[,2]<-paste(substr(s[,2],4,8),"-",substr(s[,2],1,2),sep="")
names(s)<-nombres
s2<-s[order(s$anio_semana),]
datos<-subset(s2,s2$tipo_cliente!="")
datos$tipo_cliente[datos$tipo_cliente=="CINE / TEATRO"]<-"CINE_TEATRO"
datos$tipo_cliente[datos$tipo_cliente=="LONCHERIA / FOND"]<-"LONCHERIA_FONDA"
length(table(datos$tipo_cliente))
[1] 88

head(datos)
          tipo_cliente anio_semana vta_din2 vta_uni2   dev_din2   dev_uni2
6943                 1     2011-52 20.24000 4.000000 0.00000000 0.00000000
6944         ABARROTES     2011-52 28.82065 5.730893 0.04347686 0.00861141
6945           BODEGAS     2011-52 27.32400 5.400000 0.00000000 0.00000000
6946 CASETA TELEFONICA     2011-52 15.18000 3.000000 0.00000000 0.00000000
6947   CENTRO DEPORTIV     2011-52 20.24000 4.000000 0.00000000 0.00000000
6948   CENTRO RECREATI     2011-52 28.41385 5.615385 0.00000000 0.00000000

myfunction<-function(x){
  png(file = paste("/Users/PandoraMac/Documents/David/nadro_pepsi_git/pepsi/Exploratorio datos 2 norte/images/fritos/venta_dev_",paste(unlist(strsplit(x$tipo_cliente[1]," ")),collapse=""),".png",sep=""),
  width = 5, height = 3, units = "in", res= 800, pointsize = 4)
  ventas<-x[4:nrow(x),4]
  devols<-x[1:(nrow(x)-3),6]
  plot(ts(cbind(ventas+devols,ventas-devols,ventas)),plot.type = c("single"),col=c("red","blue","black"),,xaxt = "n")
  axis(1,at=1:length(ventas),labels=x$anio_semana[4:nrow(x)],las=2,cex=.2)
  title(main=x$tipo_cliente[1],sub="Devoluciones con un lag de 3 semanas")
  dev.off()
}
by(datos,datos$tipo_cliente,myfunction)

```




Sabritas
--------------------------------------------------------------------------------------------------


```r
setwd("/Users/PandoraMac/Documents/David/pepsi2/Datos Norte 3 papitas/")
nombres<-c("tipo_cliente","anio_semana","vta_din2","vta_uni2","dev_din2","dev_uni2")
s<-as.data.frame(read.table("papas3.dat", sep="|",header=FALSE,
                 colClasses=c(rep("character",2),rep("numeric",4))))
s[,2]<-paste(substr(s[,2],4,8),"-",substr(s[,2],1,2),sep="")
names(s)<-nombres
s2<-s[order(s$anio_semana),]
datos<-subset(s2,s2$tipo_cliente!="")
datos$tipo_cliente[datos$tipo_cliente=="CINE / TEATRO"]<-"CINE_TEATRO"
datos$tipo_cliente[datos$tipo_cliente=="LONCHERIA / FOND"]<-"LONCHERIA_FONDA"
length(table(datos$tipo_cliente))
[1] 90

head(datos)
          tipo_cliente anio_semana vta_din2  vta_uni2    dev_din2    dev_uni2
7515                 1     2011-52 23.60000  4.000000 0.000000000 0.000000000
7516         ABARROTES     2011-52 48.95558  8.297556 0.002403259 0.000407332
7517         BALNEARIO     2011-52 23.60000  4.000000 0.000000000 0.000000000
7518               BAR     2011-52 62.68750 10.625000 0.000000000 0.000000000
7519           BODEGAS     2011-52 37.58519  6.370370 0.000000000 0.000000000
7520 CASETA TELEFONICA     2011-52 38.35000  6.500000 0.000000000 0.000000000

myfunction<-function(x){
  png(file = paste("/Users/PandoraMac/Documents/David/nadro_pepsi_git/pepsi/Exploratorio datos 2 norte/images/papas/venta_dev_",paste(unlist(strsplit(x$tipo_cliente[1]," ")),collapse=""),".png",sep=""),
  width = 5, height = 3, units = "in", res= 800, pointsize = 4)
  ventas<-x[4:nrow(x),4]
  devols<-x[1:(nrow(x)-3),6]
  plot(ts(cbind(ventas+devols,ventas-devols,ventas)),plot.type = c("single"),col=c("blue","red","black"),,xaxt = "n")
  axis(1,at=1:length(ventas),labels=x$anio_semana[4:nrow(x)],las=2,cex=.2)
  title(main=x$tipo_cliente[1],sub="Devoluciones con un lag de 3 semanas")
  dev.off()
}
by(datos,datos$tipo_cliente,myfunction)
```


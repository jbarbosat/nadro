Jueves Octubre 3,2013
---------------------

Vimos a Felipe. El audio está en el dropbox, porque dijo cosas muy útiles. Tengo que volver a escucharlo
y anotar acá todo. Pero so far lo que recuerdo:

- Felipe propuso un modo de inferir inventarios. Dijo que lo hagamos por 
dos productitos; 5 skus de cada uno. Chance sabritas y fritos porque es probable que en sabritas no haya
mucho que mejorar. 
- No hay que pedir toda la info desde el inicio! Uno o dos años, área metropol. Inferir inventarios, de ahi ver
quién sí tiene papitas de más o de menos y ver wtf. 
- No lo hagamos con todo; no trabajemos de más!
- Análisis por tienda; ya que tengamos bien definido las tiendas que no tienen suficiente o que tienen papitas
de más, ver wtf.
- Pedir primero info de esos skus; luego lo otro. 



Viernes Septiembre 27, 2013
-------------------------------

Mandamos un ppt con el requerimiento de info (miércoles), posible modo de estimación de inventarios, 
estimación del espacio que ocuparán los datos después de pre-procesar (300Gb, which I believe to be 
super small). Nos lo regresar pidiendo que hiciéramos un desmadrín en excel. David lo mandó el viernes.
La próxima semana haremos teamback e intentaremos juntarnos con Felipe... Chance, jueves después de las 2
en Polanco. David sale de clases a la 1 en Santa Tere. A ver qué pasa.

Habrá que ver qué dicen. Sigo teniendo pendiente:

Cosas x hacer: 
- Acabar el exploratorio con las cosas q Adolfo sugirió. So far lo tengo por variable muy equis.
- Buscar (suggested by Gaby): 
  - Points of distribution. PODs
  - POint of dispensing location
  - RealOp
  - Capacity optimization 
  - Forecasting methods for retail,
aunque creo que más bien ella estaba pensando en optimizar la distribución y nosotros queremos una cosa más simple. 
- Echarle ojo a las dos tristes diapositivas que nos pasaron.
- Bajé un artículo de algo que chance pueda servir.. http://www.jstor.org/stable/40057049


Miércoles Septiembre 18, 2013
------------------------------

Junta para ver wtf con las variables...

PROBLEMOTA: Quieren saber qué hacer para que en cada visita al cliente haya una venta!!?? Welcome to the real world ¬¬
La pregunta es: qué puedo hacer? Vale que rediseñe rutas? será que tengo en mis manos un problema mega marrano de
optimización? 

A ver... 

Supongamos que sí. Que diseño las rutas para el próximo mes de todos los señorines repartidores de papitas. 
Qué información tomo para diseñar esa ruta? Qué información influye en la venta del próximo mes? 

Ok. Entonces, primero necesito explicar la venta o no venta de papitas en una semana. Ver qué variables
influyen en eso. (logit o afines? con pito mil millones de mugres? O bien, muchas logits para muchos clusters!)
Ah, pero si hago muchos logits para muchos clusters... 

Es que es una mamada, hay cosas que no puedes cambiar! Si el **** cliente decide cerrar su tiendita cuando 
va el camión o no tiene dinero para comprar mugres papitas.... La solución es una inception! Para que los de las 
tienditas siempre compren!!! Me mato.

Sigh. Ok, no puedo modificar el que el señor tiendito tenga o no dinero para comprar papas ni muchas otras cosas.
Claramente la gente de merca y esas madres tiene que pensar en qué hará con los pobres tienditos que no compran
papas; yo qué!? Entonces, lo que yo puedo hacer es... Logit again? Explicar qué factores influyen en la no-compra
de papitas? 

Sí, porque no es un pedo de rediseñar rutas... Es un pedo de entender qué gente no compra papas... O será que ya 
entienden eso? Saben quiénes no compran papas? GGGG

O es un pedo de simulación y escenarios? No o sí? 

A ver, acotemos. Qué sí puedo hacer? En orden de factibilidad...
- Explicar qué tipo de clientes no compran papitas (distintos modelos para distintas razones de no-compra?)
- Puedo encontrar rutas óptimas en términos de sí-venta de papitas? La ruta que maximiza la proba de que todos los
tienditos compren? Que minimiza el número de semanas en que menos del x% de los posibles tienditos compra? 
- Puedo simular... qué pasaría si hago tal o cual cosa? Yo no sé nada de eso...

- Uh, puedo hacer clusters de clientes? O definir zonas geográficas y ahí identificar vecindades (bolas, regiones) 
de los clientes más compradores y ver qué pedo con las tienditas vecinas. Esto me suena a gráficas... OMG! la competencia entre tienditaaaas!!! Yo supongo que no debe importar tanto como la competencia entre papas.
Así que no. 

Conclusiones:
- Quizá el pedo de explicar qué tipo de clientes es en el exploratorio? Chance lo de los distintos sets de variables
que había pensado?
- Checando mis notitas del día... Fecha de transmisión = la buena. La fecha de carga es cuándo se envió el camión.
A veces hay un delay de un día. 


Y otro pedo: Otra vez la definición de variable $y$ makes no sense! 

Pendientes:
- Hacer este pedo privado
- Trepar la presentación de lo q hicieron ellos.
- Trepar mi archivo master of variable definitions and stuff.

Viernes. Nos darán epsilon datos. 




Sábado Septiembre 14, 2013
--------------------------
Tuvimos junta ayer con César Something @ Pepsico. 

- Tienen que pasarnos el modelo o chunche que hicieron antes, del cual concluyeron que existen
momentos en los que no hay papitas en las tienditas.
- Miércoles temprano: Vernos para que Alfonso Something nos cuente qué datos existen. 
- Jueves en la tarde: Tener listo qué datos necesitamos. No sólo en términos de variables sino de
"granularidad" y periodo y si es sólo para papitas y si son sólo algunas tienditas y blo, blo.


Divagaciones...

- Supongamos que de hecho existen momentos en los que no hay papitas en las tiendas, lo cual no 
suena improbable. Entonces, queremos explicar wtf. Cómo madres haremos esto... 

- Necesitamos preguntar cómo funciona el pedo de repartir papitas. Hipótesis: Cada semana pasa el
camión repartidor y el dude de la tiendita pide las papitas que quiere. 
- No tenemos info del inventario. Nadie tiene idea del inventario. Podemos inferir cómo se mueven
las papitas a partir de lo que piden los dudes de las tienditas. 

- Plot de la cantidad de papas pedidas en el tiempo. Por tiendita. Chance empezar con aggregates
para dar insights iniciales. 

- Demanda de papitas. Hay aquí que armar un pedo espacial? Seguro vamos a tener que cruzar esto con
info del inegi. Madres socioecon. Chance madres demográficas; yo supongo que más niños => más papitas.
Cruzar con localización de escuelas? Tenemos la base de datos de David!

- En el exploratorio necesitamos info de edades. Ver si la edad de la gente que vive cerca de la tiendita
influye. Si sí, y veo que más niños => más papitas, hacemos el desmadre de escuelas. Si no depende de la edad,
nos quedamos con madres socioecon. 

- Variables geográficas? Meh.

- David habló de los repartidores y sus características...

- Ah y los precios... Hmmmm... Papas baratas => no son muy sensibles a cambios en precios? Sí?

- Un arbolín? Si la población es tal y el mes pasado sucedió tal en el inventario y bla bla, entonces reparta
más papitas que el mes pasado? Entonces reparta 5 papitas? Estaría cool que la delta de papitas fuera la variable
respuesta.

- Modelos por clusters... Chance un clustering thing previo. No debe ser la misma historia en todas las tienditas.
Ahora, si las tienditas están clasificadas... Distintos modelos x tipo de tiendita.

- Igual y en el exploratorio podemos agarrar cuatro ejes: repartidores, demographic stuff, variables socioecon. y
algo de series de tiempo con los inventarios anteriores.... Y un clustering de tienditas. 
Correr modelines sencillos para ver si alguno de estos ejes funciona y definir EL modelo con base en eso. 
O al menos yo supongo que no vale la pena armar un modelo mega cerdo con variables chafas de cada tipo. Si resulta
que un tipo de variables pesan más, igual y vale la pena clavarse en eso desde el inicio. Por ejemplo, lo de las edades
que dije; si la edad de la gente importa, chance clustereo municipios con base en las edades. Y entonces hago lo de las
escuelas y me pongo a buscar fechas de exámenes bimestrales o cosas así.

- Chaaance hacer esto por tipo de variables lo que nos puede dar es una idea de las variables que más pesan para
dividir los datos con base en esas variables y hacer distintos modelos. Por ejemplo, si lo que más pesa es el mes,
hacemos modelos mensuales y ya.

- Hmmm, cómo sé qué variables pesan más... No, no, más bien, si hiciéramos eso en el exploratorio, es un pedo de
decir si cierto tipo de variables sirven para explicar el número de papitas. Entonces todo el mundo se avienta regre-
siones Poisson? 

- Si importa todo, pues importa todo y ya.

- Regresión poisson? Predecir el número de papitas? Con variables temporales. 

- O igual y el pedo es más como lo que decían en Nadro; que el repartidor tenga en su ipod un reportito resumen de la
tienda y decida? 



Must do research on:
- Modelos espaciales.
- Demanda de papitas, ja.
- Ir bajando madres del inegi. A huevo deben servir.
- Mapitas!


Cosas que debo preguntar:
- Tienen coordenadas de las tienditas? Son sólo tienditas o tbn oxxos y walmarts y así? Tenemos más info de las
tienditas?
- Cómo se determinan las rutas?
- Cómo le hacen para repartir madres?
- Quiero un modelo explicativo de la escasez de papitas? Si sí, necesitamos definir "falta de papitas"
- Quiero predecir la demanda de papitas para esta semana? Quiero que la de la tiendita diga "Dejame 5 papitas"
y el repartidor diga "No, señora, le dejo 6" o al revés? Es factible que esto suceda? Queremos cambiar el 
paradigma de la repartición de papitas? Decirle a los de merca que cambien este pedo?
- Qué pedo con los precios de las papas? Porque luego en los oxxos hay promociones... Esas promociones q pedo?
Quién las hace? Tbn hay condiciones de precio como con nadro?


Ojo con:
- Acotar qué tiendas y qué papitas. Eso lo deciden esos weyes.
- Hay que hablar con luis felipe y/o zarate... Especialmente ahorita que no sabemos qué onda. 
- Lo de siempre; dividir en prueba, validación y train. No entrenar con el futuro. El de validación puede servir
para ver q pedo con modelitos exploratorios. En el test debe haber un año, I opin. 



Sábado Septiembre 7,2013
------------------------
Mugre latex en la mac no funciona. Pensé que era un pedo de librerías pero quién sabe qué diabos. 
No fuckin jala lo que había hecho para la tesis de licenciatura. Whatever, luego me peleo con esto
porque x ahora voy a estofar todo en .Rmd's y ya para el formato me peleo con lo que me tenga que pelear.
De cualquier forma subí a github el todo.tex de la criptotesis. Tiene todas mis madres de formato. 

Necesito bibliografia. Por ahora, de market basket. Está el libro q usamos con luis felipe.
Necesito conseguir artículos como hice para la de licenciatura y escribir. No pensaba tener cuaderno para
la tesis pero sí lo necesito. No puedo estar sin rayar cosas. 

Así qué... artículos. escribir. latexear? puedo ir armando un chapter de cosas técnicas. 
Hmmm... qué tanto de teoría se pone en una tesis d maestría? 

Tarea:
- Echarle un ojo a una tesis d maestría. Estarán en santa tere? Habrá en río hondo?
- Ver si cambia el parrafito de disclosure que pone uno al inicio de la tesis.



Lunes Septiembre 2, 2013
------------------------

- A la gente de Nadro le pareció interesante calcular rentabilidades de canastas en tiempo real. 
- Existen "productos gancho"; hay q detectarlos con market basket analysis. Suena a q este rollo es prioritario vs otras cosas que se nos habían ocurrido.
- Hubo pedo x sacar los datos de ahí => vamos a tener q ir a nadro a trabajar. 
- Por lo pronto, a darle al reporte para acabar con esto lo más pronto posible.



Jueves Agosto 16, 2013
----------------------

Todo en orden. Rocío va a hacer un ppt. Hay que esperar que David diga q onda con Arias y/o con la banda d Nadro.

Adolfo: ggmap & mapbox. Stuff to checkout. 




Martes Agosto 14, 2013
------------------------
  
-Ponerle cositos de tiempo a la slide d david. Done. and undone!! Esto dará broncas.
-Quitar proyecciones de la tab de costos y de descuentos. Done.
-Más bien hacer que ventas se llame precios. Done.

Y que esas 3 tabs sean precios, desc y costos cómo se mueven al mover precios?

Y en rentabilidad = ventas - costos +- condiciones de precios.
Scarme coeficientes de la manga para que en la esa ventana muevas los 3 sliders y veas q pasa.


Notas mentales de lo que estoy haciendo:
- Precios y ventas. 
Si uno no elige un artículo distinto de todos, tiene una predicción equisona de intervalos de confianza.
- Había pedos con el sitio de github así q subí a dropbox la última versión en la que ya pinche murió
el fuckin market basket del mal... GGGG por culpa del encoding a la fuckin hora de imprimir!!!

Pendientes:
-Falta que david pase su csv.... DONE
-Agregar lo de David SIN EL CHINGADERÍN DEL TIEMPO Nel; lo dejamos. 
-A los objetos de David hay que cambiarles el nombre para que sólo se loadeeen una vez y desde afuera, como cosos
globales. ahorita no se puede porque las dos chingaderas se llaman gam...
-Comentarles a todos lo del fuckin encoding a la pinche hora de imprimir. Estaría bien googlear y
solucionarlo heroicamente...
-David dice que estaría bien tener grafiquitas tales q pudieras elegir en tu serie del tiempo con qué
periodicidad quieres los datos y desde cuándo :O  For further info, eventualmente checaré el ejemplo en
la página de shiny sobre las acciones de google y sepa dios qué madres más.
- Mañana 3:30 en el starbucks de siempre.
- No se me puede olvidar confirmar con claudia la junta pa' lo de los seguros que se supone es a las 5.
- Tbn debo pedirle a Adolfo que firme mi madriolito ese. Aunq a ver si mañana en santa tere funciona. sigh.



Martes Agosto 13, 2013
------------------------
  
  4:30pm en el Starbucks de Francia.

Note to self:
  - Que David diga las cosas predictivas y que se van poder elegir y tunnear distintos modelos pa las series de tiempo
- Que el Market Basket tbn va a poder tunnearse y que sirve de input pa saber cómo se mueven los inventarios.

David y Rocío:
  
  - Agregarle controlitos a las tabs, aunque no muevan nada, que sí estén.
- Chance en lo de Rocío una circle plot de cliente, producto y el radio = descuento o cosas así.
- A la de ventas/costos agregarle la serie de tiempo de unos descuentos y una cosa de ventas/costos tal cual.
(done)


Sábado Agosto 10, 2013
-----------------------
  
  Aprendizajes de Shiny.

- Tengo un filtro cuyas opciones determinan las opciones de otro. Para ello use updateSelectInput.
Salía error de Error : evaluaci'on anidada demasiado profunda; recursi'on infinita options(expressions= )?
y era porque sobreescribí objetos. Hay que ponerles nombres disitntos y ya.

- En un futuro todas las opciones pueden determinarse a partir de las cosas en la base de datos... 
Suponiendo que voy a hacer una selección de productos y personas y escupirlos en un csv que pueda jalar desde R o algo así.
Si no, quizá a R le conviene leer como catálogos y ya :)

- Para filtrar fue un problema el que se seleccionara la opción "TODO". Tenía que tener un if sobre los inputs 
y se hizo un relajo. Con isolate el if jalaba pero no se actualizaban las cosas.

```r
aux<-input$cliente
if(isolate(cliente()!="Todo")) 
  ```

Intenté darle la vuelta filtrando poco a poco y si en algún momento me quedaba sin registros, regresar al anterior.
Es decir, controlar este desmadre a partir del número de renglones. Pero iba a ser un problema si de hecho un producto
no estaba para algún cliente o cosas así.

Solución:
  
  https://github.com/wch/testapp/blob/master/setinput/ui.R
https://github.com/wch/testapp/blob/master/setinput/server.R

Utilizar sprintf para cachar el contenido de los cosos inputeados!!! Así ya puede hacer ifs felices:
  
  ```r
Material<-sprintf(reactive({input$material})())
if(Material!="Todo"){
  datos3<-reactive({datos2()[datos2()$producto==Material]})
}
else{
  datos3<-datos2
}
```

- Ya tengo dos tabs con pocas tablas y pocos datos y tarda pinche mil años! Así que se me ocurre calcular una vez 
tablas con agregados y de ellas plottear columnas. 
Aparentemente la bronca es que estaba usando el mismo chunchito para que fuera output en dos pestañas! Santo remedio.

- Estaba teniendo pedos para hacer un histograma del mal con ggplot. Todo por culpa de los pinches tipos de datos de R...
As always. Moraleja: Si su gráfica sale rarita, cheque los typeof, str y attributes de sus chingaderas.


Pendientes:
  
  - Necesito hacer funciones para determinar las gráficas porque es un mega desmadre so far.
- Intenté separar el código en .R's pero no jaló. Tengo pedos de scoping y hueva meterme con eso.
- Para q el código funcione en serio debe hacer referencia a los catálogos de sectores, clientes y materiales.
- También debo hacer "dinámicos" los choices de los materiales y del resto de los filtros que seguro surgirán. 


Divagaciones:

- Yisus, queda chingo por hacer. Necesitamos pensar en el deployment final. Si sólo quiero que imprima reportes,
un markdown automatizado es la opción. Porque una aplicación como lo que estoy armando.... Es un desmadre.
Aparentemente el HANA ese ya hace todo eso así que yo opino que reportitos para lo que hagamos con Hadoop.
David está pensando en 2 semanas para algo de mentiras y 4 para montar las cosas para 3 meses. Yo opino que 
es muy poco tiempo pero habrá que ver. 

- Adolfo opina que hay que agregar predicciones a las series de tiempo, cosas geoespaciales y market basket. Bring in da big guns, people. No sólo exploratorio.


- Después de ver a David y a Rocío (4:30 pm, Starbucks Francia), pensamos en agregar cosas:
  - Rocío: Tabla con Top de productos vendidos o de clientes o de lo que sea.
  - Yo: MArket Basket feliz
  - David: Algo geoespacial de mentis


Viernes Agosto 9, 2013
----------------------
  
  Reunión en Intellego con David, Salvador, Margoth, Armando y Rocío. 


Salvador
--------
  
  Salvador hace reportitos para muchas areas (ventas, inventarios, etc.) en Nadro.
Condiciones de precio basados en facturas. Ventas netas, devoluciones, descuentos, 
rentabilidad (so far x sucursal de Nadro, grupo de clientes).

Queremos rentabilidad por proveedor tbn (expediente del proveedor) pero esa es otra historia.
Por producto y por mostrador lo puedo sacar con lo que tengo.
So far veo de cada factura: Total neto, costo promedio, utilidad total.

PD: Su clasificación de mostrador > cadena > subgrupo > grupo está pésima. So far damos info hasta cadena y ya tarda.
Walmart da rentabilidad del -0.7 a 1 %. Todo Nadro tiene margen neto de utilidad de como el 1% y venta neta mensual es
de 1,700 millones de pesos al mes.

Nadro generan precios con base en una herramienta Vistex que pronostica demanda. 

Precio Nadro (lo que les costó a ellos), precio público (casi siempre es sobre este precio que aplican descuentos y cosas),
precio farmacia (el de la cajita de la medicina).

Descuentos comerciales, financieros, corporativos, por pronto pago.

Costo promedio (costo del lote), cedido (costo a que lo trasladas las cosas al cliente), total.

HANA. Convertir mis datos en cuánto dinero se van a ahorrar tal que valga la pena invertir 20 millones de dólares en esa madre...




Miércoles tarde o jueves temprano cita con un dude de Nadro. Un power point.



Venta neta / Costo.

Prec. factura interna es costo.


Tarea:
  
  - Armar el Shiny.


Martes Agosto 6, 2013
----------------------
  
  Vimos a Salvador Diaz Alcantara, el dude de Intellego que está trabajando con los de Nadro.
Nos vimos a las 9am en el ITAM y de ahí David me dio ride al Starbucks frente a Nadro (Santa Fe, x la Ibero).

- Hasta ahora tienen información a nivel factura; cosas como cuánto vendieron este mes; cuánto de su venta fue descuentos, etc.

- Sería valioso poder aportar información a un nivel más específico para un head y un tail de las ventas: 
  - A nivel producto
- A nivel tipo de costo
- A nivel tipo de descuento
Ahorita no lo pueden hacer porque BW (pertenece a SAP) no da. Si además pudiéramos comparar con años anteriores estaría chido.

- Cada presentación de Aspirina es un MATERIAL distinto. Agrupan esas cosas a manita. De querer hacerlo automáticamente
habría que pedirle a la gente de Nadro un catálogo; no es pedo.

- En la base, condición = 0KNART y el importe = 0KNVAL. Cada producto tiene distintas condiciones para cada cliente.
Hay muchas condiciones que no importan para lo que queremos hacer; Salvador sugiere quedarnos con las de la muestra.
Tenemos una muestra que es básicamente de 2 días no completos (500 K registros). De ahí sacar las condiciones.
Al final nos interesan las que hablen de costos y de descuentos.

- También sería valioso aportar rentabilidad de los productos más y menos vendidos. 

- Quizá en algún lugar de la basesota exista "familia de producto", as in: antibióticos, antipiréticos, analgésicos, etc. 
Podríamos hacer análisis dentro de cada familia de producto.

- Tienen datos de hasta 3 años atrás pero para otros modelos; es decir, igual y no tienen todos los campos que necesitamos.
Para los datos tal cual como los de la muestra, tenemos desde enero de 2013.

- En promedio hay 60 productos por factura y hay 60 K facturas al mes

- Posición/10 = lugar en el ticket en que aparece el producto (puede servir para construir id del movimiento de un producto
                                                               en una factura, como decía David).


Resumen:
  
  - Dar info en un nivel más bajo que factura: por producto, por tipo de descuento, por tipo de costo, por cliente... Y sus cruces.


Propuestas extras:
  
  - Análisis de precios de productos en el tiempo o de acuerdo con el cliente o cosas así.
- En cuanto a market basket, sí está chido pero primero responder sus preguntas; luego viene todo eso extra.

- Antes de hacerlo en serio, serio con TODOS los datos (HANA, de SAP), podríamos tener algo para 3 meses para 20 productos.
Esto podríamos montarlo o en Postgres o en un Hadoopsín, chance en Amazon. Si es Postgres, con un script que corramos desde R
o desde el mismo Postgres sale hasta el reporte. Si es Hadoop, habrá que decidir en qué trepamos la base (Hive, supongo) 
y luego mandar los datos filtrados a R para que produzca el reporte solito. 


Pendiente:
  
  - Que Salvador nos pase el catálogo de productos (material en la base de datos)


Tarea:
  
  - Necesitamos un prototipo de reporte y revisarlo con Salvador antes de ir con la gente de Nadro y pedir los tres meses d info.
- El reporte debería tener para 20 productos info sobre los descuentos que se aplican ( x tipo ), sobre los costos (x tipo),
sobre su rentabilidad. Poder agrupar por región o sucursal. Gráficas encimadas con las de ventas totales.
- Pregunta: Es como decía Arias que puede que un mismo producto aparezca en la misma factura pero con distintas condiciones?
Supongo que sí pero no es mala idea verificar.
- También es buena idea echarle un ojo a las condiciones que tenemos en la base de datos e ir identificando el tipo de
costos y de descuentos que tenemos so far.



Viernes Agosto 2, 2013
-------------------------
  
  Reunión con Arias en Intellego. Se me hizo tarde. David me dio ride a Santa Fe. 

- De qué son los importes que tengo? Son importes totales de la factura? O son precios por producto en la factura? 
Porque si es esto segundo, entonces esos importes/cantidad me dan el precio unitario del producto en la factua.
Y si no, si tengo importes por producto por factura por condición... Necesito sumar todos los movimientos 
de un producto en una factura para sacar el precio total porque es posible que por producto tengan "precio del grupo
de productos", "descuento tipo 1", "descuento tipo 2", bla bla... de tal forma que lo que de hecho pagó el cliente por
un conjunto de productos de debe obtener sumando productos en una factura.

- Así tengo dos posibles modos de analizar esto. Las operaciones desagregadas o tal cual los precios en el tiempo.
    - Para operaciones desagregadas puedo hacer lo que hice... A quién le estás haciendo más descuentos de 
    tipo no sé qué madres y de importes más altos?
    - Para precios en el tiempo hay que agregar las operaciones.

- Broncota: Nuestros datos son chacas! Necesitamos o una canasta de productos en el tiempo o un set de clientes.

- Diferentes sectores de clientes => diferentes descuentos y políticas. Eso ya lo saben esos weyes así que no es muy
interesante. No son combinables entre sectores.

- Necesito que me digan qué sector analizar o qué tipo de productos analizar. 


Tarea:

- Ver al dude de la base de datos el martes próximo. Entender bien qué datos hay. 
- Jueves: tener una lista de brainstorms de cosas que se pueden hacer con los datos que hay.
- Próxima semana: feedback de las cosas que se nos ocurrieron que se pueden hacer.



Miércoles Julio 31, 2013
-------------------------
  
  Nos vimos David y yo para rebotar ideas y ver qué onda. 
El viernes en Santa Fe vamos a ver a Arias que tbn tiene propuestas interesantes.

Necesitamos enfocarnos en que se ahorren baro si hacen tal o cual cosa. O que ganen más baro si hacen bla bla. 


Ideas:
  
  - Se nos ocurrió que de tener la matriz de productos-facturas podríamos factorizarla como vimos con Felipe y chance sirva.

- Tbn pensamos que se podría hacer market basket analysis.


Tarea:
  
  -Necesito hacer una gráfica de clientes y tipos de transacciones y que el grosor de las aristas esté dado por
la suma de los importes que caen en ese tipo de operación: venta, descuento o promoción (importe >0, <0 ó =0)
(aunq en la base todo es positivo... así que podría hacerse no por tipo sino tal cual por importe)

- Tbn ver qué puedo hacer por grupo de clientes. C, M, P, etc.


Problemas y preguntas:
  
  - David dijo que venta, descuento o promoción (importe >0, <0 ó =0) pero en la base todo es positivo. 
FALSO! Estaba transformándose mal. Ya se solucionó.
- Tenemos una muestra cero representativa...
- Haace falta entender mejor las variables para ver qué es importante.



Julio 22, 2013
---------------
  
  Nos vimos Adolfo, David y yo para ver q onda.
Dropbox con una muestra de los datos que básicamente corresponden a dos días.

David se va a ir de viaje así q estos días hay que espiar los datos y tener ideas inteligentes.

Próxima semana nos veremos pero Adolfo se va.

Son datos de ventas de medicinas entre los laboratorios y las farmacias, etc. Hay intermediarios que hacen eso.
Hacen promociones y cosas así. Hay que decir cosas interesantes para que se conserven esos datos. 

library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Análisis de condiciones de precios"),
  
#https://groups.google.com/forum/?fromgroups=#!topic/shiny-discuss/D5p9VzQQggw
  sidebarPanel(
    tags$head(
      tags$style(type="text/css", "label.radio { display: inline-block; }", ".radio input[type=\"radio\"] { float: none; }"),
      tags$style(type="text/css", "select { max-width: 200px; }"),
      tags$style(type="text/css", "textarea { max-width: 185px; }"),
      tags$style(type="text/css", ".jslider { max-width: 200px; }"),
      tags$style(type='text/css', ".well { max-width: 310px; }"),
      tags$style(type='text/css', ".span4 { max-width: 300px; }")
    ),
    
    selectInput(inputId = "isector",
              label = "Sector:",
              #choices = c("Todo", "Industria","Comercio","ABARROTES","COMERCIAL","EXCLUSIVO","FARMARED","GOBIERNO",
              #            "HOSPITAL","INSTITUCIONAL","GENERICOS INTERCAMB","MAYOR","NADROLOGISTICA","OTROS",
              #            "POTENCIAL","SUBROGADOS","SANATORIO","INTERCOMPAÑIA","PROVEEDORES"),
              choices=c("Todos","Exclusivo","Institucional","Mayor"),
              selected = "Todos"),
  
    selectInput(inputId = "cliente",
                label = "Cliente:",
                choices = "Todos",
                selected="Todos"),
    
    selectInput(inputId = "material",
              label = "Material",
              choices = c("Todos","MICARDIS PLUS80/12.5MG TAB28 021",
                          "KRYTANTEK OFTE20/2MG GTS 5ML 125",
                          "ULSEN-PCS 40 MG CAPS 14      161",
                          "VIAGRA DISPENSER 100MG TAB1 C/10",
                          "CIALIS 20 MG TAB 1           002",
                          "EMPLAY 3 TWOPACK PROGSSGOLD900GB Y",
                          "EVRA 6MG/600MCG PARCHES 3    014",
                          "VYTORIN 10/20 MG CPR 28      033",
                          "DOLO-NEUROBION FORTE GRAG30  010",
                          "CELEBREX 200 MG CAPS 30      156",
                          "SINGULAIR 10MG CPR RECUB 20  061",
                          "ARTRENE-SR150MG100MCG CAPS LP30",
                          "ZINTREPID 10/20 MG CPR 28    174",
                          "ASPIRINA-PROTEC 100MG TAB 28",
                          "FOSAMAX PLUS 70MG/5600UICPR4 083",
                          "DEXIVANT 60 MG LIB RET CAP14 118",
                          "JANUMET 50/850MG CPR56 RECUB 091",
                          "COMBIVENT.5/2.5MGAMP10X2.5ML 042",
                          "VARTALON COMP1500/1200MGSB30 097",
                          "LACTACYD SH HIG FEMENI 160ML 017"),
              selected = "Todos"),
    
    helpText("Presione 'Actualizar vista' al seleccionar un nuevo Sector o un nuevo Cliente."),
    
    submitButton("Actualizar vista")
  
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Ventas", textOutput("Prueba1"),
               h4("VPRS (Prec.factur.interna)"),
               h5("Totales mensuales (Millones de Pesos)"),
#                div(class="header", 
#                   h6("2011",style="color:black;float:left;"),
#                   h6("-2012",style="color:red;float:left;"),
#                   h6("-2013",style="color:blue;float:left;")),
               plotOutput("VentasTPlot"), 
               br(),
               h4("Totales mensuales (Millones de Pesos)"),
               tableOutput("VentasAggrTabla")
              ),
      tabPanel("Costos", textOutput("Prueba2"),
               h4("VPR1 (Costo Prom. a Ceder) y VPR2 (Costo Prom. Cedido)"),
#                div(class="header", 
#                    h6("2011",style="color:black;float:left;"),
#                    h6("-2012",style="color:red;float:left;"),
#                    h6("-2013",style="color:blue;float:left;")),
               plotOutput("CostosTPlot"),
               h4("Totales mensuales (Millones de Pesos)"),
               tableOutput("CostosAggrTabla"),
               br(),
               h4("Totales anuales (Millones de Pesos)"),
               plotOutput("CostosHPlot"), 
               plotOutput("Costos1TPlot"), 
               plotOutput("Costos2TPlot") 
               ),
      tabPanel("Descuentos", textOutput("Prueba3"),
               h4("ZDFI (SD Ds Financiero) y ZPG5 (SDPromoNad Gral Fact)"),
#                div(class="header", 
#                    h6("2011",style="color:black;float:left;"),
#                    h6("-2012",style="color:red;float:left;"),
#                    h6("-2013",style="color:blue;float:left;")),
               plotOutput("DescTPlot"), 
               h4("Totales mensuales (Millones de Pesos)"),
               tableOutput("DescAggrTabla"),
               plotOutput("Desc1TPlot"),
               plotOutput("Desc2TPlot")) 
      
    )
  )
))

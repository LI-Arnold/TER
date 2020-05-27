#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny) 
library(shinydashboard)
library(shinyWidgets)
library(DT)
library(plotly)
library(ggplot2)

Polluant <- c('PM2.5', 'PM1.0','PM10', 'BC',"NO2")
reqParticipant <- " SELECT  distinct participant_virtual_id 
 		FROM Questionnaire;" 
Participants <- sqldf(reqParticipant)
sidebar <-   dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("Moyenne des Polluants", tabName = "moyennes", icon= icon("cog", lib = "glyphicon")),
                menuItem("Chercher participant", tabName = "participant", icon = icon("search")),
                menuItem("Lecture des données", tabName = "readData", icon = icon("readme")),
                menuItem("Visualisation des données", tabName = "visualisation", icon = icon("poll"))
                
                
    )
)

body <-     dashboardBody(
    
    tabItems(
        # Graphiques
        tabItem(tabName = "moyennes",
                h1("Moyenne des polluants"),
              # dfg <- expand.grid(Polluant = Polluant),
                selectInput("polluant","Polluant",c(None='.', Polluant)),
                verbatimTextOutput('city_'),
              DT::dataTableOutput("poll"),

            fluidRow(
                column(6,
                       h4("Par activité"),
                       plotOutput("plotActivte")
                ),
                column(6,
                       h4("Par événement "),
                       plotOutput("plotEvenement")
                )
            )
            
        ),
        # Read data
        tabItem(tabName = "readData",
                tags$br(),
                fluidRow(
                    column(3,

                           # Input: Checkbox if file has header
                           radioButtons(inputId = "header", 
                                        label = "Header",
                                        choices = c("Yes" = TRUE,
                                                    "No" = FALSE),
                                        selected = TRUE, inline=T)),
                           
                           # Input: Select separator ----
                    column(3, 
                           radioButtons(inputId = "sep", 
                                        label = "Separator",
                                        choices = c(Comma = ",",
                                                    Semicolon = ";",
                                                    Tab = "\t"),
                                        selected =  ";", inline=T)),
                           
                           # Input: Select quotes ----
                    column(5, 
                           radioButtons(inputId = "quote", 
                                        label= "Quote",
                                        choices = c(None = "",
                                                    "Double Quote" = '"',
                                                    "Single Quote" = "'"),
                                        selected = "", inline=T))
                    
                ), 
                fluidRow(
                    column(width=8,
                           fileInput("dataFile",label = NULL,
                                     buttonLabel = "Browse...",
                                     placeholder = "No file selected")),
                    column(5,
                           div(actionButton(inputId = "actBtnVisualisation", label = "Visualisation",icon = icon("play") ),
                               align = "center"))),
                
                tags$br(),
                h3("File preview"),
                DT::dataTableOutput(outputId = "preview")
                
                
                
        ),
        # Participant par catégorie : 
        tabItem(tabName = "participant",
                h1("Par catégorie :"),
            selectInput("participants","Participant",c(None='.', Participants)),
              
                tags$br(),
                    
                           DT::dataTableOutput("InfoParticipant"),
                 tags$br(), tags$br(),

                
        ),
 
        # visualisation
        tabItem(tabName = "visualisation",
               
                h2("Exploration du tableau : "),
                dataTableOutput('dataTable'),
    
                
        )
    )
)

shinyUI(dashboardPage(
    dashboardHeader(title = "Polluscope"),
    sidebar,
    body
))
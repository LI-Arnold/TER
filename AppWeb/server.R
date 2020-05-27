#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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
library(dplyr)
library(sqldf)

shinyServer(function(input, output,session) { 
    data <- reactiveValues()
  
    data2 <- reactive({
        
       
            subset(CategorieParticipant,CategorieParticipant$Participant == input$participant)
    })
    #=============================================================================
    # Preview
    #=============================================================================
    output$preview <-  renderDataTable({
        
        req(input$dataFile)
        
        df <- read.csv(input$dataFile$datapath,
                       header = as.logical(input$header),
                       sep = input$sep,
                       quote = input$quote,
                       
        )
    }, options = list(lengthMenu = c(6, 18, 50),scrollX = TRUE, pageLength = 6)) 
    
    #=============================================================================
    # Lecture
    #=============================================================================
    observeEvent(input$actBtnVisualisation, {
        
        if(!is.null(input$dataFile$datapath)){
            data$table = read.csv(input$dataFile$datapath,
                                  header = as.logical(input$header),
                                  sep = input$sep,
                                  quote = input$quote)
            sendSweetAlert(
                session = session,
                title = "Done !",
                text = "Le fichier a bien été lu !",
                type = "success"
            )
            
            updateTabItems(session, "tabs", selected = "visualisation")
        }
        
    })
    
    #=============================================================================
    # Exploration du tableau
    #=============================================================================
    
    output$dataTable = DT::renderDataTable({
        if(!is.null(data$table)){
            datatable(data$table, filter = 'top',options = list(lengthMenu = c(6, 18, 50),scrollX = TRUE, pageLength = 6))
        }else {
            NULL
        }
    })
    
    #=============================================================================
    # Graphiques
    #=============================================================================

   output$plotActivte <- renderPlot({
       if (input$polluant=="PM2.5") {  piePM2.5Activity}
       else if(input$polluant=="PM10") {  piePM10Activity}
       else if(input$polluant=="PM1.0") {  piePM1.0Activity}
       else if(input$polluant=="NO2") {  pieNO2Activity}
       else  {  pieBCActivity}
  
   }
   )
   output$plotEvenement <- renderPlot({
       if (input$polluant=="PM2.5") {  piePM2.5Event}
       else if(input$polluant=="PM10") {  piePM10Event}
       else if(input$polluant=="PM1.0") {  piePM1.0Event}
       else if(input$polluant=="NO2") {  pieNO2Event}
       else  {  pieBCActivity}
       
   }
   )
   output$poll <- DT::renderDataTable({
    
       if (input$polluant=="PM2.5") { 
            
           DT::datatable(ActivitePM2.5, options = list(lengthMenu = c(6, 18, 50),scrollX = TRUE, pageLength = 6))
           }
       else if(input$polluant=="PM10") {
           DT::datatable(ActivitePM10, options = list(lengthMenu = c(6, 18, 50),scrollX = TRUE, pageLength = 6))
           }
       else if(input$polluant=="PM1.0") { 
           DT::datatable(ActivitePM1.0, options = list(lengthMenu = c(6, 18, 50),scrollX = TRUE, pageLength = 6))
     }
       else if(input$polluant=="NO2") { 
           DT::datatable(ActiviteNO2, options = list(lengthMenu = c(6, 18, 50),scrollX = TRUE, pageLength = 6))
           }
       else  { 
           DT::datatable(ActiviteBC, options = list(lengthMenu = c(6, 18, 50),scrollX = TRUE, pageLength = 6))
           
           }
       })

   
   #=============================================================================
   # Infos Participant
   #=============================================================================
   output$InfoParticipant <- DT::renderDataTable({
   
       DT::datatable(subset(CategorieParticipant,CategorieParticipant$Participant == input$participants ,scrollX = TRUE ) )
   })

    
})


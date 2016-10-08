library(shiny)
source("f_text2model.R")

shinyServer(function(input,output){
    
    output$txtout <- renderText({paste("'",textInp2modelInp(input$txtinp),"'")})
}
    ) # end shinyServer
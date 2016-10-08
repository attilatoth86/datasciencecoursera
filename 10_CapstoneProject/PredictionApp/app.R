library(shiny)
library(shinythemes)
load("03_sampled0.01NGramObject.RData", envir = .GlobalEnv)
server <- function(input, output, session){
    source("f_text2model.R")
    observeEvent(input$submit,{
        output$txtout <- renderText({paste('"',textInp2modelInp(input$txtinp)[1,1],'"')})
        output$plustxtout <- renderText({paste(textInp2modelInp(input$txtinp)[-1,1],",")})
    }
    )
    
}


ui <- shinyUI(
        navbarPage(
            "Capstone Project", id="nav", theme = "bootstrap.min.css",
            tabPanel("Word Prediction App",
                     fluidRow(
                         column(4,
                                h2("Input", align="center"),
                                br(),
                                div(textInput(inputId = "txtinp", 
                                              label = "Please enter an English 
                                              phrase below:"),align="center"
                                ),
                                div(actionButton(inputId="submit",label="Predict"),
                                    align="center"),
                                br(),
                                p(em("Please be patient, predition requires a few seconds..."),
                                  align="center")
                                
                         ),
                         column(8,
                                h2("Output", align="center"),
                                br(),
                                p("Based on the given phrase, the following 
                                  word is being predicted:", align="center"),
                                h2(em(textOutput(outputId = "txtout"), align="center")),
                                br(),
                                br(),
                                p("In addtion, the probability model shows that the 
                                    following words might be good candidates:",
                                  align="center"
                                  ),
                                h4(em(textOutput(outputId = "plustxtout"), align="center"))
                                )
                     )),
            tabPanel("Readme",
                     p("This application is to show off my prediction 
                       algorithm. It has been created with Shiny app; accepts
                       an arbitrary piece of text and predicts the next word.")),
            fluidRow(
                column(12,
                       hr(),
                       p("2016. Created by Attila Toth.", align="center")
                )
            )
                     )
        
                     )



shinyApp(ui = ui, server = server)
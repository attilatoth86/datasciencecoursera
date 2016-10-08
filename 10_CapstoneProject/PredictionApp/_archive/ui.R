library(shiny)
library(shinythemes)

shinyUI(
    navbarPage(
               "Capstone Project", id="nav", theme = "bootstrap.min.css",
               tabPanel("Word Prediction App",
                        fluidRow(
                            column(4,
                                   h2("Input", align="center"),
                                   br(),
                                   div(textInput(inputId = "txtinp", 
                                                 label = "Please enter an English 
                                                          phrase below:"),
                                       submitButton(text="Submit"),
                                       align="center"
                                       )
                                   ),
                            column(8,
                                   h2("Output", align="center"),
                                   p("Based on the given phrase, the following 
                                      word is being predicted:", align="center"),
                                   h4(em(textOutput(outputId = "txtout"), align="center"))
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

) # end shinyUI
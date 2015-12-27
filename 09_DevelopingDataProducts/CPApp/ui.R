library(shiny)
shinyUI(
    navbarPage("App Menu",
               position="fixed-top",
               tabPanel("Main",
                        fluidPage(tags$style(type="text/css", "body {padding-top: 70px;}"),
                        sidebarLayout(
                            sidebarPanel(h3("Motor Trend Car Road Tests"),
                                         em("The data was extracted from the 1974 
                                           Motor Trend US magazine, and 
                                           comprises fuel consumption and 10 
                                           aspects of automobile design and 
                                           performance for 32 automobiles (1973–
                                           74 models)."),
                                         br(),
                                         br(),
                                         p("For detailed information please 
                                           refer to Data Source tab!")
                                ),
                            mainPanel(h2("Developing Data Products - Course 
                                         Project", align="center"),
                                      br(),
                                      br(),
                                      br(),
                                      p("In this project I created an interactive
                                        application to explore one of R's built 
                                        in dataset, the so-called mtcars.", 
                                        align="center")                                      
                                      )
                            ),
                        fluidRow(
                            column(4,
                                   h3("Model overview"),
                                   p("In this section you may select any of the
                                     observed models and on the right side the 
                                     app will show all correspondent information 
                                     stored."),
                                   uiOutput("choose_model")
                                ),
                            column(8,
                                   br(),
                                   br(),
                                   br(),
                                   br(),
                                   br(),
                                   align="center",
                                   tableOutput("modeltbl")
                                )
                            ),
                        fluidRow(
                            column(4,
                                   h3("Information Discovery"),
                                   p("This data were collected to examine Miles 
                                     Per Gallon performance for each car model. 
                                     This information is stored in 'mpg' 
                                     variable. Users might be interested at this 
                                     point about factors that actually drive 
                                     this attribute of cars. In order to give a 
                                     little bit more insight on this the 
                                     application lets users to visualize the 
                                     relationship between 'mpg' and an arbitrary 
                                     attributes."),
                                   selectInput("attrselector", 
                                                label = h5("Select attribute to 
                                                           plot against MPG:"),
                                                choices = list("Number of cylinder" = "cyl", 
                                                               "Displacement" = "disp",
                                                               "Gross horsepower" = "hp",
                                                               "Rear axle ratio" = "drat",
                                                               "Weight (1000 lbs)" = "wt",
                                                               "1/4 mile time" = "qsec",
                                                               "V/S" = "vs",
                                                               "Transmission" = "am",
                                                               "Number of forward gears" = "gear",
                                                               "Number of carburetors" = "carb")
                                                )
                            ),
                            column(8,
                                   align="center",
                                   br(),
                                   plotOutput("regrplot")
                            )
                        )
                         )
                        ),
               tabPanel("Data Source",
                        sidebarLayout(
                            sidebarPanel(h3("Usage"),
                                         p("mtcars"),
                                         h3("Format"),
                                         p("A data frame with 32 observations on 
                                           11 variables."),
                                         p("[, 1]    mpg	Miles/(US) gallon"),
                                         p("[, 2]	cyl	Number of cylinders"),
                                         p("[, 3]	disp	Displacement (cu.in.
                                           )"),
                                         p("[, 4]	hp	Gross horsepower"),
                                         p("[, 5]	drat	Rear axle ratio"),
                                         p("[, 6]	wt	Weight (1000 lbs)"),
                                         p("[, 7]	qsec	1/4 mile time"),
                                         p("[, 8]	vs	V/S"),
                                         p("[, 9]	am	Transmission (0 = 
                                           automatic, 1 = manual)"),
                                         p("[,10]	gear	Number of forward 
                                           gears"),
                                         p("[,11]	carb	Number of 
                                           carburetors"),
                                         h3("Source"),
                                         p("Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411.")
                                ),
                            mainPanel(tableOutput("mtcarstbl")
                                )
                            )
                        
                        )
        )


)
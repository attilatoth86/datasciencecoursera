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

# shinyUI(fluidPage(
#     titlePanel("Developing Data Products - Course Project by Attila Toth"),
#     fluidRow(
#         column(4,
#                h2("Project Introduction"),
#                p("In my course project I will leverage an analyzed dataset used 
#                   in Exploratory Data Analysis course. My ultimate goal is to 
#                   create an interactive application that enables users to 
#                   explore the National Emissions Inventory database and see 
#                   what it say about fine particulate matter pollution in the 
#                   United States over the 10-year of period 1999-2008.")
#         ),
#         column(4,
#                h2("Subject Background"),
#                p("Fine particulate matter (PM2.5) is an ambient air pollutant 
#                  for which there is strong evidence that it is harmful to human 
#                  health. In the United States, the Environmental Protection 
#                  Agency (EPA) is tasked with setting national ambient air 
#                  quality standards for fine PM and for tracking the emissions of 
#                  this pollutant into the atmosphere. Approximatly every 3 years, 
#                  the EPA releases its database on emissions of PM2.5. This 
#                  database is known as the National Emissions Inventory (NEI).")
#         ),
#         column(4,
#                h2("Data"),
#                p("Data used in this application origin from this National 
#                  Emissions Inventory database, available here: 
#                  https://goo.gl/DX0hbS")
#         )
#     ),
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("timeslider",
#                         label = h3("Select analysis timeframe"),
#                         min = 1999, 
#                         max = 2008, 
#                         value = c(1999, 2008), 
#                         step=3, 
#                         sep="",
#                         ticks=FALSE),
#             radioButtons("typeselector", 
#                         label = h3("Select emission type"),
#                         choices = list("Point" = "POINT",
#                                        "Non-Point" = "NONPOINT",
#                                        "On-Road" = "ON-ROAD",
#                                        "Non-Road" = "NON-ROAD")
#                         )
#             ),
#         mainPanel(
# #            plotOutput("sumPlot"),
#             textOutput("test")
#             )
#         )
#     )
#     )
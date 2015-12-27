install.packages("shiny")
library(shiny)
runExample("01_hello")

airquality
cars

library(help = "datasets")

install.packages('devtools')

devtools::install_github('rstudio/shinyapps')
devtools::install_github('rstudio/packrat')

shinyapps::setAccountInfo(name='attilatoth',
                          token='E62EC1E6456E057D5F2713A3745C2121',
                          secret='Qd8T+45PXq51yAw3kWkDRbhqVb/AWwdz2pOrd8yE')

library(shinyapps)
shinyapps::deployApp('GitHub/datasciencecoursera/09_DevelopingDataProducts/CPApp/')
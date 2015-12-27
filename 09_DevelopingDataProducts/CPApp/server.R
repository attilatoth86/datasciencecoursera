
VarMap <- data.frame(
            desc=c("Number of cylinder","Displacement","Gross horsepower", 
                  "Rear axle ratio","Weight (1000 lbs)","1/4 mile time","V/S", 
                  "Transmission","Number of forward gears","Number of carburetors"),
            var= c("cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb")
)


library(shiny)
library(ggplot2)
shinyServer(function(input,output){

    output$mtcarstbl <- renderTable({mtcars})
    
    output$choose_model <- renderUI({
        selectInput("modelselector", label="", choices=as.list(rownames(mtcars)))
    })
    
    output$modeltbl <- renderTable({mtcars[rownames(mtcars)==input$modelselector,]})
    
    output$regrplot <- renderPlot({
        SelVar <- input$attrselector
         qplot(data=mtcars, #mtcars[,colnames(mtcars)=="mpg"|colnames(mtcars)==input$attrselector],
               y=mpg, 
               x=with(mtcars,get(input$attrselector)), #mtcars[,c(1,2)][,2],
               ylab="Miles per gallon",
               xlab=VarMap[VarMap$var==SelVar,][,1],
               geom=c("point","smooth"), 
               method="lm")
#         ggplot(mtcars[,input$attrselector],aes_string(y=mpg))+geom_point()
     })

})










# 
# if (file.exists("nei_data.zip")!=TRUE) {
#     download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
#                   destfile = "nei_data.zip", 
#                   method = "curl")
#     unzip("nei_data.zip")
# }
# 
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")
# 
# library(plyr)
# library(dplyr)
# 
# SCC$SCC <- as.character(SCC$SCC)
# NEISCC <- left_join(NEI, SCC, by="SCC") %>%
#             select(-Pollutant,
#                    -Data.Category,
#                    -Usage.Notes,
#                    -Revised_Date,
#                    -Created_Date,
#                    -Last.Inventory.Year,
#                    -Map.To,
#                    -Option.Set)
# 
# NEISCCsum <- group_by(NEISCC, 
#                       type, 
#                       year, 
#                       Short.Name, 
#                       EI.Sector,
#                       Option.Group,
#                       SCC.Level.One,
#                       SCC.Level.Two,
#                       SCC.Level.Three,
#                       SCC.Level.Four) %>%
#                 summarise(TotalEmission=sum(Emissions),
#                           NumOfMeasures=n())
# 
# 
# library(shiny)
# shinyServer(function(input,output) {
# 
# # output$sumPlot <- renderPlot({
# #                     data <- NEISCCsum %>% 
# #                             filter(type==input$typeselector) %>% 
# #                             group_by(year) %>% 
# #                             summarise(TotalEmission=sum(TotalEmission))
# # 
# #                     barplot(data$TotalEmission/1000000, 
# #                             ylab="Emission (MM t)", 
# #                             names.arg = data$year, 
# #                             main="Total emissions of PM2.5 in the United States from 1999 to 2008")        
# #             })
#     output$test <- renderText({ 
#         "You have selected"
#     })
# 
# 
# }
#     )

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
         qplot(data=mtcars,
               y=mpg, 
               x=with(mtcars,get(input$attrselector)), #mtcars[,c(1,2)][,2],
               ylab="Miles per gallon",
               xlab=VarMap[VarMap$var==SelVar,][,1],
               geom=c("point","smooth"), 
               method="lm")
     })

})
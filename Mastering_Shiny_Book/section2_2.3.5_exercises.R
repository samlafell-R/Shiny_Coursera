library(shiny)


#### 1. Which of textOutput() and verbatimTextOutput() should each of the following render functions be paired with?
# 
# renderPrint(summary(mtcars)) -- verbatimTextOutput()
# 
# renderText("Good morning!") -- textOutput()
# 
# renderPrint(t.test(1:5, 2:6)) -- verbatimTextOutput()
# 
# renderText(str(lm(mpg ~ wt, data = mtcars))) -- textOutput()


ui <- fluidPage(
  plotOutput("plot", width = "700px", height = '300px'),
  
  dataTableOutput("table")
)

server <- function(input, output, session){
  output$plot <- renderPlot(plot(1:5), res = 96, alt = 'A scatterplot of 5 random numbers')
  
  output$table <- renderDataTable(mtcars, options = list(paging = FALSE, pageLength = 0,
                                                         searching=FALSE))
}

shinyApp(ui=ui, server=server)
##### App to greet user by name
library(shiny)

ui <- fluidPage(
  titlePanel('Basic Shiny Exercise'),
  
  textInput(inputId = "name", 
            label = "What's your name?"),
  
  textOutput(outputId = "greeting")
  
)

server <- function(input, output) {
  
  output$greeting <- renderText({
    paste0("Hello ", input$name)
  })
  
}


shinyApp(ui = ui, server = server)
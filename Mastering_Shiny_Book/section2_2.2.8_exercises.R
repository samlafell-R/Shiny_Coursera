library(shiny)


ui <- fluidPage(
  # To leave a text box to input some info
  textInput("name", label = NULL, "Enter your name"),
  
  # Slider input for dates
  sliderInput('date', label = 'When should we deliver?', 
              min = as.Date('2020-09-16'),
              max = as.Date('2020-09-23'),
              value = as.Date('2020-09-17')),
  
  # Including the play button or pause button
  sliderInput('by5', label = 'Select a Number',
              min = 0,
              max = 100,
              value = 5,
              step = 5,
              animate = animationOptions(interval = 700,
                                         playButton = icon('play', "fa-3x"),
                                         pauseButton = icon('pause', "fa-3x"))),
  
  # Breaking up a list to include option groups.
  selectInput('x1', 'Selecting input with option groups',
              choices = list(Eastern = c(`New York` = 'NY', `New Jersey` = 'NJ')))
  
)

server <- function(input, output){
}


shinyApp(ui = ui, server = server)

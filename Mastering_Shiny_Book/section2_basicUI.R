library(shiny)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")

ui <- fluidPage(
  
  # To leave a text box to input some info
  textInput("name", "What's your name?"),
  
  # When we want to input text but hide the characters
  passwordInput("password", "What's your password?"),
  
  # A paragraph of text
  textAreaInput("story", "Tell me about yourself", rows = 3),
  
  # Type a number
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  
  # Slider to select one number
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  
  # Slider to select a range of numbers
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100),
  
  # Input the date
  dateInput("dob", "When were you born?"),
  
  # Input a range of dates
  dateRangeInput("holiday", "When do you want to go on vacation next?"),
  
  # Drop down, typing available, and multiple available, from a predefined list
  selectInput("state", "What's your favourite state?", state.name, multiple = TRUE),
  
  # Select one item from a predefined list
  radioButtons("animal", "What's your favourite animal?", animals),
  
  # Select one item, with icons, from a list defined inside of the UI function
  radioButtons("rb", "Choose one:",
               choiceNames = list(
                 icon("angry"),
                 icon("smile"),
                 icon("sad-tear")
               ),
               choiceValues = list("angry", "happy", "sad")
  ),
  
  # Select multiple items from a predefined list
  checkboxGroupInput("animal", "What animals do you like?", animals),
  
  # Checkboxes
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?"),
  
  # Uploading a file
  fileInput("upload", NULL),
  
  # Create a group of items together. The first fluid row has two boxes in the same row.
  # Different sizes because of "btn" vs "btn-lg" , and the colors determined by "danger" vs "btn-success"
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionButton("drink", "Drink me!", class = "btn-lg btn-success")
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block") # Block tells us that it takes up a whole row.
  ),
  
  textOutput('text'),
  verbatimTextOutput('code'),
  
  tableOutput("static"),
  dataTableOutput("dynamic"),
  
  plotOutput("plot", width = "400px")
)

server <- function(input, output){
  
  output$text <- renderText({
    "Hello Friend!"
  })
  
  output$code <- renderPrint({
    summary(1:10)
  })
  
  output$static <- renderTable({
    head(mtcars)
  })
  
  output$dynamic <- renderDataTable({
    mtcars
    }, 
    options = list(pageLength = 5)
  )
  
  output$plot <- renderPlot({
    plot(1:5)},
    res = 96
  )
  
}


shinyApp(ui = ui, server = server)

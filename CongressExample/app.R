library(shiny)
library(tidyverse)
library(data.table)
library(plyr)

####data import

####VERY IMPORTANT: best practice is to have your .csv or other data file in the same directory as your .r file for the shiny app

setwd("~/Documents/Learning/R/Shiny_Coursera/CongressExample")

## Updated the first section here from the original code to do all data manipulating in data.table syntax instead of dataframe syntax for practice + speed when executing

dat <- fread("cel_volden_wiseman_coursera.csv")

# Select columns and rename (datatable)
dat <- dat[, # No Ordering or Row Filtering
           .(Congress = congress, 
        Ideology = dwnom1, 
        Party = dem),
        # No grouping variables
        ]

# Recode (Datatable)
dat[, Party := mapvalues(Party, from = c(1, 0), to=c('Democrat', 'Republican'))]

# S3 method for data table to drop na
dat <- na.omit(dat)  # can add (cols = c('col1', 'col2')) in the na.omit if we want to specify searching columns

####make the static figure for practice - this won't be displayed

ggplot(
  dat,
  aes(x=Ideology,color=Party,fill=Party))+
  geom_density(alpha=.5)+
  xlim(-1.5,1.5)+
  xlab("Ideology - Nominate Score")+
  ylab("Density")+
  scale_fill_manual(values=c("blue","red"))+
  scale_color_manual(values=c("blue","red"))

####Add facet wrap to see change over time
ggplot(
  dat,
  aes(x=Ideology, color=Party, fill=Party)) +
  geom_density(alpha=.5)+
  xlim(-1.5,1.5)+
  xlab("Ideology - Nominate Score")+
  ylab("Density")+
  scale_fill_manual(values=c("blue","red"))+
  scale_color_manual(values=c("blue","red"))+
  facet_wrap(~Congress)

# Define UI for application that draws a figure
ui <- fluidPage(
  
  # Application title
  titlePanel("Ideology in Congress"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("my_cong",
                  "Congress:",
                  min = 93,
                  max = 114,
                  value = 93)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("congress_distplot")
    )
  )
)

server <- function(input, output) {
  
  output$congress_distplot <- renderPlot({
    
    ggplot(
      filter(dat, Congress==input$my_cong),
      #####if the slider was set to the 93,  this filter line would look like:
      #filter(dat,Congress==93),
      #The value from the slider, assigned to "my_cong" in the UI goes into input$my_cong in the server function.
      
      aes(x=Ideology,color=Party,fill=Party))+
      geom_density(alpha=.5)+
      xlim(-1.5,1.5)+
      xlab("Ideology - Nominate Score")+
      ylab("Density")+
      scale_fill_manual(values=c("blue","red"))+
      scale_color_manual(values=c("blue","red"))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
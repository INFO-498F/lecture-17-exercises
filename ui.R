# Create UI
library(shiny)
shinyUI(fluidPage(
  # UI for the traffic simulation
  titlePanel('Housing Tree'),
  
  # Controls
  sidebarLayout(
    sidebarPanel(  
      checkboxGroupInput("features", label = h3("Features to Use"), 
           choices = colnames(homes)[2:ncol(homes)],
           selected = colnames(homes)[2:ncol(homes)])
    ),
    # Render plot
    mainPanel(
      plotOutput("plot"), 
      textOutput('accuracy')
    )
  )
))

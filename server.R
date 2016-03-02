# Introductory example using the housing data used here: http://www.r2d3.us/visual-intro-to-machine-learning-part-1/
# rpart library
library(rpart)
library(rpart.plot)
library(rattle)
library(shiny)

# Read in data
setwd('~/Documents/INFO-498F/lecture-17-exercises')
source('decision_tree.R')
shinyServer(function(input, output){
  # Use a reactive expression so that you only run the code once
  getResults <- reactive ({
    return(simple_tree(input$features))
  })
  output$plot <- renderPlot({
    results <- getResults()
    return(results$plot)
  })
  output$accuracy <- renderText({
    results <- getResults()
    return(results$accuracy)
  })
})

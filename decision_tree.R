# Introductory example using the housing data used here: http://www.r2d3.us/visual-intro-to-machine-learning-part-1/
# rpart library
library(rpart)
library(rpart.plot)
library(rattle)

# Function to compare values
assess_fit <- function(model, data = homes, outcome = 'in_sf') {
  predicted <- predict(model, data, type='class')
  accuracy <- format(length(which(data[,outcome] == predicted)) / length(predicted) * 100, digits=4)
  return(paste0(accuracy, '% accurate!'))
}

# Tree function
simple_tree <- function(predictors) {
  # Write out forumula
  predictors <- paste( predictors, collapse = "+")
  print(predictors)
  formula <- as.formula(paste0('in_sf ~ ', predictors))
  
  # Set test / training data
  sample_size <- floor(.25 * nrow(homes))
  train_indicies <- sample(seq_len(nrow(homes)), size = sample_size)
  training_data <- homes[train_indicies,]
  test_data <- homes[-train_indicies,]
  
  # Use rpart to fit a model: predict `in_sf` using other variables
  fit <- rpart(formula, data = training_data, method="class")
  
  # List of info to return
  info <- list()
  info$accuracy <- assess_fit(fit, data=test_data)
  p <- fancyRpartPlot(fit, sub='')
  info$tree <- p
  return(info)
}
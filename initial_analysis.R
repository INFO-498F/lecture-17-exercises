# Introductory example using the housing data used here: http://www.r2d3.us/visual-intro-to-machine-learning-part-1/
# rpart library
library(rpart)
library(rpart.plot)
library(rattle)

# Read in data
setwd('~/Documents/INFO-498F/lecture-17-exercises')
homes <- read.csv('part_1_data.csv')
dir.create('visuals', showWarnings = FALSE)

# Function to compare values
assess_fit <- function(model, data = homes, outcome = 'in_sf') {
  predicted <- predict(model, data, type='class')
  accuracy <- length(which(data[,outcome] == predicted)) / length(predicted) * 100
  return(paste0(accuracy, '% accurate!'))
}

# Assess fit for different models

# Use rpart to fit a model: predict `in_sf` using all other variables
basic_fit <- rpart(in_sf ~ ., data = homes, method="class")

# How well did we do?
assess_fit(basic_fit)

# Get a perfect fit: increase complexity, allow small splits
perfect_fit <- rpart(in_sf ~ ., data = homes, method="class", control=rpart.control(cp = 0, minsplit=2))
assess_fit(perfect_fit)

# Testing/training data: great tip from http://stackoverflow.com/questions/17200114/how-to-split-data-into-training-testing-sets-using-sample-function-in-r-program
sample_size <- floor(.25 * nrow(homes))
train_indicies <- sample(seq_len(nrow(homes)), size = sample_size)
training_data <- data[train_indicies,]
test_data <- data[-train_indicies,]

# Train on training data, test on testing data: basic fit
basic_fit <- rpart(in_sf ~ ., data = training_data, method="class")
assess_fit(basic_fit, data=test_data)

# Train on training data, test on testing data: perfect fit
perfect_fit <- rpart(in_sf ~ ., data = training_data, method="class", control=rpart.control(cp = 0, minsplit=2))
assess_fit(perfect_fit, data = test_data)

# Visualize the tree using the base graphics package
png('visuals/tree_structure.png', width=900, height=900)
plot(basic_fit)
text(basic_fit, use.n = TRUE)
dev.off()

# Visualize basic fit
png('visuals/basic_fit.png', width=900, height=900)
fancyRpartPlot(basic_fit)
dev.off()

png('visuals/perfect_fit.png', width=900, height=900)
fancyRpartPlot(perfect_fit)
dev.off()

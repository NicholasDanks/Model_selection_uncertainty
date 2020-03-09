# Illustration of Calculating IT Criteria and Model Averaged Predictions for a PLS Model

# Install packages
# install.packages("devtools")
# install.packages("seminr")
# library(devtools)
# install_github(repo = "sem-in-r/pls-predict")

# Load libraries
library(PLSpredict)
source(file = "library.R")
source(file = "load_models.R")
library(seminr)

## Please note that datasets can be downloaded a: https://pls-sem.net. 
# Load data
training_data <- read.csv(file = "data/Corp Rep training data.csv")
holdout_data <- read.csv("data/Corp Rep holdout data.csv")

# Clean the missing values
for(i in 1:ncol(training_data)){
  training_data[(training_data[,i] == -99), i] <- NA
  training_data[(is.na(training_data[,i])), i] <- mean(training_data[,i], na.rm = TRUE)
}
for(i in 1:ncol(holdout_data)){
  holdout_data[(holdout_data[,i] == -99), i] <- NA
  holdout_data[(is.na(holdout_data[,i])), i] <- mean(holdout_data[,i], na.rm = TRUE)
}

models <-c()
# Get data IC metrics
for (i in 1:length(corp_rep_measurement_model)) {
  models[[i]] <- estimate_pls(data = training_data,
                              measurement_model = corp_rep_measurement_model[[i]],
                              structural_model = corp_rep_structural_model[[i]])
}
# Calculate metrics
IC_matrices = lapply(metrics,
                     function(x) IC_metrics(models = models,
                                            endogenous = "CUSA",
                                            IC_function = x,
                                            sat_model = models[[5]]))

AIC_weights <- IC_matrices[[1]][3,]
BIC_weights <- IC_matrices[[2]][3,]
GM_weights <- IC_matrices[[3]][3,]
Equal_weights <- rep(0.2,5)
weights_matrix <- rbind(AIC_weights, BIC_weights, GM_weights, Equal_weights)

CUSA_holdout_data <- scale(append(holdout_data[,"cusa"], training_data[,"cusa"]))[1:nrow(holdout_data)]

CUSA_OOS_predictions_RMSE <- c()
for (i in 1:length(models)) {
  CUSA_OOS_predictions_RMSE[[i]] <- sqrt(mean(((CUSA_holdout_data - (predict(object = models[[i]],testData = holdout_data[,models[[3]]$mmMatrix[,"measurement"]]))$predicted_composite_scores[,"CUSA"])^2)))
}


OOS_predictions_matrix <- matrix(0,nrow = nrow(holdout_data),ncol = length(corp_rep_measurement_model))
for (i in 1:length(models)) {
  OOS_predictions_matrix[,i] <- (predict(object = models[[i]],testData = holdout_data[,models[[3]]$mmMatrix[,"measurement"]]))$predicted_composite_scores[,"CUSA"]
}


CUSA_OOS_MVA_predictions <- OOS_predictions_matrix %*% t(weights_matrix)

CUSA_OOS_MVA_predictions_RMSE <- c()
for (i in 1:ncol(CUSA_OOS_MVA_predictions)) {
  CUSA_OOS_MVA_predictions_RMSE[[i]] <- sqrt(mean((CUSA_holdout_data - CUSA_OOS_MVA_predictions[,i])^2)) 
}

# Name objects
names(CUSA_OOS_MVA_predictions_RMSE) <- c("AIC","BIC","GM","Equal")
names(CUSA_OOS_predictions_RMSE) <- c("Model 1","Model 2","Model 3","Model 4", "Model 5")
colnames(IC_matrices[[1]]) <- c("Model 1","Model 2","Model 3","Model 4", "Model 5")
colnames(IC_matrices[[2]]) <- c("Model 1","Model 2","Model 3","Model 4", "Model 5")
colnames(IC_matrices[[3]]) <- c("Model 1","Model 2","Model 3","Model 4", "Model 5")

# Print out objects
# 1 AIC Matrix
IC_matrices[[1]]

# 2 BIC Matrix
IC_matrices[[2]]

# 3 GM MAtrix
IC_matrices[[3]]

# Model Predictions
CUSA_OOS_predictions_RMSE

# MVA predictions
CUSA_OOS_MVA_predictions_RMSE



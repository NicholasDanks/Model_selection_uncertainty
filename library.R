# library

## Function to calculate AIC
## AIC = n * log(SSE/n) + 2K
endogenous_AIC <- function(model, endogenous, sat_model) {
  k <- numpaths(model, endogenous) + 1
  n <- nrow(model$construct_scores)
  SSE <- seminr_SSE(model, endogenous)
  return(n*log(SSE/n) + 2*k)
}

## Function to calculate BIC
## BIC = n * log(SSE/n) + k * log(n)
endogenous_BIC <- function (model, endogenous, sat_model){
  k <- numpaths(model, endogenous) + 1
  n <- nrow(model$construct_scores)
  SSE <- seminr_SSE(model, endogenous)
  return(n*log(SSE/n) + k * log(n))
}

## Function to calculate GM
## GM = (SSE_model/MSE_sat_model) = k * log(n)
endogenous_GM <- function (model, endogenous, sat_model){
  k <- numpaths(model, endogenous) + 1
  n <- nrow(model$construct_scores)
  SSE <- seminr_SSE(model, endogenous)
  MSE_sat_model <- seminr_MSE(sat_model, endogenous)
  return((SSE/MSE_sat_model) + (k*log(n)));
}

## Function to calculate deltas for IT metrics
delta_IC <- function(IC_values) {
  return(IC_values - min(IC_values))
}

## Function to calculate weights for IT metrics
IC_weights <- function(deltas) {
  rel_likelihoods <- exp(-0.5 * deltas)
  sum_likelihoods <- sum(rel_likelihoods, na.rm = TRUE)
  return(rel_likelihoods / sum_likelihoods)
}


## Function to calculate AIC, delta AIC, Akaike weights, and Evidence Ratio for each model
## Takes models in a list and endogenous is a character name of endogenous construct, sat_model is the saturated model
## For GM calculation
IC_metrics <- function(models, endogenous, IC_function, sat_model) {
  IC_values <- sapply(models, IC_function, endogenous = endogenous, sat_model = sat_model)
  deltas <- delta_IC(IC_values)
  weights <- IC_weights(deltas)
  output <- matrix(data = c(IC_values,deltas,weights),
                   nrow = 3, ncol = length(models), byrow = TRUE,
                   dimnames = list(c("IC_Metric", "Delta_IC", "IC_weights"), 1:length(models)))
  return(output)
}

# Library of functions
## Function to return the number of incoming paths for an endogenous construct
numpaths <- function(model, endogenous) {
  return(length(model$smMatrix[model$smMatrix[,"target"] == endogenous,"source"]))
}

## Function to estiate the fitted regression line of an endogenous construct
seminr_fitted <- function(model, endogenous) {
  return(model$construct_scores %*% model$path_coef[,endogenous])
}

## Function to estimate SSE (sum of squared residuals or error) for an endogenous construct
seminr_SSE <- function(model, endogenous) {
  return(sum((model$construct_scores[,endogenous] - seminr_fitted(model, endogenous))^2))
}

## Function to estimate SSE (sum of squared residuals or error) for an endogenous construct
seminr_MSE <- function(model, endogenous) {
  return(mean((model$construct_scores[,endogenous] - seminr_fitted(model, endogenous))^2))
}

## Function to sort the path_coef matrix into alphabetical order
return_sorted_paths <- function(model,endogenous) {
  return(model$path_coef[sort(rownames(model$path_coef)), endogenous])
}

## Generate a list of metrics functions
metrics <- list()
metrics[[1]] <- endogenous_AIC
metrics[[2]] <- endogenous_BIC
metrics[[3]] <- endogenous_GM
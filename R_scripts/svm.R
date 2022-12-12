library(kernlab)
svm_model <- svm_poly(degree = 1) %>%
  set_mode("classification") %>%
  set_engine("kernlab", scaled = FALSE)

svm_fit <- svm_model %>% 
  set_args(cost = 10) %>%
  fit(grade ~ ., data = milk_train)

svm_fit

svm_wkflow <- workflow() %>%
  add_model(svm_model %>% set_args(cost = tune())) %>%
  add_formula(grade ~ .)

param_grid <- grid_regular(cost(), levels = 10)

svm_tune <- tune_grid(
  svm_wkflow, 
  resamples = milk_folds, 
  grid = param_grid)

autoplot(svm_tune)

# Best SVM
best_cost <- select_best(svm_tune, metric = "accuracy")

svm_final <- finalize_workflow(svm_wkflow, best_cost)

svm_final_fit <- svm_final %>% fit(milk_train)

# Save Results and Workflow
save(svm_tune, svm_wkflow, 
     file = "C:/Users/Eleanor/Downloads/svm_tune.rda")
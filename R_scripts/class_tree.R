library(rpart.plot)
ct_model <- decision_tree() %>%
  set_engine("rpart") %>% 
  set_mode("classification")

ct_fit <- ct_model %>%
  fit(grade ~ ., data = milk_train)

ct_fit %>%
  extract_fit_engine() %>%
  rpart.plot(roundint=FALSE)

augment(ct_fit, new_data = milk_train) %>%
  accuracy(truth = grade, estimate = .pred_class)

ct_wkflow <- workflow() %>%
  add_model(ct_model %>% set_args(cost_complexity = tune())) %>%
  add_formula(grade ~ .)

param_grid <- grid_regular(cost_complexity(range = c(-3, -1)), levels = 10)

ct_tune <- tune_grid(
  ct_wkflow, 
  resamples = milk_folds, 
  grid = param_grid, 
  metrics = metric_set(accuracy))

autoplot(ct_tune)

# Best Classification Tree

best_complexity <- select_best(ct_tune)

class_tree_final <- finalize_workflow(ct_wkflow, best_complexity)

class_tree_final_fit <- fit(class_tree_final, data = milk_train)

class_tree_final_fit %>%
  extract_fit_engine() %>%
  rpart.plot(roundint=FALSE)
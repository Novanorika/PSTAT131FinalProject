rf_model <- rand_forest(mtry=tune(),
                        trees=tune(),
                        min_n=tune()) %>%
  set_engine("ranger", importance = 'impurity') %>%
  set_mode("classification")

rf_wkflow <- workflow() %>% 
  add_model(rf_model) %>% 
  add_recipe(milk_recipe)

rf_grid <- grid_regular(mtry(range= c(1,5)),
                        trees(range = c(5,150)),
                        min_n(range = c(1,20)),
                        levels = 5)

rf_tune <- tune_grid(rf_wkflow,
                     resamples = milk_folds,
                     grid = rf_grid,
                     metrics=metric_set(roc_auc))

autoplot(rf_tune)

collect_metrics(rf_tune) %>%
  arrange(-mean)

best_rf <- select_best(rf_tune,metric='roc_auc')

rf_final <- finalize_workflow(rf_wkflow,best_rf)

rf_final_fit <- fit(rf_final,milk_train)

# Save Results and Workflow
save(rf_tune, rf_wkflow, 
     file = "C:/Users/Eleanor/Downloads/rf_tune.rda")
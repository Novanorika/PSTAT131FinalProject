knn_model <- 
  nearest_neighbor(neighbors = tune(),
                   mode = "classification") %>% 
  set_engine("kknn")

milk_folds_knn<-vfold_cv(milk_train,v=3,strata = 'grade')

knn_wkflow <- workflow() %>% 
  add_model(knn_model) %>% 
  add_recipe(milk_recipe)

knn_params <- hardhat::extract_parameter_set_dials(knn_model)

knn_grid <- grid_regular(knn_params, levels = 2)

knn_tune <- knn_wkflow %>% 
  tune_grid(resamples = milk_folds_knn, 
            grid = knn_grid)

knn_tune <- tune_grid(knn_wkflow,
                      resamples = milk_folds, 
                      grid = knn_grid,
                      metrics = metric_set(roc_auc))

autoplot(knn_tune)

# Best KNN
best_knn <- select_best(knn_tune,metric='roc_auc')

knn_final <- finalize_workflow(knn_wkflow,best_rf)

knn_final_fit <- fit(knn_final,milk_train)

# Save Results and Workflow
save(knn_tune, knn_wkflow, 
     file = "C:/Users/Eleanor/Downloads/knn_tune.rda")
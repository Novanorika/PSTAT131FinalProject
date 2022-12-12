log_reg <- logistic_reg() %>% 
  set_engine("glm") %>% 
  set_mode("classification")

log_wkflow <- workflow() %>% 
  add_model(log_reg) %>% 
  add_recipe(milk_recipe)

log_fit<-fit(log_wkflow,milk_train)

augment(log_fit, new_data = milk_train) %>%
  conf_mat(truth = grade, estimate = .pred_class) %>%
  autoplot(type = "heatmap")
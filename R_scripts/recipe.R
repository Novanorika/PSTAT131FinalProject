milk_recipe<-
  recipe(grade~.,data = milk_train) %>% 
  step_dummy(all_nominal_predictors()) %>% 
  step_center(all_predictors()) %>% 
  step_scale(all_predictors()) %>% 
  step_normalize()
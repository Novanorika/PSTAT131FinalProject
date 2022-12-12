# Random Forest Precision
augment(rf_final_fit,new_data=milk_test) %>%
  conf_mat(truth=grade,estimate=.pred_class)
augment(rf_final_fit,milk_test)%>%
  precision(grade,.pred_class)

# Classification Tree Precision
augment(class_tree_final_fit,new_data=milk_test) %>%
  conf_mat(truth=grade,estimate=.pred_class)
augment(class_tree_final_fit,milk_test)%>%
  precision(grade,.pred_class)
augment(log_fit, new_data = milk_train) %>%
  accuracy(truth = grade, estimate = .pred_class) 

augment(class_tree_final_fit, new_data = milk_train) %>%
  accuracy(truth = grade, estimate = .pred_class) 

augment(rf_final_fit, new_data = milk_train) %>%
  accuracy(truth = grade, estimate = .pred_class) 

augment(knn_final_fit, new_data = milk_train) %>%
  accuracy(truth = grade, estimate = .pred_class) 

augment(svm_final_fit,new_data=milk_train)%>%
  accuracy(truth=grade,estimate=.pred_class)

acc <- c(log_acc = log_acc$.estimate,
         ct_acc = ct_acc$.estimate,
         rf_acc = rf_acc$.estimate,
         knn_acc = knn_acc$.estimate,
         svm_acc = svm_acc$.estimate)

sort(acc)
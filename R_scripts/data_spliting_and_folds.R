milk_split<-initial_split(milk, prop=0.8, strata = 'grade')
milk_train<-training(milk_split)    # training data
milk_test<-testing(milk_split)    # testing data

dim(milk_train)
dim(milk_test)

milk_folds<-vfold_cv(milk_train,v=5,strata = 'grade') 
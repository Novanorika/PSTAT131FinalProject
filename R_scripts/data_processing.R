milk<-read.csv('C:/Users/Eleanor/Desktop/data/unprocessed/milknew.csv')

milk<-milk %>% 
  clean_names()

names(milk)

missing<-!complete.cases(milk)
milk[missing,]    # check if there is missing data

milk<-milk %>% 
  mutate(taste=as.factor(taste),
         odor=as.factor(odor),
         grade=as.factor(grade),
         fat=as.factor(fat),
         turbidity=as.factor(turbidity))    # changing nominal predictors to factors

dim(milk)

set.seed(800)
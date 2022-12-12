milk %>% 
  ggplot(aes(colour))+
  geom_histogram(binwidth = 0.2, colour = 'white')+
  labs(title = 'Histogram of Milk Colour')

milk %>% 
  ggplot(aes(taste)) +
  geom_bar(aes(fill = grade))

milk %>% 
  ggplot(aes(odor)) +
  geom_bar(aes(fill = grade))

milk %>% 
  ggplot(aes(p_h))+
  geom_histogram(binwidth=0.15,color = 'white',
                 fill='blue')

milk %>% 
  ggplot(aes(x=p_h,y=grade))+
  geom_boxplot()+
  geom_jitter(alpha=0.1)+
  labs(title = "Boxplot of Milk pH")

milk %>%
  ggplot(aes(x = p_h, y = temprature)) + 
  geom_point() +
  geom_smooth(method='loess',formula=y~x)

milk %>% 
  select(where(is.numeric)) %>% 
  cor(use = 'complete.obs') %>% 
  corrplot(type = 'lower', diag = FALSE)
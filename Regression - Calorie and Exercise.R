setwd("D:/Study/python/500 Projects/Project 1 Calorie Burned")

library(tidyverse)
library(broom)
theme_set(theme_classic())

# Load the data
data_ex = read.csv("exercise.csv", header = T)
data_cal = read.csv( "calories.csv", header = T)
# Inspect the data
sample_n(data_ex, 3)
sample_n(data_cal, 3)

df = merge.data.frame(data_ex,data_cal,by= "User_ID")
head(df)
nrow(df)
str(df)
summary(df)
df$Gender=as.factor(df$Gender)

model<-  lm(Calories~.-User_ID,data = df)
model
summary(model)
# all variables are shown as significant

# Fitted vs residual
model.diag.metrics<- augment(model)
model.diag.metrics

# PLotting
ggplot(model.diag.metrics, aes(Gender,Calories))+
  geom_point()+
  stat_smooth(method=lm, se=F)+
  geom_segment(aes(xend = Gender,yend= .fitted), color="red", size = .3)

ggplot(model.diag.metrics, aes(Age,Calories))+
  geom_point()+
  stat_smooth(method=lm, se=F)+
  geom_segment(aes(xend = Age,yend= .fitted), color="red", size = .3)

ggplot(model.diag.metrics, aes(Duration,Calories))+
  geom_point()+
  stat_smooth(method=lm, se=F)+
  geom_segment(aes(xend = Duration,yend= .fitted), color="red", size = .3)

ggplot(model.diag.metrics, aes(Body_Temp,Calories))+
  geom_point()+
  stat_smooth(method=lm, se=F)+
  geom_segment(aes(xend = Body_Temp,yend= .fitted), color="red", size = .3)

#Linear regression makes several assumptions about the data, such as :
  
##  Linearity of the data. The relationship between the predictor (x) and the outcome (y) is assumed to be linear.
##  Normality of residuals. The residual errors are assumed to be normally distributed.
##  Homogeneity of residuals variance. The residuals are assumed to have a constant variance (homoscedasticity)
##  Independence of residuals error terms.

par(mfrow = c(2, 2))
plot(model)


library(ggfortify)
autoplot(model)


# Add observations indices and
# drop some columns (.se.fit, .sigma) for simplification
model.diag.metrics <- model.diag.metrics %>%
  mutate(index = 1:nrow(model.diag.metrics)) %>%
  select(index, everything(), -.se.fit, -.sigma)
# Inspect the data
head(model.diag.metrics, 4)

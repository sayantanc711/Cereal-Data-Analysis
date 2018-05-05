library(readxl)
library(ggplot2)
library(car)
getwd()
setwd("D:/ACADGILD Notes/Machine Learning With R/R basics/Data exploratory project")
getwd()
#reading the cereal data into r
Cereals_data <- read_xlsx("cereals_practice.xlsx",sheet = 1)
#lets see how many cereals are in each type

ggplot(data.frame(Cereals_data), aes(x=Cereals_data$type)) + geom_bar()
#kernel density of calories and fat
d <- density(Cereals_data$calories)
plot(d,main = "Kernel density of calories")
polygon(d,col = "blue",border = "black")
d1 <- density(Cereals_data$fat)
plot(d1,main = "Kernel density of fat")
polygon(d1,col = "blue",border = "black")

#how calories and potassium are distributed
boxplot(Cereals_data$protein)
boxplot(Cereals_data$potass)
#how calories are related to fat sugars and carbohydrates
scatterplotMatrix(~calories+fat+sugars+carbo|type,data = Cereals_data,main = "Relation of calories with carbo,sugars and fat")
#which mfr has the least amount of fat and sugars contents so that we can conclude which is the healthiest among them
ggplot(data = Cereals_data)+geom_point(mapping = aes(x = fat,y = sugars,color = mfr,size = mfr))
#now with fat and sodium
ggplot(data = Cereals_data)+geom_point(mapping = aes(x = fat,y = sodium,color = mfr,size = mfr))
#mfr which sells cereals with high calories
Cereals_data$mfr = as.factor(Cereals_data$mfr)
boxplot(calories~mfr,data = Cereals_data,main = "Calories Vs Manufacturer",xlab = "Manufacturer",ylab = "Calories",col = heat.colors(5))
#now mfr and ratings
boxplot(rating~mfr,data = Cereals_data,main = "Rating Vs Manufacturer",xlab = "Manufacturer",ylab = "Rating",col = heat.colors(5))
#now lets see what relation rating has with calories
install.packages("ggpubr")
library('ggpubr')
ggscatter(Cereals_data,x = "calories",y = "rating",add = "reg.line",conf.int = TRUE,cor.coef = TRUE,cor.method = "pearson",xlab = "Calories",ylab = "Rating")
ggscatter(Cereals_data,x = "sugars",y = "rating",add = "reg.line",conf.int = TRUE,cor.coef = TRUE,cor.method = "pearson",xlab = "Sugars",ylab = "Rating")

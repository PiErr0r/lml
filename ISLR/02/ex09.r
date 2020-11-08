# load the data
library(MASS)
library(ISLR)

rm(list = ls())

######

# init
Auto = read.table("Auto.data")
na.omit(Auto)
names(Auto) = Auto[1,]
Auto=Auto[-1,]
rownames(Auto)=Auto[,9]

Auto$weight = as.numeric(Auto$weight)
Auto$mpg = as.numeric(Auto$mpg)
Auto$cylinders = as.numeric(Auto$cylinders)
Auto$horsepower = as.numeric(Auto$horsepower)
Auto$displacement = as.numeric(Auto$displacement)
Auto$acceleration = as.numeric(Auto$acceleration)

range(Auto$weight)
mean(Auto$weight)
sd(Auto$weight)

range(Auto$mpg)
mean(Auto$mpg)
sd(Auto$mpg)

range(Auto$acceleration)
mean(Auto$acceleration)
sd(Auto$acceleration)

pairs(Auto[, 1:6])

# view the data
fix(Auto)

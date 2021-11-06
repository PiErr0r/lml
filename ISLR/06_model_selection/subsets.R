require(ISLR)
summary(Hitters)
Hitters=na.omit(Hitters)

with(Hitters, sum(is.na(Salary)))

# install.packages('leaps')
library(leaps)

regfit.full=regsubsets(Salary~.,data=Hitters)
summary(regfit.full)

regfit.full=regsubsets(Salary~.,data=Hitters, nvmax=19)
regfit.summary=summary(regfit.full)
names(regfit.summary)
plot(regfit.summary$cp)
which.min(regfit.summary$cp)
regfit.summary$cp[10]
points(10, regfit.summary$cp[10], pch=20, col="red")

plot(regfit.full, scale="Cp")
coef(regfit.full, 10)

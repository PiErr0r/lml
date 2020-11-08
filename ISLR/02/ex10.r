# load the data
library(MASS)
?Boston


######

dim(Boston)
pairs(Boston)

#f
median(Boston$ptratio)

#g
mini = which.min(Boston$medv)
suburb = Boston[mini,]
res = c()
for (n in names(Boston)) {
  rng = range(Boston[n]);
  res = c(res, c(suburb[n] - rng[1], rng[2] - suburb[n]))
}
res

#h
more_7 <- subset(Boston, Boston$rm > 7)
more_8 <- subset(Boston, Boston$rm > 8)
dim(more_7)
dim(more_8)
more_8
pairs(more_8)


# view the data
fix(Boston)

load('7.R.RData')
plot(x, y)
lm.fit=lm(y~x)
summary(lm.fit)

lm.fit2=lm(y~1+x+I(x^2))
summary(lm.fit2)

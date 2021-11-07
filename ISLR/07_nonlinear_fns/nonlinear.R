require(ISLR)
attach(Wage)

fit=lm(wage~poly(age,4), data=Wage)
summary(fit)

agelims=range(age)
age.grid=seq(from=agelims[1],to=agelims[2])
preds=predict(fit,newdata = list(age=age.grid),se=TRUE)
se.bands=cbind(preds$fit+2*preds$se,preds$fit-2*preds$se)

plot(age, wage, col='darkgrey')
lines(age.grid, preds$fit, lws=2, col='blue')
matlines(age.grid, se.bands, col='blue', lty=2)

fita=lm(wage~age+I(age^2)+I(age^3)+I(age^4),data=Wage)
summary(fita)

plot(fitted(fit), fitted(fita))

fita=lm(wage~education,data=Wage)
fitb=lm(wage~education+age,data=Wage)
fitc=lm(wage~education+poly(age,2),data=Wage)
fitd=lm(wage~education+poly(age,3),data=Wage)
anova(fita, fitb, fitc, fitd)

fit=glm(I(wage>250) ~ poly(age, 3), data=Wage, family=binomial)
summary(fit)
preds=predict(fit, list(age=age.grid), se=T)
se.bands=preds$fit + cbind(fit=0,lower=-2*preds$se,upper=2*preds$se)
se.bands[1:5,]

prob.bands=exp(se.bands)/(1+exp(se.bands))
matplot(age.grid, prob.bands, col="blue", lwd=c(2,1,1),lty=c(1,2,2),type="l",ylim=c(0,.1))
points(jitter(age),I(wage>250)/10,pch="|",cex=.5)


## splines

require(splines)
fit=lm(wage~bs(age,knots=c(25,40,60)), data=Wage)
summary(fit)
plot(age, wage, col='darkgrey')
lines(age.grid,predict(fit,list(age=age.grid)),col='darkgreen',lwd=2)
abline(v=c(25,40,60),lty=2,col='darkgreen')

fit=smooth.spline(age,wage,df=16)
lines(fit, col="red", lwd=2)

fit=smooth.spline(age,wage,cv=TRUE)
lines(fit, col="purple", lwd=2)


## GAM
require(gam)
# install.packages('gam')
gam1=gam(wage~s(age, df=4)+s(year, df=4)+education, data=Wage)
par(mfrow=c(1,3))
plot(gam1,se=T)

gam2=gam(I(wage>250)~s(age, df=4)+s(year, df=4)+education, data=Wage, family=binomial)
plot(gam2)

gam2a=gam(I(wage>250)~s(age, df=4)+year+education, data=Wage, family=binomial)
anova(gam2, gam2a, test="Chisq")


par(mfrow=c(1,3))
lm1=lm(wage~ns(age, df=4)+ns(year,df=4)+education,data=Wage)
plot.Gam(lm1,se=T)

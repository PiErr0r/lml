require(ISLR)
Hitters=na.omit(Hitters)

with(Hitters, sum(is.na(Salary)))

library(leaps)
# dont try this at home :D
# install.packages('glmnet')
library(glmnet)

predict.regsubsets = function(obj, newdata, id, ...) {
  form=as.formula(obj$call[[2]])
  mat=model.matrix(form, newdata)
  coefi=coef(obj, id=id)
  mat[,names(coefi)]%*%coefi
}

x=model.matrix(Salary~.-1,data=Hitters)
y=Hitters$Salary

fit.ridge=glmnet(x, y, alpha=0)
plot(fit.ridge, xvar='lambda', label=TRUE)
cv.ridge=cv.glmnet(x, y, alpha=0)
plot(cv.ridge)

fit.lasso=glmnet(x, y)
plot(fit.lasso, xvar='lambda', label=TRUE)
cv.lasso=cv.glmnet(x, y)
plot(cv.lasso)
coef(cv.lasso)

set.seed(1)
train=sample(seq(263), 180, replace=FALSE)

lasso.tr=glmnet(x[train,], y[train])
lasso.tr
pred=predict(lasso.tr, x[-train,])
dim(pred)
rmse=sqrt(apply((y[-train]-pred)^2,2,mean))
plot(log(lasso.tr$lambda), rmse, type="b", xlab="log(lambda)")
lam.best=lasso.tr$lambda[order(rmse)[1]]
lam.best
coef(lasso.tr,s=lam.best)

tst = function (x) {

}

names(cv.ridge)

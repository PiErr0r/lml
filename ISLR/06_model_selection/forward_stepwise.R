require(ISLR)
Hitters=na.omit(Hitters)

with(Hitters, sum(is.na(Salary)))

library(leaps)

regfit.fwd=regsubsets(Salary~.,data=Hitters, nvmax=19, method="forward")
summary(regfit.fwd)
plot(regfit.fwd, scale="Cp")


dim(Hitters)
set.seed(1)
train=sample(seq(263), 180, replace=FALSE)
train
regfit.fwd=regsubsets(Salary~.,data=Hitters[train,],nvmax=19,method="forward")
summary(regfit.fwd)


val.errors=rep(NA, 19)
x.test=model.matrix(Salary~.,data=Hitters[-train,])

for (i in 1:19) {
  coefi=coef(regfit.fwd,id=i)
  pred=x.test[,names(coefi)]%*%coefi
  val.errors[i]=mean((Hitters$Salary[-train]-pred)^2)
}

val.errors
plot(sqrt(val.errors), ylim=c(300,400), pch=19, type="b")
points(sqrt(regfit.fwd$rss[-1]/180),col="blue", pch=19, type="b")


predict.regsubsets = function(obj, newdata, id, ...) {
  form=as.formula(obj.call[[2]])
  mat=model.matrix(form, newdata)
  coefi=coef(obj, id=id)
  mat[,names(coefi)]%*%coefi
}

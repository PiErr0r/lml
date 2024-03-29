require(ISLR)
# install.packages('tree')
require(tree)
attach(Carseats)

hist(Sales)
High=ifelse(Sales<=8, "No", "Yes")
High=as.factor(High)
Carseats=data.frame(Carseats, High)

tree.carseats=tree(High~.-Sales, data=Carseats)
summary(tree.carseats)
plot(tree.carseats)
text(tree.carseats,pretty = 0)

set.seed(1011)
train=sample(1:nrow(Carseats),250)
tree.carseats=tree(High~.-Sales, data=Carseats,subset = train)
plot(tree.carseats)
tree.pred=predict(tree.carseats,Carseats[-train],type="class")
with(Carseats[-train],table(tree.pred,High))
(201+135)/400

cv.carseats=cv.tree(tree.carseats,FUN = prune.misclass)
cv.carseats
plot(cv.carseats)
prune.carseats=prune.misclass(tree.carseats,best = 13)
plot(prune.carseats);text(prune.carseats,pretty = 0)

tree.pred=predict(tree.carseats,Carseats[-train],type="class")
with(Carseats[-train],table(tree.pred,High))
(203+133)/400

## Random forests and boosting

install.packages('randomForest')
require(randomForest)
require(MASS)
set.seed(101)
dim(Boston)
train=sample(1:nrow(Boston),300)
train
?Boston

rf.boston=randomForest(medv~.,data=Boston,subset=train)
rf.boston

oob.err=double(13)
test.err=double(13)
for (mtry in 1:13) {
  fit = randomForest(medv~.,data=Boston,subset=train,mtry=mtry,ntree=400);
  oob.err[mtry]=fit$mse[400];
  pred=predict(fit,Boston[-train,]);
  test.err[mtry]=with(Boston[-train,],mean((medv-pred)^2));
  cat(mtry, " ")
}

matplot(1:mtry,cbind(test.err,oob.err),pch=19,col=c("red","blue"),type="b",ylab='MSQ')
legend("topright",legend=c("OOB","test"),pch=19,col=c("red","blue"))


# Boosting

# install.packages('gbm')
require(gbm)
boost.boston=gbm(medv~.,data=Boston[train,],distribution = "gaussian", n.trees = 10000,
                 shrinkage = 0.01,interaction.depth = 4);
summary(boost.boston)
plot(boost.boston,i="lstat")
plot(boost.boston,i="rm")

n.trees=seq(from=100,to=10000,by=100)
predmat=predict(boost.boston,newdata = Boston[-train,],n.trees = n.trees)
dim(predmat)
berr=with(Boston[-train,],apply((predmat-medv)^2,2,mean))
plot(n.trees,berr,pch=19,ylab="MSE",xlab="# trees",main="Boosting test error")
abline(h=min(test.err),col="red")















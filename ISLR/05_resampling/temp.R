load('5.R.RData')
names(Xy)
?lm
lm.fit = lm(y~.,data=Xy)
summary(lm.fit)

matplot(Xy, type="l")

require(boot)
?boot

alpha = function(x, y) {
  vx = var(x)
  vy = var(y)
  cxy = cov(x, y)
  (vy - cxy) / (vx + vy - 2*cxy)
}

alpha.fn = function(data, index) {
  with(data[index,],alpha(X1,y))
}

boot.out=boot(Xy, alpha.fn, R=10)
boot.out

alpha.fn(Xy, 1:1000)

new.rows = c(101:200, 401:500, 101:200, 901:1000, 301:400, 1:100, 1:100, 801:900, 201:300, 701:800)

new.Xy = Xy[new.rows, ]

alpha.fn(new.Xy, 1:1000)
boot.out=boot(new.Xy, alpha.fn, R=1000)
boot.out

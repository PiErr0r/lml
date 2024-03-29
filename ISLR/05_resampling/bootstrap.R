require(ISLR)
require(boot)

# Bootstrap
alpha = function(x, y) {
  vx = var(x)
  vy = var(y)
  cxy = cov(x, y)
  (vy - cxy) / (vx + vy - 2*cxy)
}

alpha(Portfolio$X, Portfolio$Y)
alpha(Portfolio$Y, Portfolio$X)

alpha.fn = function(data, index) {
  with(data[index,],alpha(X,Y))
}

alpha.fn(Portfolio, 1:100)

set.seed(1)
alpha.fn(Portfolio, sample(1:100, 100, replace=TRUE))

boot.out=boot(Portfolio, alpha.fn, R=1000)
boot.out
plot(boot.out)

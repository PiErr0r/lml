# Introduction

# help for function ?funcname - displayed in window on the right ==>
?c
# define a vector:
x <- c(1, 6, 2)
y <- c(1, 4, 5)

# len of vector
length(c(x, y))

# range
a = 1:10

# matrix stuff
m = matrix(1:4, 2, 2)

# byrow = TRUE
# creates the matrix row by row instead of col by col
m2 = matrix(1:4, 2, 2, TRUE)

# calcuations are made element by element
m ^ 2
sqrt(m)
# even when multiplying
m * m2

# random normal distribution of 50 elements
xn = rnorm(50)
# set up mean and standard deviation as you wish
yn = xn + rnorm(50, mean=50, sd=0.1)

# two types of calculating sd
sqrt(var(xn))
sd(xn)
# correlation
cor(xn, yn)

# seed for random variables - we always get same results
set.seed(1303)
rnorm(50)

# example
set.seed(3)
y = rnorm(100)
mean(y)
var(y)

###############################################################################

# Graphics

# create a scatterplot
x = rnorm(100)
y = rnorm(100)
plot(x, y)
# scatterplot with axis labels as well as the name of the plot
plot(x, y, xlab="x-axis", ylab="y-axis", main="Plot x vs y")

# pdf or jpeg to save the plot
# plot x vs y with dots colored green and save it as `Figure.pdf`
# dev.off -> stop recording and saving to `Figure`
pdf("Figure.pdf")
plot(x, y, col="green")
dev.off()

# sequence (same thing)
x = seq(1, 10)
x = 1:10
# digression - multiplication table
x %o% x
# sequence with len
x = seq(-pi, pi, length = 500)

# countour - 3d plot
y = x
f = outer(x, y, function(x, y)cos(y)/(1 + x ^ 2))
contour(x, y, f, nlevels=45, add=T)

fa = (f - t(f))/2

# image - same as contour but with color - heatmap
image(x, y, fa)

# perspective of the graph
persp(x, y, fa)
# theta - left/right)
# phi - up/dows
persp(x, y, fa, theta=30, phi=20)
persp(x, y, fa, theta=50, phi=40)


###############################################################################

# Indexing

A = matrix(1:16, 4, 4)
A[2,3]
# first and third row, second and fourth col
A[c(1, 3), c(2, 4)]
# all cols first two rows
A[1:2,]
# all cols and all rows **except** first and third
A[-c(1, 3),]
# dim() - dimension row, col
a = dim(A)

###############################################################################

# Load and save data

# read.table() reads data while write.table() saves it
# use zix() to view the data in a window
# read.csv()
# na.omit() - remove missing data
# names() - get header names
# as.factor() - quantitative to qualitative
# hist() - histogram
# pairs() - scatterplot matrix
# identify() starts the identification and after you are finished with clicking
#   click the finish button on the upper right corner to stop identification
#   and the dots you have clicked will have ther id (third parameter)
#   displayed by them
plot(xn, yn)
identify(xn, yn, xn)

# aummary of the variable
summary(A)



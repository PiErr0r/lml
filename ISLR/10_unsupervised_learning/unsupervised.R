dimnames(USArrests)
apply(USArrests,2,mean)
apply(USArrests,2, var)

pca.out=prcomp(USArrests,scale=TRUE)
pca.out
names(pca.out)
biplot(pca.out,scale=0,cex=.6)

# k-means clustering

set.seed(101);
x=matrix(rnorm(100*2),100,2);
xmean=matrix(rnorm(8,sd=4),4,2)
which=sample(1:4,100,replace=TRUE)
x=x+xmean[which,]
plot(x,col=which,pch=19)

km.out=kmeans(x,4,nstart=15)
km.out
plot(x,col=km.out$cluster,cex=2,pch=1,lwd=2)
points(x,col=which,pch=19)

# hierarchical clustering

hc.complete=hclust(dist(x),method="complete")
plot(hc.complete)
hc.single=hclust(dist(x),method="single")
plot(hc.single)
hc.avg=hclust(dist(x),method="average")
plot(hc.avg)

hc.cut=cutree(hc.complete,4)
table(hc.cut,which)
table(hc.cut,km.out$cluster)

plot(hc.complete,labels=which)

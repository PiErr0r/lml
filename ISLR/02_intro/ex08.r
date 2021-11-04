# read the data
college = read.csv("College.csv")
# make new col, on which r will now make calculations, acording to names of the colleges
rownames(college)=college[,1]
# remove the college name col since we have it as row.name
college=college[,-1]

# summary data of the columns
summary(college)
# cant use 1:10 because private is text column and R is not happy
# plot all the pairs in second 9 columns of data
pairs(college[, 2:10])

# plot Private vs Outstate
priv = as.factor(college$Private)
plot(priv, college$Outstate)

# new var elite
Elite = rep("No", nrow(college))
Elite[college$Top10perc > 50] = "Yes"
Elite=as.factor(Elite)
college=data.frame(college, Elite)

summary(college)
plot(Elite, college$Outstate)

# side by side binned data (binned = I guess yes/no but not sure)
par(mfrow=c(1,1))
p <- ifelse(priv == 'Yes', 1, 0)
e <- ifelse(Elite == 'Yes', 1, 0)

par(mfrow=c(1,2))
plot(Elite, college$Top10perc)
plot(Elite, college$Top25perc)

# view the data
fix(college)

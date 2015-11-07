# Q4Q1
# ----

rm(list=ls())

data(shuttle)
shuttle

shuttle$use1 <- factor(ifelse(shuttle$use=="auto",1,0))
shuttle$windhead <- factor(ifelse(shuttle$wind=="head",1,0))

head(shuttle)
str(shuttle)

mdl <- glm(use1~windhead,family="binomial",data=shuttle)
summary(mdl)
exp(mdl$coef)

# Q4Q2
# ----

mdl2 <- glm(use1~windhead+magn,family="binomial",data=shuttle)
summary(mdl2)
exp(mdl2$coef)

# Q4Q3
# ----

shuttle$use2 <- factor(ifelse(shuttle$use=="auto",0,1))
mdl3 <- glm(use2~windhead,family="binomial",data=shuttle)
mdl
mdl3

# Q4Q4
# ----

is <- InsectSprays
str(is)
is$spray <- relevel(is$spray,"B")
str(is)
mdlp <- glm(count~spray,family="poisson",data=is)
summary(mdlp)
mdlp$coef
exp(mdlp$coef)

# Q4Q6
# ----

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
plot(x,y)



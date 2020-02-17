#Logistic Regression Code

x <- DATAFRAME$FREQUENCY OF CRIMES
y <- DATAFRAME$BINOMIAL PRESENCE ABSENCE OF GAME DAY
#All six fixed effects models
# Logistic regression
z <- glm(y ~ x,family = binomial(link="logit"), data = DATAFRAME)

#install.packages("visreg")
library(visreg)
# Visualize fit on the original scale
visreg(z, xvar = "x", ylim = range(y), rug = 2, scale = "response") 

# Visualize fit on the transformed scale (showing working values)
visreg(z, xvar = "x")  

plot(jitter(y, amount = 0.02) ~ x, data = mydata)
yhat <- fitted(z)
lines(yhat[order(x)] ~ x[order(x)])

summary(z)

library(MASS)
confint(z, level = 0.95)

library(MASS)
confint(z, level = 0.95) # approximate 95% confidence intervals

anova(z, test = "Chisq")


#modeling with glms

m1 <- glm(y ~  x, data = DATAFRAME, family = binomial)

#We can account fixed effects by subsetting them and then adding +'s to the x variable. ex:
m1 <- glm(y ~ x + YEAR-YEARVARIATION + PLAYOFFGAMES + SUPERBOWLGAMES, data = DATAFRAME, family = binomial)

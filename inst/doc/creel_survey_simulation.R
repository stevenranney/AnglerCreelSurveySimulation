## ------------------------------------------------------------------------
library(AnglerCreelSurveySimulation)
MakeAnglers(nanglers = 100, meanTripLength = 3.5, fishingDayLength = 12)

## ------------------------------------------------------------------------
str(anglers)

## ----warning = FALSE-----------------------------------------------------
newDf <- data.frame(anglers$triplength)
names(newDf) <- "tripLength"

library(ggplot2)

# Histogram overlaid with kernel density curve
ggplot(newDf, aes(x=tripLength)) + 
geom_histogram(aes(y=..density..), # Histogram with density instead of count on y-axis
binwidth=.1,
colour="black", fill="white") +
geom_density(alpha=.2, fill="#FF6666")  # Overlay with transparent density plot

## ------------------------------------------------------------------------
GetTotalValues(startTime = 0, waitTime = 8, samplingProb = 8/12, meanCatchRate = 2.5)

## ------------------------------------------------------------------------
sim <- SimulateBusRoute(startTime = 0, waitTime = 8, nsites = 1, nanglers = 100, samplingProb = 8/12, meanCatchRate = 2.5, fishingDayLength = 12)
sim

## ------------------------------------------------------------------------
sim <- ConductMultipleSurveys(nsims = 20, startTime = 0, waitTime = 8, nsites = 1, nanglers = 100, samplingProb = 8/12, meanCatchRate = 2.5, fishingDayLength = 12)
sim

## ------------------------------------------------------------------------
mod <- lm((Ehat * catchRateROM) ~ trueCatch, data = sim)
summary(mod)

## ------------------------------------------------------------------------
#Create a new vector of the estimated effort multiplied by estimated catch rate
sim$estCatch <- sim$Ehat * sim$catchRateROM
g <- qplot(x = trueCatch, y = estCatch, data = sim)
g <- g + geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], colour = "red", size = 1.01)
g

## ------------------------------------------------------------------------
mod <- lm(Ehat ~ trueEffort, data = sim)
summary(mod)

#Create a new vector of the estimated effort multiplied by estimated catch rate
g <- qplot(x = trueEffort, y = Ehat, data = sim)
g <- g + geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], colour = "red", size = 1.01)
g

## ------------------------------------------------------------------------
startTime <- 0
waitTime <- 12
samplingProb <- 1

sim <- ConductMultipleSurveys(nsims = 20, startTime = startTime, waitTime = waitTime, nsites = 1, nanglers = 100, samplingProb = 1, meanCatchRate = 2.5, fishingDayLength = 12)
sim

## ----echo = FALSE--------------------------------------------------------
mod <- lm(Ehat ~ trueEffort, data = sim)
summary(mod)

g <- qplot(x = trueEffort, y = Ehat, data = sim)
g <- g + geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], colour = "red", size = 1.01)
g

## ------------------------------------------------------------------------
startTime <- c(0, 4.5)
waitTime <- c(4, 3.5)
nsites = 2
nanglers <- c(50, 50)
fishingDayLength <- 12
samplingProb <- sum(waitTime)/fishingDayLength

sim <- ConductMultipleSurveys(nsims = 20, startTime = startTime, waitTime = waitTime, nsites = nsites, nanglers = nanglers, samplingProb = samplingProb, meanCatchRate = 2.5, fishingDayLength = fishingDayLength)
sim

## ----echo = FALSE--------------------------------------------------------
mod <- lm(Ehat ~ trueEffort, data = sim)
summary(mod)

g <- qplot(x = trueEffort, y = Ehat, data = sim)
g <- g + geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], colour = "red", size = 1.01)
g

## ------------------------------------------------------------------------
#Weekend clerks
startTimeW <- 2
waitTimeW <- 10
nsites <- 1
nanglersW <- 75
fishingDayLength <- 12
samplingProb <- 8/12

simW <- ConductMultipleSurveys(nsims = 8, startTime = startTimeW, waitTime = waitTimeW, nsites = nsites, nanglers = nanglersW, samplingProb = samplingProb, meanCatchRate = 2.5, fishingDayLength = fishingDayLength)
simW

#Add the weekday survey and weekend surveys to the same data frame
monSurvey <- rbind(sim, simW)
mod <- lm(Ehat ~ trueEffort, data = monSurvey)
summary(mod)


## ----echo = FALSE--------------------------------------------------------

g <- qplot(x = trueEffort, y = Ehat, data = monSurvey)
g <- g + geom_abline(intercept = mod$coefficients[1], slope = mod$coefficients[2], colour = "red", size = 1.01)
g


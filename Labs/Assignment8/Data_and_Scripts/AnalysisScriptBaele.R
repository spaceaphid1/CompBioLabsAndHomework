#Jackson Anderson
#Computational Biology
#Assignment 8


library(tidyverse)
library(ggplot2)
library(wesanderson)
library("grid")
library("gridExtra")
library(lme4)
library(rstanarm)

#Setting Working Directory
setwd("/Users/jacksonanderson/Desktop/EBIO4420/CompBioLabsAndHomework/Labs/Assignment 8/Data")

#Reading data in as a tibble
transDat <- read_csv("TransplantBaeleDataCSV.csv")

#Subsetting data by PoolType
createdDat <- transDat %>% 
  filter( PoolType == "Created")

naturalDat <- transDat %>% 
  filter( PoolType == "Natural")

#Functions:

residFunc <- function(model) {
  p1<-ggplot(model, aes(.fitted, .resid))  
  p1 <- p1 + geom_jitter(width = .008, aes(col = factor(.fitted)), size = 2, alpha = .5, show.legend = F)
  p1 <- p1 + scale_color_manual(values = wes_palette("FantasticFox1"))
  p1<-p1+geom_hline(yintercept=0, col="darkslategrey", linetype="dashed")
  p1<-p1+xlab("Fitted values")+ylab("Residuals")
  p1<-p1+ggtitle("Residual vs Fitted Plot")+theme_bw()
}

qqFunc <- function(model) {
  y <- quantile(model$resid[!is.na(model$resid)], c(0.25, 0.75))
  x <- qnorm(c(0.25, 0.75))
  slope <- diff(y)/diff(x)
  int <- y[1L] - slope * x[1L]
  p <- ggplot(model, aes(sample=.resid)) +
    stat_qq( color = "#46ACC8") +
    geom_abline(slope = slope, intercept = int, color="#E58601", alpha = .75) +
    xlab("Theoretical Quantiles")+ylab("Standardized Residuals") + ggtitle("Normal Q-Q") +
    theme_bw()
  
  return(p)
}

cooksFunc <- function(model) {
  p4<-ggplot(model, aes(seq_along(.cooksd), .cooksd))+geom_bar(stat="identity", position="identity", aes(fill = "#E58601"), show.legend = F)
  p4<-p4+xlab("Obs. Number")+ylab("Cook's distance")
  p4<-p4+ggtitle("Cook's distance")+theme_bw()
  return(p4)
}

BoxPlotFuncNoOrder <- function( expData, treatment, response, ExpName, yLabel ) {
  prelimGraph <- ggplot( data = expData, aes( x = treatment, y = response) ) +
    geom_jitter(width = .02, aes(col = factor(treatment)), size = 2, alpha = .5, show.legend = F) +
    geom_boxplot( aes( col = factor(treatment)), 
                  show.legend = F,
                  fill = NA,
                  outlier.color = "Black",
                  outlier.shape = 1,
                  outlier.size = 1.5) +
    scale_color_manual(values = wes_palette("FantasticFox1")) +
    labs(title= ExpName, 
         x= "Treatment Category",
         y= yLabel,
         caption = "- (o) indicates outlier data point") +
    theme_bw()
  return(prelimGraph)
}

myPlotsNoOrder <- function(model, expData, treatment, response, ExpLabel, respLabel, Exper ) {
  
  p1 <- residFunc(model)
  
  p2 <- BoxPlotFuncNoOrder( expData, treatment, response, ExpLabel, respLabel )
  
  p3 <- qqFunc(model)
  
  p4 <- cooksFunc(model)
  
  gridPlot <- grid.arrange(p2, p1, p3, p4, nrow = 2, top = Exper)
  return(gridPlot)
}

#Initial Models, Graphs, and Data/Results Summary

#Models

fullLinModel <- lm(transDat$ReproWt ~ transDat$PoolType)#model for graphics
ttest1 <- t.test(ReproWt ~ PoolType, data = transDat)
ttest1

#Graphs
myPlotsNoOrder( fullLinModel, transDat, transDat$PoolType, transDat$ReproWt, "Reproductive Effort in Natural vs Created Pools", "Reproductive Output (g)", "Baele Transplant Experiment")

#result of a t.test suggest that there is a significant difference in mean fitness between the two groups. Plants in natural pools seem to have a reproductive biomass 2.4 grams heavier than that of plants in artificially created pools. This test does NOT account for random effects due to Transect and PoolID. Likewise, heteroskedasticity in response variable variance (as seen in the resid. vs fitte plot) suggests that our data does not meet the assumptions of a T Test, and thus a model that both incorporates heteroskedasticity and random effects must be run






#Further Models, Graphs, and Data/Results Summaries

#One way to account for heteroskedasticity in residual variance is to log transform the response variabel. We will create a new data frame with the resopnse, ReproWt, log transformed

transDatLog <- read_csv("TransplantBaeleDataCSV.csv") 
boxplot(transDatLog$ReproWt)

transDatLog$ReproWt <- log1p(transDatLog$ReproWt)
boxplot(transDatLog$ReproWt)#comparing this boxplot to the one of the untransformed data to check for proper transformation

#We can now do the same models, graphs, and summaries as we did before. This time we will do it on the log transformed data


#Models
fullLinModelLog <- lm(transDatLog$ReproWt ~ transDatLog$PoolType)#model for graphics
ttest1 <- t.test(ReproWt ~ PoolType, data = transDatLog)
ttest1

#Graphs
myPlotsNoOrder( fullLinModelLog, transDatLog, transDatLog$PoolType, transDatLog$ReproWt, "Reproductive Effort in Natural vs Created Pools", "Reproductive Output (g), Log Transformed", "Baele Transplant Experiment: Log Transformed Response")

#t test and data visualizations suggests that there is still a significant difference in response variable means to treatment. Likewise, the data is not as heteroskedastic, and thus we can feel more comfortable with the knowldge that our data is meeting the normality assumptions required for a t test. In this case, when the response variable has been log transformed, the difference in means between treatments for ReproWt is ~0.30, where plants in natural pools can be seen to have a higher fitness (using ReproWt as a measure). Next, we must account for the random effects of PoolID and Transect location!

#Running a mixed model with PoolID and nested transect as random effects
mixedMod <-stan_glmer(ReproWt ~ PoolType + (1|PoolID/Trans), data = transDatLog)

#After spending countless hours trying to figure out how to interpret this model, I can't understand it for the life of me. All code beyond this point is a work in progress, and should not be referenced for Assingment 8.



### WIP BELOW: IGNORE!!! ###




Fitted <- mixedMod$fitted.values
Residuals <- mixedMod$residuals
mixedDat <- data.frame(Fitted, Residuals)


#removing NA for response variable and adding the fitted/resid values to the data frame
transDatLog <- transDatLog[-c(65),]
transDatLog$fitted <- mixedDat$Fitted
transDatLog$residuals <- mixedDat$Residuals


#Conclusion: after significant analysis, hypothesis cannot be supported, based on the fact that all results (from both raw data and modeled values) suggest that there is a significant difference in fitness between plants in created vs. natural pools. 










## CODE SNIPPETS FOR LATER USE ##
# myPlotsRandom <- function(model, expData, treatment, response, ExpLabel, respLabel, Exper ) {
#   
#   p1 <- ggplot(mixedDat, aes(Fitted, Residuals)) 
#   p1 <- p1 + geom_jitter(width = .008, aes(col = factor(Fitted)), size = 2, alpha = .5, show.legend = F)
#   p1<-p1+geom_hline(yintercept=0, col="darkslategrey", linetype="dashed")
#   p1<-p1+xlab("Fitted values")+ylab("Residuals") + labs( caption = "Color Indicates Unique PoolID and Transect Location")
#   p1<-p1+ggtitle("Residual vs Fitted Plot")+theme_bw()
#   
#   p2 <- BoxPlotFuncNoOrder( expData, treatment, response, ExpLabel, respLabel )
#   
#   y <- quantile(mixedDat$Residuals[!is.na(mixedDat$Residuals)], c(0.25, 0.75))
#   x <- qnorm(c(0.25, 0.75))
#   slope <- diff(y)/diff(x)
#   int <- y[1L] - slope * x[1L]
#   p3 <- ggplot(mixedDat, aes(sample=Residuals)) +
#     stat_qq( color = "#46ACC8") +
#     geom_abline(slope = slope, intercept = int, color="#E58601", alpha = .75) +
#     xlab("Theoretical Quantiles")+ylab("Standardized Residuals") + ggtitle("Normal Q-Q") +
#     theme_bw()
#   
#   
#   p4 <- ggplot( data = transDatLog, aes( x = PoolType, y = fitted) ) +
#     geom_jitter(width = .02, aes(col = factor(PoolType)), size = 2, alpha = .5, show.legend = F) +
#     geom_boxplot( aes( col = factor(PoolType)), 
#                   show.legend = F,
#                   fill = NA,
#                   outlier.color = "Black",
#                   outlier.shape = 1,
#                   outlier.size = 1.5) +
#     scale_color_manual(values = wes_palette("FantasticFox1")) +
#     labs(title= "Predicted Mean Response Values By Pool Type", 
#          x= "Treatment Category",
#          y= "Fitted Values",
#          caption = "Takes into account randomized effects from Pool Type and nested Transect") +
#     theme_bw()
#   
#   gridPlot <- grid.arrange(p2, p4, p1, p3, nrow = 2, top = Exper)
#   return(gridPlot)
# }


##### Part 1:#####

#Step 1:

x <- 7

if ( x > 5) {
  print( "x is greater than five")
}  else {
    print( "x is not greater than 5")
}

#Step 2


dat <- read.csv("/Users/jacksonanderson/Desktop/EBIO4420/compBioSandbox/CompBio_on_git/Labs/Lab05/ExampleData.csv")
str(dat)
vecDat <- dat$x
str(vecDat)

#2a: 
iter <- 2024
for ( i in 1:length(vecDat) ) {
  if ( vecDat[i] < 0 ) {
     vecDat[i] <- NA
  }
}
str(vecDat)

#2b:
logicals <- is.na(vecDat)
vecDat[logicals] <- NaN

# 2c:

toZero <- which(is.nan(vecDat))
vecDat[toZero] <- 0

# 2d and 2e:

fiftyToOneHundred <- vecDat[ which(vecDat >= 50 & vecDat <= 100)]

# 2f

setwd("/Users/jacksonanderson/Desktop/EBIO4420/CompBioLabsAndHomework/Labs/Lab05")
write.csv( x = fiftyToOneHundred, file = "fiftyToOneHundred.csv")

# 3

co2Dat <- read.csv("/Users/jacksonanderson/Desktop/EBIO4420/compBioSandbox/CompBio_on_git/Labs/Lab04/CO2_data_cut_paste.csv")

# 3a
str(co2Dat)

gasNotZero <- which( co2Dat$Gas != 0)
nonZeroGas <- co2Dat[gasNotZero,]
nonZeroGas$Year[1]

# 3b

emissionsIndex <- which(co2Dat$Total > 200 & co2Dat$Total < 300 )
twoHunToThreeHunEmissions <- co2Dat[emissionsIndex,]
twoHunToThreeHunEmissions$Year


##### Part 2 #####

totalGenerations <- 1000
initPrey <- 100 	# initial prey abundance at time t = 1
initPred <- 10		# initial predator abundance at time t = 1
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators

timeVec <- seq(1, totalGenerations)
n <- rep(0, totalGenerations)
p <- rep(0, totalGenerations)
n[1] <- initPrey
p[1] <- initPred

for( t in seq(2, totalGenerations)) {
  n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
  p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])
  
  if (is.nan(n[t])) {
    n[t] <- 0
  } else if ( n[t] < 0 ) {
    n[t] <- 0
  }
  
  if (is.nan(p[t])) {
    p[t] <- 0
  } else if ( p[t] < 0 ) {
    p[t] <- 0
  }
  
  }


plot(timeVec, n, type = "l", col = "red", ylab = "Population Abundance" , xlab = "Generations", main = "Population Abundances Over Generations for Predators and Prey")
lines(timeVec, p, type = "l", col = "blue")
legend("topright", c("Predators", "Prey"), lty = 1, col = c("blue", "red"))
# 6

# Sixth, create a matrix of your results named "myResults" in which the first column is named "TimeStep", the second column is named "PreyAbundance", and the third column is named "PredatorAbundance". Write this matrix to a csv in your Lab05 working directory with the command write.csv(x = myResults, file = "PredPreyResults.csv")

myResults <- data.frame("TimeStep" = timeVec, "PreyAbundance" = n, "PredatorAbundance" = p)
myResults

write.csv( x = myResults, file = "PredPreyResults.csv")
setwd("/Users/jacksonanderson/Desktop/EBIO4420/CompBioLabsAndHomework/Labs/Lab05")








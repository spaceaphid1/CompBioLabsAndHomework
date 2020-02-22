##### Part 1:#####

#Step 1:

x <- 7 # creating a variable named x and giving it a value of 7
#writing a loop to check the value of x and return the following printed messages
if ( x > 5) {
  print( "x is greater than five")
}  else {
    print( "x is not greater than 5")
}

#Step 2

#loading the example data and converting it to a vector called vecDat
dat <- read.csv("/Users/jacksonanderson/Desktop/EBIO4420/compBioSandbox/CompBio_on_git/Labs/Lab05/ExampleData.csv")
str(dat)
vecDat <- dat$x
str(vecDat)

#2a: using a for loop to check the values in vecDat and convert negative values to NA's
for ( i in 1:length(vecDat) ) {
  if ( vecDat[i] < 0 ) {
     vecDat[i] <- NA
  }
}
str(vecDat)

#2b: using logical indexing to convert the NA values in vecDat from step 2a to NaN's
logicals <- is.na(vecDat)
vecDat[logicals] <- NaN

# 2c: using indexing to check vecDat for NaN's and convert them to 0's

toZero <- which(is.nan(vecDat))
vecDat[toZero] <- 0

# 2d and 2e: determining which values in vecDat fall within the range of 50 to 100 using the which function and a vector called "fiftyToOneHundred" with all the values that satisfy the conditions in the which function

fiftyToOneHundred <- vecDat[ which(vecDat >= 50 & vecDat <= 100)]

# 2f: Setting a working directory for lab05, using the vector fiftyToOneHundred to create a csv filed callded "fiftyToOneHundred"

setwd("/Users/jacksonanderson/Desktop/EBIO4420/CompBioLabsAndHomework/Labs/Lab05")
write.csv( x = fiftyToOneHundred, file = "fiftyToOneHundred.csv")

# 3: Importing the Co2 data

co2Dat <- read.csv("/Users/jacksonanderson/Desktop/EBIO4420/compBioSandbox/CompBio_on_git/Labs/Lab04/CO2_data_cut_paste.csv")

# 3a: Getting the structure of the Co2 Data
str(co2Dat)

gasNotZero <- which( co2Dat$Gas != 0) #getting the "Gas" indexes that do not equal 0 from the Co2 data file and storing them in a vector
nonZeroGas <- co2Dat[gasNotZero,] #using the vector from the previous step to index co2Dat, then creating a new data fram out of those indexed values
nonZeroGas$Year[1] #indexing the first year of the non-zero gas data frame

# 3b: using conditionals to index data from the co2Dat data object and create new data objects from these indices

emissionsIndex <- which(co2Dat$Total > 200 & co2Dat$Total < 300 ) #finding total emission indexes that fall between the values of 200 and 300 and storing it in a vector called emissionsIndex
twoHunToThreeHunEmissions <- co2Dat[emissionsIndex,] # using the indices from the above operation to create a new data object that is the co2Dat, indexed by where total emissions values were between 200 and 300
twoHunToThreeHunEmissions$Year # printing the years present in twoHunToThreeHunEmissions to find when gas emissions were within the range of 200 and 300


##### Part 2 #####

#setting the initial conditions
totalGenerations <- 1000# number of total generations we will calculate over
initPrey <- 100 	# initial prey abundance at time t = 1
initPred <- 10		# initial predator abundance at time t = 1
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators

timeVec <- seq(1, totalGenerations) # creating a time vector that goes, in sequence, from 1 to totalGenerations (1000)
n <- rep(0, totalGenerations) #creating an empty data object n with totalGenerations elements in it
p <- rep(0, totalGenerations)#creating an empty data object p with totalGenerations elements in it
n[1] <- initPrey #setting the first value of n to be the value in initPrey
p[1] <- initPred #setting the first value of p to be the value in initPred

#using a for loop to calculate population abundances over totalGenerations
for( t in seq(2, totalGenerations)) {
  n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
  p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])
  
  if (is.nan(n[t])) { # using conditionals to convert negative and NaN values to 0
    n[t] <- 0
  } else if ( n[t] < 0 ) {
    n[t] <- 0
  }
  
  if (is.nan(p[t])) {# using conditionals to convert negative and NaN values to 0
    p[t] <- 0
  } else if ( p[t] < 0 ) {
    p[t] <- 0
  }
  
  }

#plotting n and p against the vector timeVec created above
plot(timeVec, n, type = "l", col = "red", ylab = "Population Abundance" , xlab = "Generations", main = "Population Abundances Over Generations for Predators and Prey")
lines(timeVec, p, type = "l", col = "blue")
legend("topright", c("Predators", "Prey"), lty = 1, col = c("blue", "red"))

#storing my results in a new data frame called myResults, using the values found in timeVec, "n", and "p"

myResults <- data.frame("TimeStep" = timeVec, "PreyAbundance" = n, "PredatorAbundance" = p)
myResults

# using the write.csv function to take "myResults" and create a .csv file out of it. 
write.csv( x = myResults, file = "PredPreyResults.csv")
setwd("/Users/jacksonanderson/Desktop/EBIO4420/CompBioLabsAndHomework/Labs/Lab05")








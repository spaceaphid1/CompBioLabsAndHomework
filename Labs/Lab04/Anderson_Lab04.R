# Jackson Anderson
# CompBio Lab 4
# Feb 10, 2019

# Practice/Cheatsheet stuff 
myseq <- 1:5
myseq

myseq <- c( 1, 9, 11, 13, 15)

for( i in myseq) {
  print("hi")
} #for every element (placeholder) of myseq, print "hi" to the console. This will print hi 5 times to the console, regardless of the numbers stored in myseq

#Step 1: Write a for loop that prints the word "hi" 10 times

for( i in 1:10) {
  print("hi")
}

#Step 2: Solving Tim's finance situation. How much money will he have at the end of each week, given the below constraints?

pigyStart <- 10 # amount of money in his pigybank in dollars
allowance <- 5 # amount of money his parents give him each week
gumPrice <- 1.34 #price of one stick of gum
gumMultiplier <- 2 # variable to scale the amount of gum bought each week
netWealth <- (allowance - (gumMultiplier * gumPrice)) # amount of money in and out each week

# creating a for loop to solve the problem in step 2
for ( i in 1:8 ) {
  funds <- ( pigyStart + i * (allowance - (gumPrice * gumMultiplier)))
  print(funds)
}

#Step 3: How will the population change over the next seven years, assuming it is decreasing by a given rate and has the starting conditions listed below?

initPopSize <- 2000 # initial population size
popChangeRate <- 0.05 #population change reate

#for loop calculating the population change over seven years
for( i in 1:7) {
  newPop <- initPopSize - i * ( initPopSize * popChangeRate)
  print(newPop)
}

#Step 4: time logistic growth equation given the below parameters


initPopSize <- 2500 # initial population size
K <- 10000 # carrying capactiy
r <- 0.8 #intrinsic growth rate

# for loop using the appropriate equation, where "i" would be time in years. 
for ( i in seq( 2,12)) {
  initPopSize[i] <- initPopSize[i-1] + ( r *initPopSize[i-1] * ( K - initPopSize[i-1]) / K)
  print(initPopSize[i])
}
# pop size after 12 years would be 9999.985

#Step 5:

#5a
rept <- 18 #creating a variable for my following rep function
dat <- rep(0,rept) #repeating 0 18 times and storing it in a vector called "dat"

#5b: replace the i'th value in the iterator with three times the i'th value
for ( i in 1:18) {
  dat[i] <- 3 * i
}

#5c: make the first entry of the "dat" vector the value 1

dat <- rep(0,rept)

for ( i in 1) {
  dat[i] <- i 
}

#5d: replacing the value stored in the i'th position with 1 + the 2 times the value of the previous entry, starting with the second entry of the vector.

dat <- replace( dat, 1,1 )
for ( i in 2:18) {
  dat[i] <- 1 + (2 * dat[i-1])
}
dat

#Step 6: making the fibonacci sequence using a for loop

fibDat <- rep(0,20) 
fibDat <- replace ( fibDat, 2, 1)

for ( i in 3:20 ) {
  fibDat[i] <- fibDat[i-1] + fibDat[i-2]
}

# Step 7: redoing question 4 from above, but using vectors to store the data and then plotting population abundance over time.

initPopSize <- 2500 # initial population size
K <- 10000 # carrying capactiy
r <- 0.8 #intrinsic growth rate
popDat <- rep(0,12)

# for loop using the appropriate equation, where "i" would be time in years. 
for ( i in seq( 2,12)) {
  initPopSize[i] <- initPopSize[i-1] + ( r *initPopSize[i-1] * ( K - initPopSize[i-1]) / K)
}

#creating a population abundance vector using the output from the for loop above
for (i in 1:12) {
  popDat[i] <- initPopSize[i]
}

timeVec <- 1:12 #creating a vector to store time increments, ranging from 1 to 12

plot(timeVec,popDat)

#Step 8: Still working; couldnt finish by due date!

#8a and b
CO2dat <- read.csv("/Users/jacksonanderson/Desktop/EBIO4420/compBioSandbox/CompBio_on_git/Labs/Lab04/CO2_data_cut_paste.csv", colClasses = c("integer", rep("numeric", 7)))

CO2datLoop <- read.csv("/Users/jacksonanderson/Desktop/EBIO4420/compBioSandbox/CompBio_on_git/Labs/Lab04/CO2_data_cut_paste.csv")

for ( i in 2:7) {
  CO2datLoop[i] <- as.numeric(i)
}
str(CO2datLoop)

#8c

#use a for loop to operate on columns
#use a for loop to operate on rows within colums
# 
# rep1 <- rep( 0, 263)
# 
# # for ( i in 1:nrow(CO2dat)) {
# #   CO2datnewtotal <- 
# # }
# 
# # CO2dat$Total[c(1:6)]
# for (i in 2:263 ) {
# CO2dat$Total[ c(1:263) ] <- CO2dat$Total[ (i-1) / i ]
# }

#Jackson Anderson Lab03 Assignment

#Step 3: objects containing the number of bags of chips I have and the number of guests coming to the party
chips <- 5
guests <- 8

# Step 5: creating a variable that represents how much of a bag each guest will eat
guest_eats <- 0.4
 
#Step 6: calculating how many bags of chips I will have left over at the end of the night assuming I eat the same amount as my guests
5 - guest_eats*(guests + 1)


#Step 7: Defining vectors for each parties ranking of starwars movies
Self_rank <- c(7,9,8,1,2,3,4,6,5)
Penny_rank <- c(5,9,8,3,1,2,4,7,6)
Lenny_rank <- c(6,5,4,9,8,7,3,2,1)
Stewie_rank <- c(1,9,5,6,8,7,2,3,4)

#Step 8: assessing Penny's and Lenny's ranking for episode 4
PennyIV <- Penny_rank[4]
LennyIV <- Lenny_rank[4]
# SelfIV <- Self_rank[4]
# StewieIV <- Stewie_rank[4]

#Step 9: combining all 4 vectors of each members ranking of starwars movies
guest_ranks <- cbind(Self_rank, Penny_rank, Lenny_rank, Stewie_rank)
guest_ranks

#Step 10: comparing how the three objects below differ 

str(PennyIV) # this is just an element in a vector, so a number essentially
str(Penny_rank) # this is a series of numbers, 1-9, stored as a vector
str(guest_ranks) # this is a data object, made up of a series of vectors. The object contains both character types and number types.

#Step 11: Creating "data frames" from the member ranking vectors in two different ways
ranking_frame <- data.frame(Self_rank,Penny_rank,Lenny_rank,Stewie_rank)
ranking_frame2 <- as.data.frame(guest_ranks)

#Step 12: differences between the object "guest_ranks" and "ranking_frame":
str(ranking_frame) # object of data.frame type, containg 9 rows (observations) and 4 variables (columns)
str(guest_ranks) # an object with a numeric matrix component with 9 rows and 4 columns. The object also contains two character components of length 9 and 4.
  

# Step 13: Making a vector of the episdoe names
Ep_names <- c("I","II","III","IV","V","VI","VII","VIII","IX")

#Step 14: calling the row names of "ranking_frame" and "guest_ranks" and replacing with the vector "Ep_names"
row.names(ranking_frame) <- Ep_names
ranking_frame
row.names(guest_ranks) <- Ep_names
guest_ranks

#Step 15: 3rd row of vector "guest_ranks"
guest_ranks[3,]
#Step 16: 4th column of "ranking_frame"
ranking_frame[,4]
#Step 17: 5th row and 1st colum of "ranking_frame"
ranking_frame[5,1]
#Step 18: 2nd row and 2nd column of "ranking_frame"
ranking_frame[2,2]
#Step 19: rows 4-6 of all columns for "ranking_frame"
ranking_frame[4:6,]
#Step 20: rows 2, 5, and 7 for all columns
ranking_frame[c(2,5,7),]
#Step 21: rows 4 and 6 for columns 2 and 4
ranking_frame[c(4,6),c(2,4)]

#Step 22: Switching Lenny's rankings for episodes 2 and 5
temp <- ranking_frame[2,3] #storing Lenny's ranking for episode 2 in a temporary variable "temp"
ranking_frame[2,3] <- ranking_frame[5,3] # replacing Lenny's ep2 ranking with ep5 ranking
ranking_frame [5,3] <- temp # using the temp variable to replace ep5 ranking

#Step 23: Accessing Penny's ranking for episode 3 using names instead of indices
ranking_frame["III", "Penny_rank"]
guest_ranks["III", "Penny_rank"]

#Step 24: Undoing the switch of Lenny's rankings done in step 22. 
temp <- ranking_frame["II","Lenny_rank"]
ranking_frame["II","Lenny_rank"] <- ranking_frame["V","Lenny_rank"]
ranking_frame ["V","Lenny_rank"] <- temp

#Step 25:Redo-ing the switch from step 24 using the $ operator to access variables within a data frame
temp <- ranking_frame$Lenny_rank[2]
ranking_frame$Lenny_rank[2] <- ranking_frame$Lenny_rank[5]
ranking_frame$Lenny_rank[5] <- temp


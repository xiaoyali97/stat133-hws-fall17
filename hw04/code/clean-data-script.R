#==============================================
#Title: HW04, Stat 133, functions
#Description: 
#   This R Script cleans the raw data
#Input: - rawscores.csv
#       - functions.R
#Output: - summary-rawscores.txt
#        - summary-cleanscores.txt
#        - cleanscores.csv
#Author: Xiaoya Li
#Date: 11-13-2017
#==============================================

library(readr)
library(dplyr)
source("functions.R")

#read in the CSV file with the raw scores
rawscores <- read_csv("../data/rawdata/rawscores.csv", col_names = TRUE)

sink(file = "../output/summary-rawscores.txt")
str(rawscores)
for(i in 1:ncol(rawscores)){
  cat("\n", colnames(rawscores)[i], "\n")
  print_stats(summary_stats(unlist(rawscores[,i], use.names = FALSE)))
}
sink()

#replace all missing values NA with zero
for(i in 1:ncol(rawscores)){
  rawscores[is.na(rawscores[,i]),i] = 0
}


#use rescale100() to rescale QZ1: 0 is the minimum, and 12 is the max
rawscores$QZ1 <- rescale100(rawscores$QZ1, 0, 12)

#use rescale100() to rescale QZ2: 0 is the minimum, and 18 is the max.
rawscores$QZ2 <- rescale100(rawscores$QZ2, 0, 18)

#use rescale100() to rescale QZ3: 0 is the minimum, and 20 is the max.
rawscores$QZ3 <- rescale100(rawscores$QZ3, 0, 20)

#use rescale100() to rescale QZ4: 0 is the minimum, and 20 is the max
rawscores$QZ4 <- rescale100(rawscores$QZ4, 0, 20)

#use rescale100() to add a variable Test1 by rescaling EX1: 0 is the minimum, and 80
#is the max.
rawscores$Test1 <- rescale100(rawscores$EX1, 0, 80)

#use rescale100() to add a variable Test2 by rescaling EX2: 0 is the minimum, and 90
#is the max.
rawscores$Test2 <- rescale100(rawscores$EX2, 0, 90)

#add a variable Homework to the data frame of scores; this variable should contain the
#overall homework score obtained by dropping the lowest HW, and then averaging the
#remaining scores.
overall_HWs <- select(rawscores, 1:9)
rawscores$Homework <- vector(mode = "numeric", length = nrow(rawscores))
for(i in 1:nrow(overall_HWs)){
  rawscores$Homework[i] <- score_homework(unlist(overall_HWs[i,], use.names = FALSE), drop = TRUE)
}

#add a variable Quiz to the data frame of scores; this variable should contain the overall
#quiz score obtained by dropping the lowest quiz, and then averaging the remaining scores.
overall_QZs <- select(rawscores, c("QZ1", "QZ2","QZ3", "QZ4"))
rawscores$Quiz <- vector(mode = "numeric", length = nrow(rawscores))
for(i in 1:nrow(overall_QZs)){
  rawscores$Quiz[i] <- score_quiz(unlist(overall_QZs[i,], use.names = FALSE), drop = TRUE)
}

#add a variable Lab to the data frame of scores
rawscores$Lab <- vector(mode = "numeric", length = nrow(rawscores))
for(i in 1:nrow(rawscores)){
  rawscores$Lab[i] <- score_lab(rawscores$ATT[i])
}
 

#add a variable Overall to the data frame of scores; this variable should be calculated
#using the following grading structure:
#  - 10% Lab score
#  - 30% Homework score (drop lowest HW)
#  - 15% Quiz score (drop lowest quiz)
#  - 20% Test 1 score
#  - 25% Test 2 score
# - (Overall must be already in a scale 0 to 100)
rawscores$Overall <- (0.1 * rawscores$Lab + 0.3 * rawscores$Homework + 0.15 * rawscores$Quiz
                      + 0.2 * rawscores$Test1 + 0.25 * rawscores$Test2)


#calculate a variable Grade (and add it to the data frame of scores), that contains the
#letter grade based on the following cutting points.
rawscores$Grade <- vector(mode = "character", length = nrow(rawscores))
for(i in 1:nrow(rawscores)){
  x = rawscores$Overall[i]
  if(x >= 95){ letter = 'A+' }
  else if(x >= 90){ letter = 'A' }
  else if(x >= 88){ letter = 'A-' }
  else if(x >= 86){ letter = 'B+' }
  else if(x >= 82){ letter = 'B' }
  else if(x >= 79.5){ letter = 'B-' }
  else if(x >= 77.5){ letter = 'C+' }
  else if(x >= 70){ letter = 'C' }
  else if(x >= 60){ letter = 'C-' }
  else if(x >= 50){ letter = 'D' }
  else{ letter = 'F' }
  rawscores$Grade[i] = letter
}

#write a for loop in which you use your functions summary_stats() and print_stats()
#to export, via sink(), the summary statistics for Lab, Homework, Quiz, Test1, Test2,
#and Overall.
stats <- c("Lab", "Homework", "Quiz", "Test1", "Test2", "Overall")
for(i in 1:length(stats)){
  filename = paste("../output/",stats[i], "-stats.txt", sep = "")
  sink(file = filename)
  print_stats(summary_stats(unlist(select(rawscores,stats[i]),use.names = FALSE)))
  sink()
}

#sink() the structure str() of the data frame of clean scores to a file summary-cleanscores.txt,
#inside the output/ folder.
sink(file = "../output/summary-cleanscores.txt")
str(rawscores)
sink()

#Finally, export the clean data frame of scores to a CSV file cleanscores.csv inside
#the folder data/cleandata/. This data set should contain 334 rows, and 23 columns.
write.csv(rawscores, file = "../data/cleandata/cleanscores.csv", row.names = FALSE)



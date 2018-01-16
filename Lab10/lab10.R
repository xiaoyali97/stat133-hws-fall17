head(USArrests)

states <- rownames(USArrests)
head(states)

# number of characters
nchar(states)

# to lower case
tolower(states)

# to upper case
toupper(states)

# case folding (upper = TRUE)
casefold(states, upper = TRUE)

# case folding (upper = FALSE)
casefold(states)

# number of charcaters
num_chars <- nchar(states)

# frequency table
char_freqs <- table(num_chars)

# barchart of number-of-characters
barplot(char_freqs)

# paste names with their num-of-chars
paste(states[1:5],"=",num_chars[1:5], sep = " ")

# collapse first 5 states
paste(states[1:5], collapse = "")

# extract first 3 characters
substr('Berkeley', 1, 3)

# shorten state names with first 3 characters
substr(states, 1, 3)

# shorten state names with last 3 characters
substr(states, num_chars - 2, num_chars)

# shorten state names with first 3 characters
paste0(substr(states,1,1), substr(states, num_chars - 2, num_chars))

# 4-char states
states[num_chars == 4]

# 10-char states
states[num_chars == 10]

# collapse 4-char states
paste(states[num_chars == 4], collapse = ", ")

#write code (using a for-loop) to obtain a list states_list containing the 
#collapsed names by number of characters. If the number of characters is an 
#even number, then the state names should be in capital letters. Otherwise, 
#they should be in lower case letters.

#Each list element of states_list must be named with the number of characters, 
#followed by a dash, followed by the word chars: e.g. '4-chars', '5-chars', etc. 
#In total, states_list should have the same length as char_freqs.

states_list <- vector(mode = "list", length = length(char_freqs))
names(states_list) <- paste0(names(char_freqs), "-chars")
number_list <- as.numeric(names(char_freqs))
for(i in 1:length(char_freqs)){
  states_list[[i]] <- paste(states[num_chars == number_list[i]], collapse = ", ")
  if(number_list[i] %% 2 == 0){
    states_list[[i]] <- toupper(states_list[[i]])
  }else{
    states_list[[i]] <- tolower(states_list[[i]])
  }
}
states_list

#Here are four functions that convert from Fahrenheit degrees to other temperature scales:
to_celsius <- function(x = 1) {
  (x - 32) * (5/9)
}

to_kelvin <- function(x = 1) {
  (x + 459.67) * (5/9)
}

to_reaumur <- function(x = 1) {
  (x - 32) * (4/9)
}

to_rankine <- function(x = 1) {
  x + 459.67
}

#We can use the previous functions to create a more general function temp_convert():
temp_convert <- function(x = 1, to = "celsius") {
  switch(to,
         "celsius" = to_celsius(x),
         "kelvin" = to_kelvin(x),
         "reaumur" = to_reaumur(x),
         "rankine" = to_rankine(x))
}

temp_convert(30, 'celsius')

#Rewrite temp_convert() such that the argument to can be given in upper or lower 
#case letters. For instance, the following three calls should be equivalent:
#   temp_convert(30, 'celsius')
#   temp_convert(30, 'Celsius')
#   temp_convert(30, 'CELSIUS')
#your function temp_convert

temp_convert <- function(x = 1, to = "celsius") {
  to <- tolower(to)
  switch(to,
         "celsius" = to_celsius(x),
         "kelvin" = to_kelvin(x),
         "reaumur" = to_reaumur(x),
         "rankine" = to_rankine(x))
}

temp_convert(30, 'celsius')
temp_convert(30, 'Celsius')
temp_convert(30, 'CELSIUS')

#Imagine that you need to generate the names of 10 data .csv files. All the files 
#have the same prefix name but each of them has a different number: file1.csv, file2.csv, 
#... , file10.csv.
#How can you generate a character vector with these names in R? Come up with at 
#least three different ways to get such a vector:

#1-way:
files_names <- paste("file", 1:10, ".csv", sep = "")
files_names

#2-way:
files_names <- character(length = 10)
for(i in 1:10){
  files_names[i] <- paste0("file", i, ".csv")
}
files_names

#3-way:
files_names <- paste0("file", 1:10, ".csv")
files_names

#4-way:
files_names <- sprintf("file%s.csv", 1:10)
files_names

#Now imagine that you need to rename the characters file into dataset. In other words, 
#you want the vector of file names to look like this: dataset1.csv, dataset2.csv, ... , 
#dataset10.csv. Take the previous vector of file names and rename its elements:
num_filename <- nchar(files_names)
refiles_names <- paste("dataset", substr(files_names, 5, num_filename), sep = "")
refiles_names

# name of output file
outfile <- "output.txt"

# writing to 'outfile.txt'
cat("This is the first line", file = outfile)
# insert new line
cat("\n", file = outfile, append = TRUE)
cat("A 2nd line", file = "output.txt", append = TRUE)
# insert 2 new lines
cat("\n\n", file = outfile, append = TRUE)
cat("\nThe quick brown fox jumps over the lazy dog\n",
    file = outfile, append = TRUE)

#Your turn. Modify the script such that the content of output.txt looks like the 
#yaml header of an .Rmd file with your information:
cat("---", file = outfile)
cat('\ntitle: "Cat output practice"', file = outfile, append = TRUE)
cat('\nauthor: "Xiaoya Li"', file = outfile, append = TRUE)
cat('\ndate: "11/2/2017"', file = outfile, append = TRUE)
cat('\noutput: html_document', file = outfile, append = TRUE)
cat('\n---\n\n', file = outfile, append = TRUE)
# writing to 'outfile.txt'
cat("This is the first line", file = outfile, append = TRUE)
# insert new line
cat("\n", file = outfile, append = TRUE)
cat("A 2nd line", file = "output.txt", append = TRUE)
# insert 2 new lines
cat("\n\n", file = outfile, append = TRUE)
cat("\nThe quick brown fox jumps over the lazy dog\n",
    file = outfile, append = TRUE)

#The function colors() returns a vector with the names (in English) of 657 colors 
#available in R. Write a function is_color() to test if a given name---in English---is 
#a valid R color. If the provided name is a valid R color, is_color() returns TRUE. 
#If the provided name is not a valid R color is_color() returns FALSE.

# your is_color() function
is_color <- function(x){
  if(x %in% colors()){
    return(TRUE)
  }else{
    return(FALSE)
  }
}

# test it:
is_color('yellow')  # TRUE

is_color('blu')     # FALSE

is_color('turkuoise') # FALSE

#Use is_color() to create the function colplot() that takes one argument col 
#(the name of a color) to produce a simple scatter plot with random numbers 
#(e.g. use runif() or rnorm() to get point coordinates).

#If col is a valid name---say "blue"---, the scatterplot should show a title 
#"Testing color blue".

#If the provided col is not a valid color name, e.g. "blu", then the function 
#must stop, showing an error message "invalid color blu".

colplot <- function(x){
  if(is_color(x)){
    plot(x = rnorm(10),
         y = rnorm(10),
         main = paste("Testing color", x))
  }else{
    stop(paste("invalid color", x))
  }
}

# this should plot
colplot('tomato')

# this stops with error message
colplot('tomate')

# random vector of letters
set.seed(1)
letrs <- sample(letters, size = 100, replace = TRUE)
head(letrs)

#Write code in R to count the number of vowels in vector letrs. Test your code 
#with letrs and verify that you get the same counts for each vowel.
letrs_count <- table(letrs)
vowels <- c("a","e","i","o","u")
vowels_count <- letrs_count[names(letrs_count) %in% vowels]
vowels_count

#Now do the same but for the consonants, that is, count the frequencies of consonants 
#in letrs. 
consonants_count <- letrs_count[!names(letrs_count) %in% vowels]
consonants_count

#Write a function count_letters() that takes a vector of letters (e.g. letrs) and 
#computes the total number of letters, the total number of vowels, and the total number 
#of consonants. For instance, given the vector letrs, the function will print on console:
#   "letters: 100"
#   "vowels: 20"
#   "consonants: 80"

# your function count_letters()
count_letters <- function(x){
  #computes total number of letters
  total_letrs <- length(x)
  
  #create a count table
  letrs_count <- table(x)
  #create a list of vowels
  vowels <- c("a","e","i","o","u")
  
  #computes total number of vowels
  vowels_count <- letrs_count[names(letrs_count) %in% vowels]
  total_vowels <- sum(vowels_count)
  
  #computes total number of consonants
  total_consonants <- total_letrs - total_vowels
  
  #print to console
  print(paste("letters:", total_letrs))
  print(paste("vowels:", total_vowels))
  print(paste("consonants:", total_consonants))
}

count_letters(letrs)

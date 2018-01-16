# Title: "Lab 3: Data Frame Basics"
# Subtitle: "Stat 133, Fall 2017"
# Author: "Gaston Sanchez"


# ===============================================
# Creating data frames
# ===============================================

# Start by creating vectors for each of the columns.
player <- c('Thompson', 'Curry', 'Green', 'Durant', 'Pachulia')
position <- c('SG', 'PG', 'PF', 'SF', 'C')
salary <- c(16663575, 12112359, 15330435, 26540100, 2898000)
points <- c(1742, 1999, 776, 1555, 426)
ppg <- c(22.3, 25.3, 10.2, 25.1, 6.1)
rookie <- rep(FALSE, 5)


# Create a first data frame with `data.frame()`.
df1 <- data.frame(
  player,
  position,
  salary,
  points,
  ppg,
  rookie
)


# Check that this data frame is of class `"data.frame"`, 
# and that it is also a list.
class(df1)
is.list(df1)


# Create another data frame by first starting with a `list()`, 
# and then passing the list to `data.frame()`.
variables_list <- list(
  player = player,
  position = position,
  salary = salary,
  points = points,
  ppg = ppg,
  rookie = rookie
)

df2 <- data.frame(variables_list)


# What would you do to obtain a data frame such that when 
# you check its structure `str()` the variables are:
# - _Player_ as character
# - _Position_ as factor
# - _Salary_ as numeric or real (ignore the commas)
# - _Points_ as integer
# - _PPG_ as numeric or real
# - _Rookie_ as logical
df3 <- data.frame(
  player = player,
  position = position,
  salary = salary,
  points = as.integer(points),
  ppg = ppg,
  rookie = rookie,
  stringsAsFactors = FALSE
)
df3$position <- as.factor(df3$position)
str(df3)


# Find out how to use the _column binding_ function `cbind()` to create a 
# tabular object (see what is the class of this object) with your vectors.
df4 <- cbind(
  player,
  position,
  salary,
  points,
  ppg,
  rookie
)
class(df4)

# How could you convert the object in the previous step into a data frame?
df4 <- data.frame(df4)



# ===============================================
# NBA data
# ===============================================

# import data (assuming file is in your working dir)
dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)

# - Display the last 5 rows of the data.
dat[(nrow(dat)-4):nrow(dat), ]
tail(dat, 5)   # equivalent
 
# - Display those rows associated to players having height less than 70 inches tall.
dat[dat$height < 70, ]

# - Of those players that are centers (position `C`), display their names and salaries.
dat[dat$position == 'C', c('player', 'salary')]

# - Create a data frame `durant` with Kevin Durant's information (i.e. row).
durant <- dat[dat$player == "Kevin Durant", ]

# - Create a data frame `ucla` with the data of players from college UCLA
# (University ).
ucla <- dat[dat$college == "University of California, Los Angeles", ]

# - Create a data frame `rookies` with those players with 0 years of experience. 
rookies <- dat[dat$experience == 0, ]

# - Create a data frame `rookie_centers` with the data of Center rookie players. 
rookie_centers <- rookies[rookies$position == 'C', ]

# - Create a data frame `top_players` for players with more than 50 games and 
# more than 100 minutes played.
top_players <- dat[dat$games > 50 & dat$minutes > 100, ]

# - What's the largest height value?
max(dat$height)

# - What's the minimum height value?
min(dat$height)

# - What's the overall average height?
mean(dat$height)

# - Who is the tallest player?
dat$player[which.max(dat$height)]

# - Who is the shortest player?
dat$player[which.min(dat$height)]

# - Which are the unique teams?
unique(dat$team)

# - How many different teams?
length(unique(dat$team))
 
# - Who is the oldest player?
dat$player[which.max(dat$age)]

# - What is the median salary of all players?
median(dat$salary)

# - What is the median salary of the players with 10 years of experience or more?
median(dat$salary[dat$experience >= 10])

# - What is the median salary of Shooting Guards (SG) and Point Guards (PG)?
median(dat$salary[dat$position == 'SG' | dat$position == 'PG'])
median(dat$salary[dat$position %in% c('SG', 'PG')])

# - What is the median salary of Power Forwards (PF), 29 years or older, 
# and 74 inches tall or less?
median(dat$salary[dat$position == 'PG' & dat$age >= 29 & dat$height <= 74])

# - How many players scored 4 points or less?
sum(dat$points < 4)

# - Who are those players who scored 4 points or less?
dat$player[dat$points < 4]

# - Who is the player with 0 points?
dat$player[dat$points == 0] 

# - How many players are from "University of California, Berkeley"? 
sum(dat$college == "University of California, Berkeley")

# - How many players are from "University of Notre Dame"? 
sum(dat$college == "University of Notre Dame")

# - Are there any players with weight greater than 260 pounds? 
# If so how many and who are they?
sum(dat$weight > 260)
dat$player[dat$weight > 260]

# - How many players did not attend a college in the US?
sum(dat$college == "")
 
# - Who is the player with the maximum rate of points per minute?
dat$player[which.max(dat$points / dat$minutes)]

# - Who is the player with the maximum rate of three-points per minute?
dat$player[which.max(dat$points3 / dat$minutes)]

# - Who is the player with the maximum rate of two-points per minute?
dat$player[which.max(dat$points2 / dat$minutes)]

# - Who is the player with the maximum rate of one-points (free-throws) 
# per minute?
dat$player[which.max(dat$points1 / dat$minutes)]


# ===============================================
# Sorting operations
# ===============================================

# Create a data frame 'gsw' with the name, height, weight of Golden State Warriors (GSW)
gsw <- dat[dat$team == "GSW", c('player', 'height', 'weight')]

# Display the data in gsw by height in increasing order
gsw[order(gsw$height), ]

# Display the data in gsw by weight in decreasing order
gsw[order(gsw$weight, decreasing = TRUE), ]

# Display the player name, team, and salary, of the top 5 highest-paid players
head(dat[order(dat$salary, decreasing = TRUE),c('player', 'team', 'salary')], n = 5)

# Display the player name, team, and points3, of the top 10 three-point players
head(dat[order(dat$points3, decreasing = TRUE),c('player', 'team', 'points3')], n = 10)


# ===============================================
# Group By operations
# ===============================================

# - Create a data frame with the average height, average weight, and average 
# age, grouped by position
aggregate(dat[ ,c('height', 'weight', 'age')], by = list(dat$position), FUN = mean)
aggregate(. ~ position, data = dat[ ,c('height', 'weight', 'age', 'position')], 
          FUN = mean)

# - Create a data frame with the average height, average weight, and average 
# age, grouped by team
aggregate(dat[ ,c('height', 'weight', 'age')], by = list(dat$team), FUN = mean)
aggregate(. ~ team, data = dat[ ,c('height', 'weight', 'age', 'team')], 
          FUN = mean)

# - Create a data frame with the average height, average weight, and average 
# age, grouped by team and position.
hwa_by_tp <- aggregate(
  dat[ ,c('height', 'weight', 'age')], 
  by = list(dat$team, dat$position), 
  FUN = "mean")

# - Difficult: Create a data frame with the minimum salary, median salary,
# mean salary, and maximum salary, grouped by team and position.
salary_by_tp <- aggregate(
  dat$salary, by = list(team = dat$team), 
  FUN = function(x) c(min = min(x), med = median(x), avg = mean(x), max = max(x)))


# ===================================================================
# Title: Lab 06
# Description:
#   This script practice exporting tables, exporting R output (as is),
#   exporting plot images, Learn about "dplyr" pipelines, Get to know 
#   the pipe operator %>%, Chain dplyr operations with the piper
# Input(s): data file "nba2017-player.csv"
# Output(s): data file in .csv
#            output file in .txt
#            images file in .png, .jpeg, .pdf
# Author: Xiaoya Li
# Date: 10-05-2017
# ===================================================================

# packages
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics

#Use read_csv() from the package "readr" to import the data nba2017-players.csv in R.
raw_dat <- read_csv("../data/nba2017-players.csv")

#Create one data frame warriors by selecting rows---e.g. filter()---of Golden State 
#Warriors, arranging rows by salary (increasingly).
warriors <- arrange(filter(raw_dat, team == "GSW"), salary)

#Use the function write.csv() to export (or save) the data frame warriors to a data 
#file warriors.csv in the folder/ directory. You will need to use a relative path 
#to specify the file argument. Also, see how to use the argument row.names to avoid 
#including a first column of numbers.
write.csv(warriors, file = "../data/warriors.csv", row.names = FALSE)

#Create another data frame lakers by selecting rows of Los Angeles Lakers, this time 
#arranging rows by experience (decreasingly).
lakers <- arrange(filter(raw_dat, team == "LAL"), desc(experience))

#Now use the function write_csv() to export (or save) the data frame lakers to a data
#file lakers.csv in the folder/ directory. You will also need to use a relative path 
#to specify the file argument.
write.csv(lakers, file = "../data/lakers.csv", row.names = FALSE)

#Export the output str() on the data frame with all the players to a text file 
#data-structure.txt, in the output/ folder.
sink(file = "../output/data-structure.txt")
str(raw_dat)
sink()

#Export the summary() of the entire data frame warriors to a text file 
#summary-warriors.txt, in the output/ folder.
sink(file = "../output/summary-warriors.txt")
summary(warriors)
sink()

#Export another summary() of the entire data frame lakers to a text file 
#summary-lakers.txt, in the output/ folder.
sink(file = "../output/summary-lakers.txt")
summary(warriors)
sink()

#Open the help documentation of png() and related graphic devices.
?png

#Use png() to save a scatterplot of height and weight with plot(). Save 
#the graph in the images/ folder.
png(filename = "../images/scatterplot-of-height-weight.png")
plot(raw_dat$height, raw_dat$weight, pch = 20, xlab = 'Height', ylab = 'Weight')
dev.off()

#Save another version of the scatterplot between height and weight, but 
#now try to get an image with higher resolution. Save the plot in images/.
png(filename = "../images/scatterplot-of-height-weight-higher-resolution.png", 
    pointsize = 20)
plot(raw_dat$height, raw_dat$weight, pch = 20, xlab = 'Height', ylab = 'Weight')
dev.off()


#Save a histogram in JPEG format of age with dimensions (width x height) 
#600 x 400 pixels. Save the plot in images/.
jpeg(filename = "../images/histogram-of-age.jpeg", width = 600, height = 400)
hist(raw_dat$age, xlab = "Age", main = "Histogram of Age")
dev.off()

#Use pdf() to save the previous histogram of age in PDF format, with dimensions 
#(width x height) 7 x 5 inches.
pdf(file = "../images/histogram-of-age.pdf", width = 7, height = 5)
hist(raw_dat$age, xlab = "Age", main = "Histogram of Age")
dev.off()

# Use ggplot() to make a scatterplot of points and salary, and store it in a ggplot 
# object named gg_pts_salary. Then use ggsave() to save the plot with dimensions 
# (width x height) 7 x 5 inches; in the images/ folder as points_salary.pdf
ggplot(data = raw_dat, aes(x = points, y = salary)) +
  geom_point()
ggsave(filename = "../images/points_salary.pdf", width = 7, height = 7)

# Use ggplot() to create a scatterplot of height and weight, faceting by position. 
# Store this in a ggplot object gg_ht_wt_positions Then use ggsave() to save the plot 
# with dimensions (width x height) 6 x 4 inches; in the images/ folder as 
# height_weight_by_position.pdf
gg_ht_wt_positions <- ggplot(data = raw_dat, aes(x = height, y = weight)) +
  geom_point(aes(col = position)) +
  facet_wrap(~ position)
gg_ht_wt_positions
ggsave(filename = "../images/height_weight_by_position.pdf", 
       plot = gg_ht_wt_positions, width = 6, height = 4, units = "in")


# display the player names of Lakers 'LAL'
lakers %>%
  select(player)

# display the name and salary of GSW point guards 'PG'

warriors %>%
  filter(position == "PG") %>%
  select(player, salary)
  
# dislay the name, age, and team, of players with more than 10 years of experience, 
# making 10 million dollars or less.
raw_dat %>% 
  filter(experience > 10 & salary <= 10000000) %>% 
  select(player, age, team)

# select the name, team, height, and weight, of rookie players, 20 years old, displaying 
# only the first five occurrences (i.e. rows)
raw_dat %>%
  filter(experience == 0 & age == 20) %>% 
  select(player, team, height, weight) %>% 
  slice(1 : 5)
  
# create a data frame gsw_mpg of GSW players, that contains variables for player name, 
# experience, and min_per_game (minutes per game), sorted by min_per_game (in descending order)

gsw_mpg <- warriors %>% 
  mutate(min_per_game = minutes / games) %>% 
  select(player, experience, min_per_game) %>% 
  arrange(desc(min_per_game))
gsw_mpg

# display the average triple points by team, in ascending order, of the bottom-5 teams (worst 
# 3pointer teams)
raw_dat %>% 
  group_by(team) %>%  
  summarise(ave_points3 = mean(points3)) %>% 
  arrange(ave_points3) %>% 
  slice(1:5)
  
# obtain the mean and standard deviation of age, for Power Forwards, with 5 and 10 years of 
# experience  
raw_dat %>% 
  filter(position == "PF" & (experience == 5 | experience == 10)) %>% 
  summarise(mean(age), sd(age))
  




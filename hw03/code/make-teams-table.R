# ===================
# title: Make teams table
# description: 
#   This script prepares the data for analysis.
# input(s): nba2017-roster.csv
#           nba2017-stats.csv
# output(s): nba2017-teams.csv
# ===================

# packages
library(dplyr)
library(ggplot2)

# import data 
nba_roster <- read.csv("./stat133-hws-fall17/hw03/data/nba2017-roster.csv")
nba_stat <- read.csv("./stat133-hws-fall17/hw03/data/nba2017-stats.csv")

# Adding new variables
nba_stat <- mutate(
  nba_stat, 
  missed_fg = field_goals_atts - field_goals_made,
  missed_ft = points1_atts - points1_made,
  points = points3_made * 3 + points2_made * 2 + points1_made,
  # TODO
  #points = points3_made  + points2_made  + points1_made,
  rebounds = off_rebounds + def_rebounds,
                   
  efficiency = (points + rebounds + assists + steals + blocks - missed_fg 
                - missed_ft - turnovers) / games_played
  )

sink(file = "./stat133-hws-fall17/hw03/output/efficiency-summary.txt")
summary(nba_stat$efficiency)
sink()

# Merging Tables
nba_roster_stat <- merge(nba_roster, nba_stat)

# Creating nba2017-teams.csv
teams <- nba_roster_stat %>% 
  group_by(team) %>% 
  summarise(
    # TODO 
    #experience = round(sum(experience), 2),
    experience = round(mean(experience), 2),
    salary = round(sum(salary) / 1000000, 2),
    points3 = sum(points3_made),
    points2 = sum(points2_made),
    free_throws = sum(points1_made),
    points = sum(points),
    off_rebounds = sum(off_rebounds),
    def_rebounds = sum(def_rebounds),
    assists = sum(assists),
    steals = sum(steals),
    blocks = sum(blocks),
    turnovers = sum(turnovers),
    fouls = sum(fouls),
    efficiency = sum(efficiency)
  )
teams$team <- as.character(teams$team)

sink(file = "./stat133-hws-fall17/hw03/output/teams-summary.txt")
summary(teams)
sink()

write.csv(teams, file = "./stat133-hws-fall17/hw03/data/nba2017-teams.csv", 
          row.names = FALSE)

# Some graphics

pdf(file = "./stat133-hws-fall17/hw03/images/teams_star_plot.pdf", width = 5, height = 7)
stars(teams[ ,-1], labels = teams$team, main = "Star plot of teams")
dev.off()

pdf(file = "./stat133-hws-fall17/hw03/images/experience_salary.pdf", width = 7, height = 5)
ggplot(data = teams, aes(x = experience, y = salary)) +
  geom_point() +
  geom_text(aes(label = team), vjust = 1.5) +
  scale_y_continuous(limits=c(25, 175)) +
  scale_x_continuous(limits = c(2,9))
dev.off()





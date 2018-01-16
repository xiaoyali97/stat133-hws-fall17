library(XML)
library(xml2)
library(rvest)
library(magrittr)

# Assemble url (so it fits on screen)
basket <- "https://www.basketball-reference.com"
gsw <- "/teams/GSW/2017.html"
gsw_url <- paste0(basket, gsw)

# download HTML file to your working directory
download.file(gsw_url, 'gsw-roster-2017.html')

# Read GSW Roster html table
gsw_roster <- readHTMLTable('gsw-roster-2017.html')
gsw_roster



# Assemble url (so it fits on screen)
basket <- "https://www.basketball-reference.com"
bos <- "/teams/BOS/2017.html"
bos_url <- paste0(basket, bos)

# download HTML file to your working directory
download.file(bos_url, 'bos-roster-2017.html')

# Read BOS Roster html table
bos_roster <- readHTMLTable('bos-roster-2017.html')


#read the contents of the html file
nba_html <- paste0(basket, "/leagues/NBA_2017.html")

xml_doc <- read_html(nba_html)
xml_text <- xml_doc %>% html_text()


# content of h2 nodes
xml_doc %>%
  html_nodes("h2") %>%
  html_text() 

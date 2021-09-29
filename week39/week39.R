library(tidyverse)
library(tidytuesdayR)


tuesdata <- tidytuesdayR::tt_load(2021, week = 39)
nominees <- tuesdata$nominees
write.csv2(nominees, "nominees.csv")

got <- nominees %>% filter(title %in% c("Game Of Thrones"))

glimpse(got)
got$logo <- NULL
got$production <- NULL
got$page <- NULL
got$page_id <- NULL

got_clean <- got %>% 
  arrange(year) %>% 
  distinct(category, type, title, distributor, producer, year, .keep_all = TRUE)



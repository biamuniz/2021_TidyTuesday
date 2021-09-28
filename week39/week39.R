install.packages("tidytuesdayR")
library(tidyverse)

esquisse::esquisser()
tuesdata <- tidytuesdayR::tt_load(2021, week = 39)
nominees <- tuesdata$nominees
write.csv2(nominees, "nominees.csv")

got <- nominees %>% filter(title %in% c("Game Of Thrones"))



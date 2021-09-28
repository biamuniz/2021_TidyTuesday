install.packages("tidytuesdayR")
library(tidyverse)

esquisse::esquisser()

tuesdata <- tidytuesdayR::tt_load('2021-09-21')
tuesdata <- tidytuesdayR::tt_load(2021, week = 39)

nominees <- tuesdata$nominees


winners <- nominees %>% filter(type %in% c("Winner"))

# Carregando pacotes
library(rvest)
library(tidyverse)
library(stringr)
library(plyr)
library(httr)
library(ggthemes)
library(tidytext)
library(wordcloud)
library(ggridges)
library(wesanderson)
library(yarrr)
library(knitr)
library(kableExtra)
library(radarchart)
library(textdata)

df <- read.csv2("paramorelyricslimpo.csv")

# tokenized and cleaned datasets of lyrics for textual analysis
tidy_paramore <- df %>% unnest_tokens(word, lyrics)
tidier_paramore <- tidy_paramore %>% anti_join(rbind(stop_words[1], "uh", "yeah", "hey", "baby", "ooh", "wanna", "gonna", "ah", "ahh", "ha", "la", "mmm", "whoa", "haa"))
tidier_paramore$word[tidier_paramore$word == "don" | tidier_paramore$word == "didn"] <- NA
tidier_paramore$word[tidier_paramore$word == "ain"] <- NA
tidier_paramore$word[tidier_paramore$word == "isn"] <- NA
tidier_paramore$word[tidier_paramore$word == "usin"] <- "using"
tidier_paramore$word[tidier_paramore$word == "wouldn"] <- "wouldn't"
tidier_paramore$word[tidier_paramore$word == "couldn"] <- "couldn't"
tidier_paramore$word[tidier_paramore$word == "shouldn"] <- "shouldn't"
tidier_paramore$word[tidier_paramore$word == "won"] <- "won't"
tidier_paramore$word[tidier_paramore$word == "ve" | tidier_paramore$word == "ll"] <- NA
tidier_paramore <- na.omit(tidier_paramore)
tidier_paramore$word[tidier_paramore$word == "ileft"] <- "left"





# joining the tokenized, tidied lyric dataset with sentiment lexicons
paramore_nrc_sub <- tidier_paramore %>%
  inner_join(get_sentiments("nrc")) %>%
  filter(!sentiment %in% c("positive", "negative"))


write_delim(paramore_nrc_sub,"paramore-nrcsub.csv",delim = ";")


# all-album radar chart
sentiment_nrc <- paramore_nrc_sub %>%
  group_by(album_name, sentiment) %>%
  count(album_name, sentiment) %>% 
  select(album_name, sentiment, sentiment_total = n)

album_nrc <- paramore_nrc_sub %>%
  count(album_name) %>% 
  select(album_name, album_total = n)

radar_chart <- sentiment_nrc %>% 
  inner_join(album_nrc, by = "album_name") %>% 
  mutate(percent = round((sentiment_total/album_total * 100), 3)) %>% 
  select(-sentiment_total, -album_total) %>%
  spread(album_name, percent)

radar_chart <- radar_chart[c(1,2,3,4,5,6,7,8), c(1, 6:2)]

chartJSRadar(radar_chart, polyAlpha = 0.1, lineAlpha = 0.8, maxScale = 25,
             colMatrix = matrix(c(0, 255, 255, 255, 185, 15, 139, 0, 139, 
                                  255, 0, 0, 201, 167, 198, 0, 0, 0), byrow = F, nrow = 3))



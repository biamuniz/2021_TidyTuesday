# Carregando pacotes
library(rvest)
library(tidyverse)
library(stringr)
library(plyr)
library(httr)
library(ggthemes)
library(tidytext)
library(RColorBrewer)
library(wordcloud2)
library(tm)

####################### Webscraping
artist_url <- 'http://www.songlyrics.com/my-chemical-romance-lyrics/'

song_nodes <- read_html(artist_url) %>% # load the html
  html_nodes("#colone-container .tracklist a")

song_nodes[1:3]

# grab the song titles
song_titles <-  html_text(song_nodes)
song_titles[1:3]


# grab the song titles
song_links <-  html_attr(song_nodes, name='href')
song_links[1:3]

# data frame to store 
lyrics <- tibble()
for(i in 1:length(song_links[1:306])){ # onl
  
  # always nice to know where a long program is
  message(str_c('scraping song ', i, ' of ', length(song_links) ))
  
  # scape the text of a song
  lyrics_scraped <- song_links[i] %>%
    read_html() %>% 
    html_nodes("#songLyricsDiv") %>%
    html_text()
  
  
  # format the song name for the data frame
  song_name <- song_titles[i] %>% 
    str_to_lower() %>% 
    gsub("[^[:alnum:] ]", "", .) %>%
    gsub("[[:space:]]", "_", .)
  
  # add song to lyrics data frame
  lyrics <- rbind(lyrics, tibble(text=lyrics_scraped, artist = 'my chemical romance', song=song_name) )
  
  # pause so we don't get banned!
  Sys.sleep(10) 
}

# saving the df in a CSV file
write_delim(lyrics,"mcr.csv",delim = ";")

####################### CLEANING
# before going to the next step, I added the column "album" in the dataset using excel (it was not necessary for textual analysis)
tidy_mcr <- read.csv2("mcr.csv", sep = ";")


# tokenized and cleaned datasets of lyrics for textual analysis
tidy_mcr <- tidy_mcr %>% unnest_tokens(word, lyric)
tidier_mcr <- tidy_mcr %>% anti_join(rbind(stop_words[1], "uh", "yeah", "hey", "baby", "ooh", "wanna", "gonna", "ah", "ahh", "ha", "la", "mmm", "whoa", "haa"))
tidier_mcr$word[tidier_mcr$word == "don" | tidier_mcr$word == "didn"] <- NA
tidier_mcr$word[tidier_mcr$word == "ain"] <- NA
tidier_mcr$word[tidier_mcr$word == "isn"] <- NA
tidier_mcr$word[tidier_mcr$word == "usin"] <- "using"
tidier_mcr$word[tidier_mcr$word == "wouldn"] <- "wouldn't"
tidier_mcr$word[tidier_mcr$word == "couldn"] <- "couldn't"
tidier_mcr$word[tidier_mcr$word == "shouldn"] <- "shouldn't"
tidier_mcr$word[tidier_mcr$word == "won"] <- "won't"
tidier_mcr$word[tidier_mcr$word == "ve" | tidier_mcr$word == "ll"] <- NA
tidier_mcr <- na.omit(tidier_mcr)
tidier_mcr$word[tidier_mcr$word == "ileft"] <- "left"

# saving the df in a CSV file
write_delim(tidier_mcr,"tdrmcr.csv",delim = ";")

# how many tracks does the word "sing" appear in?
tidier_mcr %>% 
  select(song, word) %>% 
  filter(word == "sing") %>% 
  unique() %>% 
  select(song)

####################### WORDCLOUD
set.seed(1234)
scale=c(3.5,0.25)
wordcloud2(data=df, size=1, color='random-dark')

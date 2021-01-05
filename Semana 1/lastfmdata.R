library(tidyverse)
library(readxl)
library(ggplot2)
library(plotly)

df <- read_excel("lastfm.xlsx", sheet=1, col_names=TRUE)


TOP %>%
  bar_chart(x = ALBUM, y = SCROBBLES, fill = ARTISTA, top_n = 10) +
  labs(x = "Álbum", y = "Quantidade de scrobbles", title = "Os dez álbuns que mais escutei em 2020, de acordo com o Last.fm", subtitle = "\"Apká!\", foi álbum com mais scrobbles; Céu e Emicida aparecem duas vezes no top 10", fill = "Artista")


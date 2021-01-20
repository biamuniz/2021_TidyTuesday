library(ggiraph)
library(tidyverse)

dados <- read.csv2("bbbibope.csv")

BBB_ibope <- ggplot(dados) +
  aes(x = Edição, weight = `Estreia`, tooltip = Estreia, data_id = Edição) +
  geom_bar_interactive(fill = "#d8576b") +
  labs(x = "Edição", y = "Pontos no Ibope", title = "Ibope na estreia do BBB", subtitle = "Audiência da estreia do reality caiu 24 pontos nos últimos 20 anos") +
  theme_minimal()

girafe(ggobj = BBB_ibope)
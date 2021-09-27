library(tidyverse)
library(dplyr)
library(cowplot)
library(magick)
library(cowplot)
library(esquisse)
library(ggplot2)
library(rsvg)
library(ggtextures)
library(extrafont)


dados <- read.csv2('pkmn.csv')

image = list(
  image_read_svg("C:/.../water.svg"),
  image_read_svg("C:/.../normal.svg"),
  image_read_svg("C:/.../poison.svg"),
  image_read_svg("C:/.../fire.svg"),
  image_read_svg("C:/.../grass.svg"),
  image_read_svg("C:/.../bug.svg"),
  image_read_svg("C:/.../electric.svg"),
  image_read_svg("C:/.../rock.svg"),
  image_read_svg("C:/.../psychic.svg"),
  image_read_svg("C:/.../ground.svg"),
  image_read_svg("C:/.../fighting.svg"),
  image_read_svg("C:/.../dragon.svg"),
  image_read_svg("C:/.../ghost.svg"),
  image_read_svg("C:/.../fairy.svg"),
  image_read_svg("C:/.../ice.svg"))


ggplot(dados, aes(x = reorder(Tipo, Quantidade), y = Quantidade, fill = "#F9E388", image = image)) +
  geom_isotype_col(
    img_height = grid::unit(1, "null"), img_width = NULL,
    ncol = 1, nrow = 1, hjust = 1, vjust = 0.5
  ) +
  coord_flip() +
  guides(fill = "none") +
  labs(x = "Tipo", y = "Quantidade", title = "Qual é o tipo de Pokémon mais frequente na primeira geração?", subtitle = "Tipo é uma classificação que define os pontos fortes e fracos de cada Pokémon")
  ggthemes::theme_wsj()

  
  
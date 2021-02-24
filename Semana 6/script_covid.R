install.packages("gridExtra")
install.packages("hrbrthemes")
library(xlsx)
library(dplyr)
library(gganimate)
library(tidyverse)
library(ggplot2)
library(viridis)
library(grid)
library(gridExtra)
library(hrbrthemes)
library(scales)
library(esquisse)
esquisse::esquisser()

dados <- read.csv2('covidbr.csv')
cajamar  <- dados %>% filter(municipio %in% c("Cajamar"))
rm(dados)
cajamar$regiao <- NULL
cajamar$estado <- NULL
cajamar$municipio <- NULL
cajamar$coduf <- NULL
cajamar$codmun <- NULL
cajamar$codRegiaoSaude <- NULL
cajamar$nomeRegiaoSaude <- NULL
cajamar$Recuperadosnovos <- NULL
cajamar$emAcompanhamentoNovos <- NULL
cajamar$interior.metropolitana <- NULL
cajamar$obitosNovos <- NULL
cajamar$casosNovos <- NULL
cajamar$populacaoTCU2019 <- NULL
write.csv2(cajamar, "cajamar.csv")

dados <- read.csv2("cajamar.csv")

plot <- ggplot(dados) +
  aes(x = Dia, y = casosAcumulado) +
  geom_line(size = 1.48, colour = "#35b779") +
  labs(x = "Dias de pandemia", y = "Número de casos acumulado", title = "300 dias de pandemia", subtitle = "Casos acumulados de Covid-19 a partir do dia 27/03 em Cajamar", caption = "Dados do Ministério da Saúde, atualizados no dia 23/02/2021 às 18:50") +
  hrbrthemes::theme_modern_rc() +
  scale_y_continuous(labels = comma) +
  transition_reveal(Dia)


anim_save("dados.gif", plot)


           
# Remodelagem de Dados com tidyr


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Instalando e carregando os pacotes

install.packages("tidyr")

library(tidyr)
library(ggplot2)



# Criando dados de notas em disciplinas

dados <- data.frame(
  Nome = c("Geografia", "Literatura", "Biologia"),
  Regiao_A = c(97, 80, 84),
  Regiao_B = c(86, 90, 91)
)
View(dados)


# função gather() é usada para transformar essas variáveis em uma única coluna Regiao e seus respectivos valores em 
# outra coluna NotaFinal. 

dados_gather <- 
  dados %>% 
  gather(Regiao, NotaFinal, Regiao_A:Regiao_B)




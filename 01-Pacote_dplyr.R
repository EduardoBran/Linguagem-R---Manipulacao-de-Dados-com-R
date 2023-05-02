# Limpeza, Formatação e Manipulação de Dados em R

# dplyr - Transformação de Dados

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Instalando e carregando os pacotes

install.packages("readr")
install.packages("dplyr")

library(readr)
library(dplyr)



# Carregando o dataset

sono_df <- read_csv("sono.csv")

View(sono_df)

head(sono_df)
class(sono_df)
str(sono_df)


# Função glimpse() pode ser usada no lugar da função str() para visualizar as informações do conjunto de dados de forma resumida.

glimpse(sono_df)



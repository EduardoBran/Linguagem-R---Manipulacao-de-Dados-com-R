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



# Aplicando mutate junto com glimpse() para criar uma nova coluna e apenas visualizar de maneira rápida

glimpse(mutate(sono_df, peso_libras = sono_total / 0.45359237))



# Contagem

count(sono_df, cidade)
count(sono_df, pais)


# Histograma

hist(sono_df$sono_total)
hist(sono_df$peso)




# Amostragem (vai no dataset e coleta uma amostra de tamanho 10, bastante útilo em análises estatítiscas)

sample_n(sono_df, size = 10)



# Função select()

sleep_nome_sonototal <- select(sono_df, nome, sono_total)   # cria um novo df com apenas as colunas nome e sono_total

View(select(sono_df, nome))

View(select(sono_df, nome:cidade))     # retorna todas as colunas de nome até cidade
View(select(sono_df, nome:sono_total)) # retorna todas as colunas de nome até sono_total






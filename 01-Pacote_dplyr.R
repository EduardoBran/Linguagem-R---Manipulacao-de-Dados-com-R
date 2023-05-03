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



# Função filter() - retornando dados filtrados

View(filter(sono_df, sono_total >= 16))
View(filter(sono_df, sono_total >= 16, peso >= 80))

View(filter(sono_df, pais == 'Brasil'))

View(filter(sono_df, cidade %in% c('Recife', 'Curitiba')))   # retorna somente dados com as cidades selecionadas



# Função arrange() - é usada para reorganizar as linhas de um conjunto de dados com base nos valores de uma ou mais colunas.

sono_df_arrange <- sono_df %>%  arrange(cidade) # reorganizado coluna cidade para que fique em ordem crescente


sono_df_arrange2 <-                             
  sono_df %>%
  select(nome, cidade, sono_total) %>%          # seleciona as coluna
  arrange(cidade, sono_total)                   # reorganiza em ordem crescente primeiro cidade depois sono_total


sono_df_arrange3 <-                             
  sono_df %>%
  select(nome, cidade, sono_total) %>%          
  arrange(cidade, sono_total) %>% 
  filter(sono_total >= 10)                      # aplicando filtro


sono_df_arrange4 <- 
  sono_df %>%
  select(nome, cidade, sono_total) %>%          
  arrange(cidade, desc(sono_total)) %>%         # coluna sono_total em ordem decrescente
  filter(sono_total >= 10)



# Função mutate() - adiciona uma nova coluna realizando cálculos

sono_df_mutate <- 
  sono_df %>% 
  mutate(novo_indice = sono_total / peso)      # adicionada coluna novo_indice


sono_df_mutate2 <- 
  sono_df %>% 
  mutate(novo_indice = sono_total / peso,      # adicionada coluna novo_indice   
         peso_libras = peso / 0.45359237)      # adicionada coluna peso_libras   
  


# Função summarize() - é usada para resumir dados e calcular estatísticas agregadas com base em grupos de observações definidos em uma ou mais colunas. 

sono_df_summarize <- 
  sono_df %>% 
  summarise(media_sono = mean(sono_total))     # retorna a média da coluna sono_total


sono_df_summarize2 <- 
  sono_df %>% 
  summarise(media_sono_total = mean(sono_total),
            min_sono_total = min(sono_total),        # valor mínimo
            max_sono_total = max(sono_total),        # valor máximo
            total = n())                             # numero total de observações



# Função group_by() - é usada para agrupar


sono_df_group_by <- 
  sono_df %>% 
  group_by(cidade) %>%                               # agrupando  por cidade
  summarise(media_sono_total = mean(sono_total))     # retorna a média da coluna sono_total de cada cidade


sono_df_group_by2 <- 
  sono_df %>% 
  group_by(cidade) %>%                               # agrupando  por cidade
  summarise(media_sono_total = mean(sono_total),
            min_sono_total = min(sono_total),
            max_sono_total = max(sono_total))   







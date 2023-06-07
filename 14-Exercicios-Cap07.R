# Lista de Exercícios - Capítulo 7 


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()


# Carregando pacotes

library(rvest)     # é usado para extrair dados de páginas da web. 
library(dplyr)     # manipulação de dados
library(stringr)   # manipulação de strings
library(tidyr)     # manipulação e organização de dados (separar e combinar colunas de dados)
library(tibble)    # manipula para transformar coluna em índice

library(ggplot2)


# Exercício 1 - Faça a leitura da url abaixo e grave no objeto pagina
# http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I

pagina <- read_html("http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I")
pagina





# Exercício 2 - Da página coletada no item anterior, extraia o texto que contenha as tags:
# #detailed-forecast e .forecast-text

results <- 
  pagina %>% 
  html_nodes("#detailed-forecast")

dia_semana <- 
  results %>% 
  html_nodes(".forecast-label") %>% 
  html_text(trim = TRUE)

dia_semana

texto <- 
  results %>% 
  html_nodes(".forecast-text") %>% 
  html_text(trim = TRUE)

texto



# Exercício 3 - Transforme o item anterior em texto

df <- data.frame(dia_semana = dia_semana, previsao = texto)

df <- column_to_rownames(df, var = "dia_semana") # transforma coluna em índice

View(df)





# Exercício 4
# - Extraia a página web 'http://espn.go.com/nfl/superbowl/history/winners' 
#   e em seguida faça a coleta da tag "table"

url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)
pagina

results <- html_table(pagina, fill = TRUE) 
results



# Exercício 5 - Converta o item anterior em um dataframe

df_superbowl <- data.frame(results[[1]])
View(df_superbowl)



# Exercício 6 - Remova as duas primeiras linhas e adicione nomes as colunas

df_superbowl <- df_superbowl[-1, ]
colnames(df_superbowl) <- df_superbowl[1, ]
df_superbowl <- df_superbowl[-1, ]
rownames(df_superbowl) <- NULL                 # Redefinir os índices das linhas

View(df_superbowl)




# Exercício 7 - Converta os algoritmos romanos para números inteiros

df_superbowl$NO. <- 1:57

str(df_superbowl)
View(df_superbowl)




# Exercício 8 - Divida a coluna em 'RESULT' nas colunas 'WINNER', 'LOSER' e 'SCORE'






# Exercício 9 - Inclua mais 2 colunas com o score dos vencedores e perdedores
# Dica: Você deve fazer mais uma divisão nas colunas




# Exercício 10 - Grave o resultado em um arquivo csv





# Exercício 11 - https://pt.wikipedia.org/wiki/Copa_do_Brasil_de_Futebol#Campeões
# Colete da página dados e monte um dataframe com:
# - Índice com o ano
# - Coluna Campeão, Vice, Artilheiro


# extraindo dados da estrutra da pagina

webpage <- read_html("https://pt.wikipedia.org/wiki/Copa_do_Brasil_de_Futebol#Campeões")


# extraindo todas as tabelas de webpage

tabelas <- html_table(webpage, fill = TRUE)                    #  [[7]] campeões [[12]] artilheiros
tabelas


# extraindo e editando tabela de campeões

# extraindo
tabela_campeoes <- tabelas[[7]]

# transformando primeira linha em nome de coluna
colnames(tabela_campeoes) <- tabela_campeoes[1, ]

# renomeando nome da coluna
colnames(tabela_campeoes)[colnames(tabela_campeoes) == "(vde)Ano"] <- "Ano"


# editando conteúdo da coluna "Ano"
tabela_campeoes$Ano <- gsub("Detalhes", "", tabela_campeoes$Ano)

# convertendo coluna "Anos" para o tipo factor
tabela_campeoes$Ano <- as.factor(tabela_campeoes$Ano)
summary(tabela_campeoes)

# excluindo primeira e última linha
tabela_campeoes <- tabela_campeoes[-1, ]
tabela_campeoes <- tabela_campeoes[-35, ]

# exibindo somente as colunas escolhidas
tabela_campeoes <- 
  tabela_campeoes %>% 
  select(Ano, Campeão, Vice)

View(tabela_campeoes)


# extraindo e editando tabela de artilharia

# extraindo
tabela_artilheiros <- tabelas[[12]]

# convertendo coluna "Anos" para o tipo factor
tabela_artilheiros$Ano <- as.factor(tabela_artilheiros$Ano)

View(tabela_artilheiros)


# Unindo os dois dataframes em um só de acordo com a coluna 'Ano"

df_juntos <- merge(tabela_campeoes, tabela_artilheiros, by = 'Ano')
View(df_juntos)

# Agrupar os dados por ano e combinar os artilheiros em uma única linha

df_final <- aggregate(. ~ Ano, data = df_juntos, FUN = function(x) paste(x, collapse = ", "))
View(df_final)

# Editando colunas Campeão, Vice e Gols para ter somente o primeiro valor

df_final <- 
  df_final %>%
  separate(Campeão, into = c("Campeão", "Outros_Campeão"), sep = ",", extra = "drop") %>%
  select(-Outros_Campeão)

df_final <- 
  df_final %>%
  separate(Vice, into = c("Vice", "Outros_Vice"), sep = ",", extra = "drop") %>%
  select(-Outros_Vice)

df_final <- df_final %>%
  separate(Gols, into = c("Gols", "Outros_Gols"), sep = ",", extra = "drop") %>%
  select(-Outros_Gols)


# Convertendo colunas para o tipo factor
df_final$Campeão <- as.factor(df_final$Campeão)
df_final$Vice <- as.factor(df_final$Vice)
summary(df_final)

View(df_final)







  

# Site OGol Web Scraping em R


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Todos-os-scripts")
getwd()




library(rvest)              # utilizado para fazer a extração de informações de páginas da web           
library(stringr)            # fornece funções para manipulação de strings de texto de forma eficiente     
library(dplyr)              # fornece um conjunto de funções que permitem filtrar, transformar, resumir e combinar dados
library(lubridate)          # permite realizar operações comuns em datas
library(readr)              # conjunto de funções rápidas e eficientes para importar e ler dados tabulares em R
library(xml2)

library(readxl)
library(writexl)
library(tidyverse)



# Leitura da Web Page - Retorna um documento XML que representa toda a estrutura da página web 

webpage <- read_html("https://www.ogol.com.br/jogador.php?id=394508&search=1")
webpage


# Extrair a tabela da página usando a função html_table() (não pega tabela com dados tipo "carregar")

tabela <- html_table(webpage, fill = TRUE)
tabela

tabela_temporada <- tabela[[5]]

View(tabela_temporada)



# Outra abordagem (Wikipedia)

# Leitura da Web Page - Retorna um documento XML que representa toda a estrutura da página web 

webpage <- read_html("https://pt.wikipedia.org/wiki/Zlatan_Ibrahimović")
webpage

# Extrair a tabela da página usando a função html_table() (não pega tabela com dados tipo "carregar")

tabela <- html_table(webpage, fill = TRUE)
tabela

# Converter lista em dataframe

df <- tabela[[6]]
df_sel <- tabela[[7]]
df <- as.data.frame(df)
df_sel <- as.data.frame(df_sel)

View(df)
View(df_sel)

# salvando df

write.csv(l_messi, "lionel_messi.csv")
write.csv(l_messi_sel, "lionel_messi_sel.csv")


write_xlsx(l_messi, "l_messi_EXCEL.xlsx")





# carregando df

l_messi <- read.csv("lionel_messi.csv")
l_messi <- l_messi[, -1]

neymar <- read.csv("neymar.csv")
neymar <- neymar[, -1]

m_salah <- read.csv("m_salah.csv")
m_salah <- m_salah[, -1]


# Processamento dos Dados


funcao_processa_dados <- function(data) {
  
  # removendo coluna X
  data <- subset(data, select = -X)
  
  # organizando ordem de colunas
  data <- 
    data %>% 
    select(Temporada, Equipe, Total, Total.1, Total.2, everything())
  
  return(data)
}


l_messi <- subset(l_messi, select = -X)

View(l_messi)

l_messi <- 
  l_messi %>% 
  select(Temporada, Equipe, Total, Total.1, Total.2, everything())

l_messi <- rename(l_messi, Jogos = Total, Gols = Total.1, Assist. = Total.2)

l_messi <- rename(l_messi,
                  Camp_Nacional_Jogos = Campeonatonacional, Camp_Nacional_Gols = Campeonatonacional.1,
                  Camp_Nacional_Assist = Campeonatonacional.2, Copa_Nacional_Jogos = Copanacional,
                  Copa_Nacional_Gols = Copanacional.1, Copa_Nacional_Assist = Copanacional.2,
                  Liga_Dos_Campeoes_Jogos = Liga.dos.Campeões.da.UEFA, Liga_Dos_Campeoes_Gols = Liga.dos.Campeões.da.UEFA.1,
                  Liga_Dos_Campeoes_Assist = Liga.dos.Campeões.da.UEFA.2, Supercopa_Nacional_Jogos = Supercopanacional, 
                  Supercopa_Naconal_Gols = Supercopanacional.1, Supercopa_Naconal_Assist = Supercopanacional.2,
                  Supercopa_Uefa_Jogos = Supercopa.da.UEFA, Supercopa_Uefa_Gols = Supercopa.da.UEFA.1,
                  Supercopa_Uefa_Assist = Supercopa.da.UEFA.2, Mundial_de_Clubes_Jogos = Mundial.de.Clubes,
                  Mundial_de_Clubes_Gols = Mundial.de.Clubes.1, Mundial_de_Clubes_Assist = Mundial.de.Clubes.2)

l_messi <- l_messi[-1, ]

write.csv(l_messi, "lionel_messi.csv")





neymar <- subset(neymar, select = -X)

neymar <- 
  neymar %>% 
  select(Temporada, Equipe, Total, Total.1, Total.2, everything())

neymar <- rename(neymar,
                 Jogos = Total, Gols = Total.1, Assist. = Total.2,
                 Camp_Nacional_Jogos = Campeonatonacional, Camp_Nacional_Gols = Campeonatonacional.1,
                 Camp_Nacional_Assist = Campeonatonacional.2, Copa_Nacional_Jogos = Copasnacionais.a.,
                 Copa_Nacional_Gols = Copasnacionais.a..1, Copa_Nacional_Assist = Copasnacionais.a..2,
                 Camp_Continental_Jogos = Competiçõescontinentais.b., Camp_Continental_Gols = Competiçõescontinentais.b..1,
                 Camp_Continental_Assist = Competiçõescontinentais.b..2, Outros_Torneios_Jogos = Outrostorneios.c.,
                 Outros_Torneios_Gols = Outrostorneios.c..1, Outros_Torneios_Assist = Outrostorneios.c..2)

neymar <- neymar[-1, ]

write.csv(neymar, "neymar.csv")




m_salah <- funcao_processa_dados(m_salah)







View(neymar)


# C. Ronaldo     -> https://pt.wikipedia.org/wiki/Cristiano_Ronaldo
# K. Mbappé      -> https://pt.wikipedia.org/wiki/Kylian_Mbappé
# L. Messi       -> https://pt.wikipedia.org/wiki/Lionel_Messi
# M. Salah       -> https://pt.wikipedia.org/wiki/Mohamed_Salah
# Neymar         -> https://pt.wikipedia.org/wiki/Neymar
# Z. Ibrahimovic -> https://pt.wikipedia.org/wiki/Zlatan_Ibrahimović


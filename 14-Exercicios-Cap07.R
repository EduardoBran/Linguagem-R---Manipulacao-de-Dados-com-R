# Lista de Exercícios - Capítulo 7 


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()


# Carregando pacotes

library(rvest)
library(dplyr)
library(stringr)
library(tidyr)



# Exercício 1 - Faça a leitura da url abaixo e grave no objeto pagina
# http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I




# Exercício 2 - Da página coletada no item anterior, extraia o texto que contenha as tags:
# "#detailed-forecast-body b  e .forecast-text"




# Exercício 3 - Transforme o item anterior em texto




# Exercício 4 - Extraímos a página web abaixo para você. Agora faça a coleta da tag "table"
url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)




# Exercício 5 - Converta o item anterior em um dataframe




# Exercício 6 - Remova as duas primeiras linhas e adicione nomes as colunas




# Exercício 7 - Converta de algarismos romanos para números inteiros




# Exercício 8 - Divida as colunas em 4 colunas




# Exercício 9 - Inclua mais 2 colunas com o score dos vencedores e perdedores
# Dica: Você deve fazer mais uma divisão nas colunas




# Exercício 10 - Grave o resultado em um arquivo csv




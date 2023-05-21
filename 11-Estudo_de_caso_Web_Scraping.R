# Estudo de Caso - Extraindo Dados da Web com Web Scraping em R


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Web Crawling - "rastejar" por uma web page ou site buscando dados
# Web Scraping - "raspar" os dados de uma web page



# - Neste Estudo de Caso vamos acessar uma página web, iremos "raspar" (Web Scraping) estes dados que nos interessa,
#   organizar estes dados e prepara-los para o processo de análise.




# Pacotes R para Web Scraping - RCurl , httr , XML , rvest




# Instalando e carregando pacotes

install.packages('rvest')     # escolhido pois é útil para quem não conhece HTML e CSS
library(rvest)

library(stringr)          
library(dplyr)
library(lubridate)     # trata dadas
library(readr)






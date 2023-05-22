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

install.packages('rvest')   # pacote escolhido pois é útil para quem não conhece HTML e CSS

library(rvest)              # utilizado para fazer a extração de informações de páginas da web           
library(stringr)            # fornece funções para manipulação de strings de texto de forma eficiente     
library(dplyr)              # fornece um conjunto de funções que permitem filtrar, transformar, resumir e combinar dados
library(lubridate)          # permite realizar operações comuns em datas
library(readr)              # conjunto de funções rápidas e eficientes para importar e ler dados tabulares em R



# Leitura da Web Page - Retorna um documento XML que representa toda a estrutura da página web 

webpage <- read_html("https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html")
webpage


# Extraindo os registros

# - Ao clicar para inspecionar a página html e inspencionando especificamente os elementos/tags onde contém os dados que
#   queremos usar temos o seguinte formato em html:
#
# <span class="short-desc"><strong> DATE </strong> LIE <span class="short-truth"><a href="URL"> EXPLANATION </a></span></span>

results <- 
  webpage %>% 
  html_nodes(".short-desc")

results




# Até aqui nós extraimos toda a estrutura html da página (webpage) e depois separamos pela tags escolhidadas (results)

# Agora iremos "limpar" as tags e extrair somente o registro que nos interessa.









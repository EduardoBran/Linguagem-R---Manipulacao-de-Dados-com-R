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
# - Assim iremos extrair todos os elementos HTML que possuem a classe "short-desc" da variável webpage.
#
# <span class="short-desc"><strong> DATE </strong> LIE <span class="short-truth"><a href="URL"> EXPLANATION </a></span></span>

results <- 
  webpage %>% 
  html_nodes(".short-desc")

results




# Até aqui nós extraimos toda a estrutura html da página (webpage) e depois separamos pela classe escolhidadas (results)

# Agora iremos "limpar" as tags e extrair somente o registro que nos interessa.




# Construindo o dataset


# criando uma lista vazia com o comprimento de results

records <- vector("list", length = length(results))



# - for -> seq_along() necessário pois o objeto results não é uma sequência numérica
#
# - date -> A função str_c é usada para extrair o texto dentro da tag <strong> de cada elemento results[i], que representa 
#           a data da mentira e ao mesmo tempo já concatenando com o texto ', 2017' para formatar a data completa.
#           O 'trim = TRUE' é para retirar qualquer espaço entre o texto        
#
# - lie -> Usamos a função xml_contents() para percorrer tudo dentro de results. Ele gera uma "lista" com todos dados de results.
#          Assim escolhemos a posicao na lista onde está o dado que nos interessa (aqui é o [2])
#
# - explanation -> extrai o texto dentro da classe CSS .short-truth de cada elemento results[i], que representa a explicação
#                  da mentira. A função str_sub é usada para remover os primeiros e últimos caracteres, que são parenteses.
#                  Foi usado o valor 2  (significa que vai tirar o primeiro caracter parentese)
#                  Foi usado o valor -2 (significa que vai tirar o último caracter parentese)
#
# - url -> extrai do atributo href da tag <a> de cada elemento results[i], o texto com link.
#
# - records[[i]] - cria um data frame com as variáveis date, lie, explanation e url, e atribui esse data frame ao elemento
#                  records[[i]].  Ao usar records[[i]], estamos acessando diretamente o elemento i da lista records e
#                  atribuindo a ele um novo valor, ou seja, estamos preenchendo o elemento i com os dados do registro.

for(i in seq_along(results)){
  
  date <- 
    str_c(results[i] %>%
            html_nodes("strong") %>% 
            html_text(trim = TRUE), ', 2017')
  
  lie <- 
    str_sub(xml_contents(results[i])[2] %>% html_text(trim = TRUE))
  
  explanation <- 
    str_sub(results[i] %>% 
              html_nodes(".short-truth") %>% 
              html_text(trim = TRUE), 2, -2)
  
  url <- 
    results[i] %>% 
    html_nodes("a") %>% 
    html_attr("href")
  
  records[[i]] <- data.frame(date = date,
                             lie = lie,
                             explanation = explanation,
                             url = url)
  
  
  print(xml_contents(results[i]))
  
}

# Dataset final

df <- bind_rows(records)   # combinando todos os elementos da lista records em um único data frame

View(df)


# Convertendo o campo data para o formato Date em R

summary(df)

df$date <- mdy(df$date)

summary(df)



# Exportando dataset

write.csv(df, "projeto_mentiras.csv")


# Lendo os dados

df <- read_csv("projeto_mentiras.csv")
View(df)
  
  
  
  
  
  
  



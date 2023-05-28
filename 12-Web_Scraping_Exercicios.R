# Exercícios sobre Web Scraping em R


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Todos-os-scripts")
getwd()



# Carregando pacotes

library(rvest)              # utilizado para fazer a extração de informações de páginas da web           
library(stringr)            # fornece funções para manipulação de strings de texto de forma eficiente     
library(dplyr)              # fornece um conjunto de funções que permitem filtrar, transformar, resumir e combinar dados
library(lubridate)          # permite realizar operações comuns em datas
library(readr)              # conjunto de funções rápidas e eficientes para importar e ler dados tabulares em R




#  Exercício 1: Extração de Dados de uma Lista de Livros


# <html>
#   <head>
#    <title>Lista de Livros</title>
#   </head>
#   <body>
#    <h1>Lista de Livros</h1>
#    <ul class="ulbook">
#     <li class="book">Livro 1</li>
#     <li class="book">Livro 2</li>
#     <li class="book">Livro 3</li>
#    </ul>
#   </body>
# </html>

#   Objetivo: Extrair os títulos dos livros da lista.


webpage <- read_html('<html>  <head>  <title>Lista de Livros</title>  </head>  <body>  <h1>Lista de Livros</h1>  <ul class="ulbook">  <li class="book">Livro 1</li>  <li class="book">Livro 2</li>  <li class="book">Livro 3</li>  </ul>  </body></html>')
webpage


results <- 
  webpage %>% 
  html_nodes(".ulbook")

results


records <- vector("list", length = length(results))


for(i in seq_along(results)) {
  
  nome_livro <-
    results[i] %>% 
    html_nodes(".book") %>% 
    html_text()
    
  records[[i]] <- data.frame(id = seq_along(nome_livro), nome_livro = nome_livro)
}

df <- bind_rows(records)   # Combina todos os elementos da lista records em um único data frame
View(df)






#  Exercício 2: Extração de Dados de uma Tabela de Estudantes

# <html>
#   <head>
#    <title>Tabela de Estudantes</title>
#   </head>
#   <body>
#    <h1>Tabela de Estudantes</h1>
#    <table>
#     <tr>
#      <th>Nome</th>
#      <th>Idade</th>
#     </tr>
#     <tr>
#      <td>Estudante 1</td>
#      <td>20</td>
#     </tr>
#     <tr>
#      <td>Estudante 2</td>
#      <td>22</td>
#     </tr>
#     <tr>
#      <td>Estudante 3</td>
#      <td>19</td>
#     </tr>
#    </table>
#   </body>
# </html>

#   Objetivo: Extrair os nomes e idades dos estudantes da tabela.


webpage <- read_html('<html>  <head>  <title>Tabela de Estudantes</title>  </head>  <body>  <h1>Tabela de Estudantes</h1>  <table>  <tr>  <th>Nome</th>  <th>Idade</th>  </tr>  <tr>  <td>Estudante 1</td>  <td>20</td>  </tr>  <tr>  <td>Estudante 2</td>  <td>22</td>  </tr>  <tr>  <td>Estudante 3</td>  <td>19</td>  </tr>  </table>  </body>  </html>')
webpage


results <- html_table(webpage, fill = TRUE)
results  


df <- results[[1]]

View(df)






#   Exercício 3: Extração de Dados de uma Página de Notícias


# <html>
#   <head>
#   <title>Página de Notícias</title>
#   </head>
#   <body>
#   <h1>Últimas Notícias</h1>
#   <div class="news">
#   <h2 class="title">Notícia 1</h2>
#   <p class="summary">Resumo da Notícia 1</p>
#   </div>
#   <div class="news">
#   <h2 class="title">Notícia 2</h2>
#   <p class="summary">Resumo da Notícia 2</p>
#   </div>
#   <div class="news">
#   <h2 class="title">Notícia 3</h2>
#   <p class="summary">Resumo da Notícia 3</p>
#   </div>
#   </body>
# </html>

#  - Objetivo: Extrair os títulos e resumos das notícias da página.







#  Exercício 4: Extraia o título, descrição e preço de produtos de uma página de e-commerce.

# 
# <div class="product">
#   <h2 class="title">Produto 1</h2>
#   <p class="description">Descrição do Produto 1</p>
#   <span class="price">R$ 100,00</span>
#   </div>
#   
#   <div class="product">
#   <h2 class="title">Produto 2</h2>
#   <p class="description">Descrição do Produto 2</p>
#   <span class="price">R$ 50,00</span>
# </div>







#  Exercício 5: Obtenha o título, data e conteúdo de postagens de um blog.
  
# <div class="post">
#   <h2 class="title">Título da Postagem 1</h2>
#   <span class="date">01/01/2022</span>
#   <div class="content">
#   <p>Conteúdo da postagem 1...</p>
#   </div>
#   </div>
#   
#   <div class="post">
#   <h2 class="title">Título da Postagem 2</h2>
#   <span class="date">02/01/2022</span>
#   <div class="content">
#   <p>Conteúdo da postagem 2...</p>
#   </div>
# </div>




  
  
  
  
#  Exercício 6, MM: Colete informações de usuários em uma lista de membros de uma comunidade.

# <ul class="members">
#   <li class="memberli">Usuário 1</li>
#   <li class="memberli">Usuário 2</li>
#   <li class="memberli">Usuário 3</li>
# </ul>










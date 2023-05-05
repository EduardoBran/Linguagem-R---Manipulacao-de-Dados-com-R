# Remodelagem de Dados com tidyr

# Exercícios


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Carregando os pacotes

library(dplyr)
library(tidyr)




# Exercício 1

# Considere o seguinte dataframe com informações sobre vendas de produtos em diferentes lojas:
  
set.seed(123)

vendas <- data.frame(
  loja = rep(LETTERS[1:4], each = 3),
  produto = rep(c("produto A", "produto B", "produto C"), 4),
  venda1 = round(runif(12, min = 10, max = 50)),
  venda2 = round(runif(12, min = 10, max = 50))
)

View(vendas)

# - Reorganize o dataframe para ter uma coluna para a loja, uma coluna para o produto,
#   uma coluna para o tipo de venda (venda1 ou venda2) e uma coluna para o valor da venda.

# - Crie um novo dataframe que apresente a média das vendas de cada produto em cada loja.

vendas_res <- 
  vendas %>% 
  gather(tipo_de_venda, valor_da_venda, c('venda1', 'venda2'))

View(vendas_res)


vendas_res2 <- 
  vendas_res %>% 
  group_by(loja, produto) %>% 
  summarise(media_produto = mean(valor_da_venda))

View(vendas_res2)



# Exercício 2

# Considere o seguinte dataframe com informações sobre o desempenho de alunos em diferentes disciplinas:
  
set.seed(456)

desempenho <- data.frame(
  aluno = paste0("aluno", 1:8),
  matematica_av1 = round(runif(8, min = 0, max = 10), 1),
  matematica_av2 = round(runif(8, min = 0, max = 10), 1),
  portugues_av1 = round(runif(8, min = 0, max = 10), 1),
  portugues_av2 = round(runif(8, min = 0, max = 10), 1),
  historia_av1 = round(runif(8, min = 0, max = 10), 1),
  historia_av2 = round(runif(8, min = 0, max = 10), 1)
)

View(desempenho)

# - Remodele os dados de modo a ter uma coluna para a disciplina, uma coluna para o tipo de avaliação (av1 ou av2) 
#   e uma coluna para a nota.
# - Crie um novo dataframe que apresente a média de cada aluno por disciplina






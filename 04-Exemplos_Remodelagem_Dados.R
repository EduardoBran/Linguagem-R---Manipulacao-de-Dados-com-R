# Remodelagem de Dados com tidyr

# Exercícios


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Carregando os pacotes

library(dplyr)
library(tidyr)
library(stringr)  # necessario para usar a funcao mutate()

library(ggplot2)





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


# coluna para disciplina e coluna para nota

desempenho_res <- 
  desempenho %>% 
  gather(disciplina, nota, -aluno)

View(desempenho_res)

# coluna para o tipo de avaliação

desempenho_res <- 
  desempenho_res %>% 
  separate(col = disciplina, into = c('disciplina', 'tipo_de_avaliacao'), sep = "\\_")

View(desempenho_res)

# ordenando por aluno

desempenho_res <- 
  desempenho_res %>% 
  arrange(aluno)

View(desempenho_res)


# média de cada aluno por disciplina

desempenho_nota_media_por_materia_aluno <- 
  desempenho_res %>% 
  group_by(aluno, disciplina) %>% 
  summarise(nota_media = mean(nota))

View(desempenho_nota_media_por_materia_aluno)


# nota máxima e nota mínima de cada aluno

desempenho_nota_maior_e_menor <- 
  desempenho_res %>% 
  group_by(aluno) %>% 
  summarise(nota_max = max(nota),
            nota_min = min(nota))

View(desempenho_nota_maior_e_menor)


# nota média da disciplina

desempenho_media_materia <- 
  desempenho_res %>% 
  group_by(disciplina) %>% 
  summarise(media = mean(nota))

View(desempenho_media_materia)






# Exercício 3
  
#  Considere o seguinte dataframe com informações sobre vendas de uma loja:

set.seed(123)

loja <- data.frame(
  produto = c("produto1", "produto2", "produto3", "produto4"),
  vendas_semana_1 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_2 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_3 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_4 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_5 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_6 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_7 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_8 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_9 = round(runif(4, min = 0, max = 100), 2),
  vendas_semana_10 = round(runif(4, min = 0, max = 100), 2)
)
View(loja)

# - Remodele os dados de modo que tenhamos uma coluna para o produto, uma coluna para a semana e uma coluna para as vendas.

loja_res <- 
  loja %>% 
  gather(semana, valor_vendas, -produto)

View(loja_res)

loja_res2 <- 
  loja_res %>% 
  separate(col = semana, into = c('blabla', 'tipo_da_semana'), sep = 14)

loja_res2 <- subset(loja_res2, select = -blabla)

View(loja_res2)






# Exercício 4
  
#  Considere o seguinte dataframe com informações sobre produtos em estoque:
  
estoque <- data.frame(
  id_produto = c(1, 2, 3, 4, 5),
  nome_produto = c("produto1", "produto2", "produto3", "produto4", "produto5"),
  estoque_01_jan = c(50, 40, 60, 70, 80),
  estoque_01_fev = c(45, 35, 65, 75, 85),
  estoque_01_mar = c(30, 20, 70, 80, 90)
)
View(estoque)

# - Remodele os dados de modo que tenhamos uma coluna para o produto, uma coluna para a data e uma coluna para o estoque.

estoque_res <- 
  estoque %>% 
  gather(data, estoque, -id_produto, -nome_produto)

View(estoque_res)


# removendo o "estoque_" da coluna data

estoque_res2 <-
  estoque_res %>% 
  mutate(data = str_replace(data, "estoque_", ""))

estoque_res2 <-
  estoque_res2 %>% 
  mutate(data = str_replace(data, "_", " "))

View(estoque_res2)












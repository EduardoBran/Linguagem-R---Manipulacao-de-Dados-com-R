# Remodelagem de Dados com tidyr

# Exercícios


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Carregando os pacotes

library(dplyr)
library(tidyr)
library(stringr)  # necessario para usar a funcao mutate()

library(lubridate) # necessario para funcao de data

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






# Exercício 5
  
#  Considere o seguinte dataframe com informações sobre pedidos de uma loja:
  
pedidos <- data.frame(
  id_pedido = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
  data_pedido = c("2021-01-01", "2021-02-02", "2021-02-15", "2021-03-03", "2021-03-20", "2021-01-01",
                  "2021-02-02", "2021-01-01", "2021-02-02", "2021-02-15", "2021-03-03", "2021-02-02"),
  valor_pedido = c(100, 200, 150, 300, 250, 100, 500, 100, 5000, 1000, 2000, 4000),
  status_pedido = c("entregue", "entregue", "cancelado", "entregue", "cancelado", "entregue",
                    "entregue", "cancelado", "entregue", "cancelado", "entregue", "cancelado")
)
View(pedidos)
pedidos

# - Remodele os dados de modo que tenhamos uma coluna para a data, uma coluna para o status do pedido e uma coluna para
#   o valor total dos pedidos para cada combinação de data e status.

pedidos_res <- 
  pedidos %>% 
  group_by(data_pedido, status_pedido) %>% 
  summarise(valor_total = sum(valor_pedido))

View(pedidos_res)






# Exercício 6

#  Considere o seguinte dataframe com informações sobre vendas de produtos em diferentes lojas:

vendas <- data.frame(
  loja = c("Loja A", "Loja B", "Loja C"),
  produto_1 = c(100, 150, 200),
  produto_2 = c(50, 75, 100),
  produto_3 = c(200, 250, 300)
)

View(vendas)

# a. Remodele os dados de modo que tenhamos uma coluna para o produto, uma coluna para a loja e uma coluna para a
#    quantidade vendida.

vendas_a <- 
  vendas %>% 
  gather(produto, qtd_vendida, -loja)

View(vendas_a)


# b. Crie uma nova coluna que contenha o total de vendas de cada loja.

total_vendas_por_loja <- 
  vendas_a %>% 
  group_by(loja) %>% 
  summarise(total_vendas = sum(qtd_vendida))

View(total_vendas_por_loja)
  

# c. Crie um gráfico de barras que mostre o total de vendas de cada loja.

ggplot(data = total_vendas_por_loja,
       aes(x = loja, y = total_vendas)) +
  geom_col()
  
ggplot(data = total_vendas_por_loja,
       aes(x = loja, y = total_vendas)) +
  geom_bar(stat = "identity")






# Exercício 8

#   Considere o seguinte dataframe com informações sobre vendas de produtos em diferentes regiões:
  
vendas <- data.frame(
  regiao = c("Norte", "Norte", "Nordeste", "Nordeste", "Sudeste", "Sudeste"),
  produto = c("produto_1", "produto_2", "produto_1", "produto_2", "produto_1", "produto_2"),
  janeiro = c(100, 50, 200, 100, 300, 150),
  fevereiro = c(150, 75, 250, 125, 350, 175),
  marco = c(200, 100, 300, 150, 400, 200)
)
View(vendas)

# a. Remodele os dados de modo que tenhamos uma coluna para o produto, uma coluna para a região, uma coluna para o mês
#    e uma coluna para a quantidade vendida.

vendas_a <- 
  vendas %>% 
  gather(mes, qtd_vendida, -regiao, -produto)

View(vendas_a)

# b. Crie uma nova coluna que contenha o total de vendas de cada produto em cada região.

vendas_qtd_vendida <- 
  vendas_a %>% 
  group_by(regiao) %>% 
  summarise(total_de_vendas = sum(qtd_vendida))

View(vendas_qtd_vendida)

# c. Crie um gráfico de barras que mostre o total de vendas de cada produto em cada região.

ggplot(data = vendas_qtd_vendida,
       aes(x = regiao,
           y = total_de_vendas)) +
  geom_bar(stat = 'identity')






# Exercício 9
  
#  Considere o seguinte dataframe com informações sobre pacientes em um hospital:

set.seed(123)

pacientes <- data.frame(
  id = 1:1000,
  idade = sample(18:90, 1000, replace = TRUE),
  sexo = sample(c("M", "F"), 1000, replace = TRUE),
  pressao_sanguinea = sample(90:180, 1000, replace = TRUE),
  diabetes = sample(c("Sim", "Não"), 1000, replace = TRUE),
  colesterol = sample(150:300, 1000, replace = TRUE),
  cancer = sample(c("Sim", "Não"), 1000, replace = TRUE),
  obesidade = sample(c("Sim", "Não"), 1000, replace = TRUE),
  fumante = sample(c("Sim", "Não"), 1000, replace = TRUE),
  internado = sample(c("Sim", "Não"), 1000, replace = TRUE)
)
View(pacientes)

# a) Crie uma nova coluna chamada idade_grupo que agrupa a idade dos pacientes em faixas etárias:
#
#    18-29, 30-39, 40-49, 50-59, 60-69, 70-79 e 80-90.


# utilizando função cut()

pacientes_a <- pacientes

pacientes_a$idade_grupo <- cut(pacientes_a$idade,
                               breaks = c(17, 29, 39, 49, 59, 69, 79, 90),
                               labels = c('18-29', '30-39', '40-49', '50-59', '60-69', '70-79', '80-90'))
View(pacientes_a)


# utilizando mutate() e case_when() do pacote dplyr

pacientes_a2 <- pacientes

pacientes_a2 <- pacientes_a2 %>%
  mutate(idade_grupo = case_when(
    idade >= 18 & idade <= 29 ~ "18-29",
    idade >= 30 & idade <= 39 ~ "30-39",
    idade >= 40 & idade <= 49 ~ "40-49",
    idade >= 50 & idade <= 59 ~ "50-59",
    idade >= 60 & idade <= 69 ~ "60-69",
    idade >= 70 & idade <= 79 ~ "70-79",
    idade >= 80 & idade <= 90 ~ "80-90",
    TRUE ~ NA_character_                      # se nenhuma das faixas etárias especificadas na função for atendida, o valor "NA" será atribuído à nova coluna "idade_grupo".
  ))

View(pacientes_a2)


# b) Crie um novo dataframe chamado pacientes_fumantes que contenha apenas as informações dos pacientes que são fumantes.

pacientes_fumantes <- 
  pacientes %>% 
  filter(fumante == "Sim")

View(pacientes_fumantes)


# c) Crie um novo dataframe chamado pacientes_internados que contenha apenas as informações dos pacientes que foram
#    internados.

pacientes_internados <- 
  pacientes %>% 
  filter(internado == "Sim")

View(pacientes_internados)






# Exercício 10
  
#  Considere o seguinte dataframe com informações sobre vendas de produtos em diferentes lojas:
  
vendas <- data.frame(
  loja = sample(c("Loja A", "Loja B", "Loja C", "Loja D"), 1000, replace = TRUE),
  produto = sample(c("produto_1", "produto_2", "produto_3"), 1000, replace = TRUE),
  quantidade = sample(1:100, 1000, replace = TRUE),
  preco_unitario = sample(1:50, 1000, replace = TRUE)
)
View(vendas)

# a) Crie uma nova coluna chamada receita que calcule a receita de cada venda.

vendas2 <- 
  vendas %>% 
  mutate(receita = quantidade * preco_unitario)

View(vendas2)


# b) Crie um novo dataframe chamado vendas_produto_1 que contenha apenas as informações das vendas do produto 1.

vendas_produto_1 <- 
  vendas2 %>% 
  filter(produto == 'produto_1')

View(vendas_produto_1)


# c) Crie um novo dataframe chamado vendas_por_loja que contenha a quantidade de vendas e a receita total de cada loja.

vendas_por_loja <- 
  vendas2 %>% 
  group_by(loja) %>% 
  summarise(
    qtd_de_vendas = sum(quantidade),
    total_cada_loja = sum(receita)
  )

View(vendas_por_loja)


# d) Crie um gráfico de barras representando vendas por loja

ggplot(data = vendas_por_loja,
  aes(x = loja, y = total_cada_loja)) +
  geom_bar(stat = 'identity')





# Exercício 11
  
#  Considere o seguinte dataframe com informações sobre despesas de um estabelecimento comercial:
  
despesas <- data.frame(
  data = seq(as.Date("2021-01-01"), by = "day", length.out = 1000),
  descricao = sample(c("Aluguel", "Água", "Luz", "Telefone", "Internet", "Material de escritório"), 1000, replace = TRUE),
  valor = sample(1:1000, 1000, replace = TRUE)
)
View(despesas)

# a) Crie uma nova coluna chamada mes que contenha o mês de cada despesa.

#dados_despesas <- 
#  despesas %>% 
#  separate(col = data, into = c('deletar', 'mes'), sep = '\\-')

#dados_despesas <- 
#  dados_despesas %>% 
#  select(mes)

#dados_despesas <- 
#  despesas %>% 
#  mutate(dados_despesas)

#dados_despesas <- 
#  dados_despesas %>% 
#  select(data, mes, descricao, valor)


# usando month()

dados_despesas <-
  despesas %>%
  mutate(mes = month(data))

dados_despesas <- 
  dados_despesas %>% 
  select(data, mes, descricao, valor)

View(dados_despesas)


# b) Crie um novo dataframe chamado despesas_aluguel que contenha apenas as informações das despesas com aluguel.

despesas_aluguel <- 
  dados_despesas %>% 
  filter(descricao == 'Aluguel')

View(despesas_aluguel)


# c) Crie um novo dataframe chamado total_despesas_mes que contenha o total de despesas por mês

total_despesas_mes <- 
  dados_despesas %>% 
  group_by(mes) %>% 
  summarise(despesas_por_mes = sum(valor))

View(total_despesas_mes)








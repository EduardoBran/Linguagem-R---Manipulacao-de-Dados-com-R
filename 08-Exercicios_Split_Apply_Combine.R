# Exercícios sobre Técnica de Remodelagem de Dodos Split-Apply-Combine - plyr

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()


# Instalando e carregando pacotes

library(plyr)
library(dplyr)







# Exercicio 1
  
#  Considere o seguinte dataframe vendas com informações sobre as vendas de produtos em diferentes regiões:

vendas <- data.frame(
  regiao = sample(c("Norte", "Sul", "Leste", "Oeste"), size = 500, replace = TRUE),
  produto = sample(c("A", "B", "C"), size = 500, replace = TRUE),
  quantidade = sample(1:100, size = 500, replace = TRUE),
  valor = sample(50:200, size = 500, replace = TRUE)
)
View(vendas)

# Utilize a função ddply para calcular o valor total de vendas por região.

vendas_regiao <- ddply(vendas,
                       ~ regiao,
                       summarise,
                       qtd_regiao = sum(quantidade),
                       total_regiao = sum(valor))
View(vendas_regiao)


vendas_regiao2 <-
  vendas %>% 
  group_by(regiao) %>% 
  summarise(
    qtd_regiao = sum(quantidade),
    total_regiao = sum(valor))
  
View(vendas_regiao2)





# Exercicio 2

#  Considerando o dataframe alunos com informações sobre notas de alunos em diferentes disciplinas:

alunos <- data.frame(
  aluno = rep(paste0("Aluno", 1:500), each = 3),
  disciplina = rep(c("Matemática", "Português", "História"), times = 500),
  nota = round(rnorm(1500, 7, 2), 2)
)
View(alunos)

# Utilize a função ddply para calcular a média das notas de cada aluno em cada disciplina.

media_por_aluno <- ddply(alunos,
                         ~ aluno,
                         summarise,
                         media = mean(nota))

View(media_por_aluno)





# Exercicio 3

#  Considere o seguinte dataframe funcionarios com informações sobre o salário dos funcionários de uma empresa:
  
funcionarios <- data.frame(
  funcionario = rep(paste0("Funcionario", 1:500), each = 3),
  departamento = rep(c("Vendas", "RH", "Financeiro"), times = 500),
  salario = round(rnorm(1500, 5000, 1000), 2)
)
head(funcionarios)

# Utilize a função ddply para calcular o salário médio de cada departamento.

salario_medio <- ddply(funcionarios,
                       ~ departamento,
                       summarise,
                       media_salarial_departamento = mean(salario))

head(salario_medio)





# Exercicio 4

#  Considerando o dataframe estoque com informações sobre o estoque de produtos em diferentes lojas:
  
estoque <- data.frame(
  loja = rep(paste0("Loja", 1:500), each = 4),
  produto = rep(c("A", "B", "C", "D"), times = 500),
  quantidade = sample(1:100, size = 2000, replace = TRUE)
)
head(estoque)

# Utilize a função ddply para calcular a quantidade total de cada produto em todas as lojas.

qtd_produto <- ddply(estoque,
                     .(produto),
                     summarise,
                     qtd_total = sum(quantidade))




# Exercício 5
  
#  Considere o seguinte dataframe "vendas" com informações sobre as vendas de produtos em diferentes regiões:

vendas <- data.frame(
  regiao = sample(c("Norte", "Sul", "Leste", "Oeste"), size = 600, replace = TRUE),
  produto = sample(c("A", "B", "C"), size = 600, replace = TRUE),
  quantidade = sample(1:100, size = 600, replace = TRUE),
  valor = sample(50:200, size = 600, replace = TRUE)
)
head(vendas)

# Utilize a função ddply para calcular a média da quantidade vendida e o total de vendas para cada combinação de região
# e produto.

media_qtd_venda <- ddply(vendas,
                         .(regiao, produto),
                         summarise,
                         media_qtd = mean(quantidade),
                         media_total = mean(valor))
media_qtd_venda





# Exercício 6

#  Considere o seguinte dataframe "alunos" com informações sobre as notas de alunos em diferentes disciplinas:

n_linhas <- 300
alunos <- data.frame(
  aluno = rep(paste0("Aluno", 1:(n_linhas/3)), each = 9),
  disciplina = rep(c("Matemática", "Português", "História"), each = 3, times = n_linhas/3),
  nota = round(rnorm(n_linhas, 7, 2), 2)
)
View(alunos)

# Utilize a função ddply para calcular a média das notas de cada aluno em cada disciplina, considerando apenas os alunos
# com notas acima da média geral (7).

media_por_aluno <- ddply(alunos,
                         .(aluno, disciplina),
                         summarise,
                         media_do_aluno = mean(nota))
head(media_por_aluno)


media_notas_acima <- media_por_aluno %>% 
  filter(media_do_aluno >= 7)





# Exercício 7

#    Considere o seguinte dataframe "clientes" com informações sobre as compras realizadas por diferentes clientes:

set.seed(123)
clientes <- data.frame(
  cliente = rep(paste0("Cliente", 1:500), each = 4),
  produto = rep(c("A", "B", "C", "D"), times = 500),
  quantidade = sample(1:100, size = 2000, replace = TRUE),
  valor_unitario = round(runif(2000, 10, 50), 2)
)
novo_registro <- data.frame(cliente = "Cliente1", produto = "A", quantidade = 2, valor_unitario = 20.00)
clientes <- rbind(clientes, novo_registro)

head(clientes)
View(clientes)

# Utilize a função ddply para calcular o total gasto por cada cliente em cada produto, considerando o valor unitário e a
# quantidade comprada.

df_clientes <-
  clientes %>% 
  mutate(total = quantidade * valor_unitario)

head(df_clientes)


total_por_produto <- ddply(df_clientes,
                           .(cliente, produto),
                           summarise,
                           total_cliente_produto = sum(total))
  
  

  
# Exercício 8

#    Considere o seguinte dataframe "estoque" com informações sobre o estoque de produtos em diferentes lojas:

set.seed(123)  
estoque <- data.frame(
  loja = rep(paste0("Loja", 1:500), each = 4),
  produto = rep(c("A", "B", "C", "D"), times = 500),
  quantidade = sample(1:100, size = 2000, replace = TRUE)
)
head(estoque)
View(estoque)

# Utilize a função ddply para calcular a média da quantidade de cada produto em todas as lojas, considerando apenas as lojas
# com estoque acima da média geral.

media_geral_estoque <- mean(estoque$quantidade)

media_produto <- ddply(estoque,
                       .(produto),
                       summarise,
                       media_prod = mean(quantidade))

df_estoque <- media_produto %>%
  filter(media_prod > media_geral_estoque)





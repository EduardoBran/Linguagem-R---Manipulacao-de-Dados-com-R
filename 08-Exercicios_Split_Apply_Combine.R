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











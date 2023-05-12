# Exercícios Remodelagem de Dados com reshape2


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()




# Carregando pacotes

library(reshape2)

library(lattice)  # gerar gráficos
library(ggplot2)  # gerar gráficos




# Exercício 1

#  Considere o seguinte dataframe com informações sobre pacientes e suas condições de saúde:
  
set.seed(123)

pacientes <- data.frame(
  id = 1:500,
  sexo = sample(c("Feminino", "Masculino"), size = 500, replace = TRUE),
  idade = sample(18:80, size = 500, replace = TRUE),
  peso = rnorm(500, mean = 70, sd = 10),
  altura = rnorm(500, mean = 170, sd = 10),
  diabetes = sample(c(TRUE, FALSE), size = 500, replace = TRUE, prob = c(0.1, 0.9)),
  pressao = sample(c("Normal", "Alta"), size = 500, replace = TRUE, prob = c(0.7, 0.3)),
  doenca_cardiaca = sample(c(TRUE, FALSE), size = 500, replace = TRUE, prob = c(0.2, 0.8))
)
View(pacientes)

# a) Utilizando a funcao melt() do pacote reshape2, transforme o dataframe para que cada linha corresponda a um paciente, e as 
#    colunas correspondam às informações sobre a condição de saúde do paciente (colunas diabetes, pressao, doenca_cardiaca)

pacientes_modif <- melt(pacientes, id.vars = c("id", "sexo", "idade", "peso", "altura"))
View(pacientes_modif)

# utilizando gather()

pacientes_modif2 <- gather(pacientes, key = "variavel", value = "valor", -id, -sexo, -idade, -peso, -altura)


# b) Utilizando o pacote ggplot2, faça um gráfico de barras do número de pacientes com doença cardíaca ou diabetes, agrupados
#    por sexo.

ggplot(pacientes, aes(x = diabetes, fill = sexo)) +
  geom_bar() +
  facet_grid(~ sexo) +
  labs(title = "Número de Pacientes com DDiabetes",
       x = "",
       y = "Número de Pacientes",
       fill = "")


ggplot(pacientes, aes(x = factor(doenca_cardiaca | diabetes), fill = sexo)) +
  geom_bar() +
  scale_x_discrete(labels = c("Sem Doença", "Com Doença")) +
  facet_grid(~ sexo) +
  labs(title = "Número de Pacientes com Doença Cardíaca ou Diabetes",
       x = "",
       y = "Número de Pacientes",
       fill = "") +
  scale_fill_manual(values = c("#E69F00", "#56B4E9"))





# Exercício 2
  
#  Considere o seguinte dataframe df com informações sobre vendas realizadas por vendedores em uma loja:

set.seed(123)
df2 <- data.frame(
  vendedor = sample(c("João", "Maria", "Pedro"), 500, replace = TRUE),
  produto = sample(c("Camiseta", "Calça", "Bermuda"), 500, replace = TRUE),
  venda_jan = round(rnorm(500, 50, 10), 2),
  venda_fev = round(rnorm(500, 60, 15), 2),
  venda_mar = round(rnorm(500, 70, 12), 2)
)
View(df2)

# a) Utilize a função melt para transformar o dataframe df de formato "wide" para "long". Utilize as colunas vendedor e
#    produto como identificadores.

df2_modif <- melt(df2, id.vars = c("vendedor","produto"))
View(df2_modif)

# utilizando gather()

df2_modif2 <- 
  df2 %>% 
  gather(mes_da_venda, valor, -vendedor, -produto)

View(df2_modif2)


# b) Utilize a função dcast para transformar o dataframe df_long de formato "long" para "wide", criando uma coluna para cada
#    mês e utilizando as colunas vendedor e produto como identificadores.

df2_modif3 <- dcast(df2_modif, formula = vendedor + produto ~ variable, value.var = "value", fun.aggregate = sum)

View(df2_modif3)



# Exercício 3
  
#  Considere o seguinte dataframe df com informações sobre a população de cinco cidades em três anos distintos:
  
set.seed(123)
df3 <- data.frame(
  cidade = rep(c("Cidade A", "Cidade B", "Cidade C", "Cidade D", "Cidade E"), 3),
  ano = rep(c(2019, 2020, 2021), each = 5),
  populacao = round(runif(15, 10000, 50000))
)
View(df3)

# a) Utilize a função melt para transformar o dataframe df de formato "wide" para "long". Utilize a coluna cidade como
#    identificador.


# b) Utilize a função dcast para transformar o dataframe df_long de formato "long" para "wide", criando uma coluna para cada
#    ano e utilizando a coluna cidade como identificador.





# Exercício 4

# Considere o seguinte dataframe df com informações sobre notas de alunos em três disciplinas distintas:
  
set.seed(123)
df4 <- data.frame(
  aluno = rep(paste0("Aluno", 1:100), 3),
  disciplina = rep(c("Matemática", "Português", "História"), each = 100),
  nota = round(runif(300, 0, 10), 2)
)
View(df4)


# a) Utilize a função melt para transformar o dataframe df de formato "wide" para "long". Utilize as colunas aluno e
#    disciplina como identificadores.


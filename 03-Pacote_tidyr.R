# Remodelagem de Dados com tidyr


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Instalando e carregando os pacotes

install.packages("tidyr")

library(tidyr)
library(ggplot2)



# Criando dados de notas em disciplinas

dados <- data.frame(
  Nome = c("Geografia", "Literatura", "Biologia"),
  Regiao_A = c(97, 80, 84),
  Regiao_B = c(86, 90, 91)
)
View(dados)


# função gather() é usada para transformar essas variáveis em uma única coluna Regiao e seus respectivos valores em 
# outra coluna NotaFinal. 

dados_gather <- 
  dados %>% 
  gather(Regiao, NotaFinal, Regiao_A:Regiao_B)




# Criando dados 2

set.seed(10)

dados2 <- data.frame(
  id = 1:4,
  acao = sample(rep(c('controle', 'tratamento'), each = 2)),
  work.T1 = runif(4),
  home.T1 = runif(4),
  work.T2 = runif(4),
  home.T2 = runif(4)
)
View(dados2)


# Reshape 1

# - A função gather() transforma as colunas de work.T1, home.T1, work.T2 e home.T2 em uma única coluna time e cria uma
#   nova coluna key para armazenar o nome original das colunas que foram transformadas.
# - Os argumentos -id e -acao passados para a função gather() indicam que as colunas id e acao devem ser mantidas como
#   colunas fixas na tabela e não serem transformadas em linhas (símbolo -). 

dados2_organizado1 <- 
  dados2 %>% 
  gather(key, time, -id, -acao)

View(dados2_organizado1)


# Reshape 2

# - função separate() é utilizada para dividir uma coluna em duas ou mais colunas, utilizando um separador específico.
#   O argumento key indica qual coluna deve ser dividida, o argumento into indica quais serão os nomes das novas colunas
#   (nesse caso, localidade e tempo) e o argumento sep indica qual é o separador que deve ser utilizado (nesse caso, o ponto).

dados2_organizado2 <- 
  dados2_organizado1 %>% 
  separate(key, into = c("localidade", "tempo"), sep = "\\.")

View(dados2_organizado2)



# Criando dados 3

set.seed(1)


dados3 <- data.frame(
  participante = c('p1', 'p2', 'p3', 'p4', 'p5', 'p6'),
  info = c('g1m', 'g1m', 'g1f', 'g2m', 'g2m', 'g2m'),
  day1score = rnorm(n = 6, mean = 80, sd = 15),
  day2score = rnorm(n = 6, mean = 88, sd = 8)
)

View(dados3)


# Reshape 1 (3 funçõs gather que realiza a mesma tarefa)

dados3_organizado1 <- 
  dados3 %>% 
  gather(day, score, c(day1score, day2score))     # criando colunas 'day' e 'score' a partir de 'day1score' e 'day2score'

dados3_organizado2 <- 
  dados3 %>% 
  gather(day, score, -participante, -info)

dados3_organizado3 <- 
  dados3 %>% 
  gather(day, score, day1score:day2score)


dados3_organizado_spread <-        # funcao spread retorna o dataframe ao formato original (é o oposto do gather)
  dados3 %>% 
  gather(day, score, c(day1score, day2score)) %>% 
  spread(day, score)                              


# dividindo a coluna 'info' em 2 colunas 'group' e 'gender'

dados3_organizado4 <- 
  dados3 %>% 
  gather(day, score, c(day1score, day2score)) %>% 
  separate(col = info, into = c('group', 'gender'), sep = 2)     # sep = 2 indica que deve dividir a partir do  segundo caracter da coluna "info"


# une novamente as colunas 'group' e 'gender' na coluna 'infoAgain'

dados3_organizado5 <- 
  dados3 %>% 
  gather(day, score, c(day1score, day2score)) %>% 
  separate(col = info, into = c('group', 'gender'), sep = 2) %>% 
  unite(infoAgain, group, gender)



# Gerando gráfico (grafico de pontos)

# - A estética do gráfico é definida pela função aes, que mapeia a variável day para o eixo x e a variável score para o eixo y.
# - A função geom_point é utilizada para plotar os pontos do gráfico. 
# - A função facet_wrap é utilizada para separar o gráfico em painéis de acordo com a variável group. 
# - A função geom_smooth é utilizada para traçar uma reta de regressão linear nos pontos, utilizando o parâmetro
#   method = 'lm' e o parâmetro se = F para indicar que a área sob a curva não deve ser sombreada.


dados3_organizado_grafico <- 
  dados3 %>% 
  gather(day, score, c(day1score, day2score)) %>% 
  separate(col = info, into = c('group', 'gender'), sep = 2)


dados3_organizado_grafico %>%  
  ggplot(aes(x = day, y = score)) +
  geom_point() +
  facet_wrap(~ group) +
  geom_smooth(method = 'lm', aes(group = 1), se = F)
  



# Remodelagem de Dados com Reshape

# Exercícios


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# O reshape() serve para visualizarmos os dados de várias formas ou angulos diferentes



# Carregando pacotes

library(lattice)  # gerar gráficos
library(ggplot2)  # gerar gráficos



# Pivot (transposta da Matriz) - relembrando

View(mtcars)
View(t(mtcars))



# Reshape

# analisando df iris

View(iris)
str(iris)


# Distribuindo os dados verticalmente (long)

# A função reshape() é usada para transformar o conjunto de dados de um formato "wide" (largo) para um formato "long" (longo). Isso é feito para tornar mais fácil a análise posterior do conjunto de dados.

# - data: o conjunto de dados a ser transformado
# - varying: uma lista de variáveis que devem ser transformadas (no caso, as variáveis de 1 a 4)
# - v.names: o nome da nova variável que será criada (no caso, "Medidas")
# - timevar: o nome da variável que contém as informações de tempo ou dimensão (no caso, "Dimensoes")
# - times: os valores únicos da variável "timevar" (no caso, os nomes das variáveis de 1 a 4)
# - idvar: as variáveis de identificação que não devem ser transformadas (no caso, "ID")
# - direction: a direção da transformação, que pode ser "wide" ou "long" (no caso, "long")

iris_modif <- reshape(iris,
                      varying = 1:4,
                      v.names = "Medidas",
                      timevar = "Dimensoes",
                      times = names(iris)[1:4],
                      idvar = "ID",
                      direction = "long")

View(iris_modif)
str(iris_modif)


# Gerando gráfico boxplot

# temos duas variáveis (Medidas e Species) e estamos buscando uma relação entre as duas.
# o resultado desta relação nós relacionamos então com a variável Dimensoes

bwplot(Medidas ~ Species | Dimensoes, data = iris_modif)                # lattice

ggplot(iris_modif, aes(x = Species, y = Medidas, fill = Species)) +     # ggplot
  geom_boxplot() +
  facet_wrap(~Dimensoes, scales = "free_y") +
  theme_minimal()



# exemplo 2

# - Função reshape() para transformar o conjunto de dados "iris" de um formato "wide" para um formato "long".
# - A diferença entre o conjunto de dados original e o modificado é que as colunas "Sepal.Length", "Sepal.Width",
#   "Petal.Length" e "Petal.Width" são divididas em duas colunas cada: "Comprimento" e "Largura". A primeira coluna
#   representa o comprimento da parte da flor (Sépala ou Pétala) e a segunda coluna representa a largura dessa mesma parte.

# - O argumento varying é uma lista que especifica as colunas a serem usadas para criar as novas colunas "Comprimento"
#   e "Largura". No caso, a primeira coluna da lista (c(1, 3)) se refere às colunas "Sepal.Length" e "Petal.Length" e a
#   segunda coluna (c(2, 4)) se refere às colunas "Sepal.Width" e "Petal.Width".

# - O argumento v.names é um vetor que especifica os nomes das novas colunas criadas a partir das colunas especificadas em
#   varying. No caso, "Comprimento" e "Largura".
# - O argumento timevar especifica o nome da nova coluna que será criada para armazenar os nomes das colunas originais
#   especificadas em varying. Neste caso, "Parte".
# - O argumento times é um vetor que especifica os valores que serão armazenados na coluna criada por timevar. Neste caso,
#  "Sepal" e "Petal".
# - O argumento idvar especifica o nome da coluna que será usada para identificar as observações. Neste caso, "ID".
# - O argumento direction especifica se a transformação é de formato "wide" para "long" ou vice-versa. Neste caso, de
#   "wide" para "long".

iris_modif2 <- reshape(iris,
                       varying = list(c(1, 3), c(2, 4)),
                       v.names = c('Comprimento', 'Largura'),
                       timevar = 'Parte',
                       times = c('Sepal', 'Petal'),
                       idvar = 'ID',
                       direction = 'long')

View(iris_modif2)
str(iris_modif2)


# Gerando gráfico de dispersão

# Sobre as variáveis: diz quais colunas do dataframe correspondem aos eixos x e y, e qual coluna deve ser usada
# para codificar a cor dos pontos


xyplot(Comprimento ~ Largura | Species, data = iris_modif2,               # lattice
       groups = Parte, auto.key = list(space = "right"))

xyplot(Comprimento ~ Largura | Species, data = iris_modif2,               # lattice
       groups = Species, auto.key = list(space = "right"))


ggplot(iris_modif2, aes(x = Largura, y = Comprimento, color = Parte)) +   # ggplot
  geom_point() +
  facet_wrap(~ Species) +
  theme(legend.position = "right")






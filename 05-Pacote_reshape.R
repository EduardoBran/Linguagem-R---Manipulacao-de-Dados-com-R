# Remodelagem de Dados com reshape e reshape2


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# O reshape() serve para visualizarmos os dados de várias formas ou angulos diferentes



# Instalando e carregando pacotes

install.packages("reshape2")

library(reshape2)

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





# Reshape2


# Criando um dataframe

df <- data.frame(nome = c("Zico", "Pele"),
                 chuteira = c(40, 42),
                 idade = c(34, NA),
                 peso = c(93, NA),
                 altura = c(175, 178))

df


# "Derretendo" o dataframe df com a Função melt(). "Derreter" (ou "meltar") um dataframe significa transformá-lo de um 
#  formato amplo (wide) para um formato longo (long).

# No formato wide, cada linha do dataframe contém informações completas sobre uma única observação, com diferentes variáveis
# representadas em diferentes colunas. Por outro lado, no formato longo, cada linha do dataframe contém informações sobre
# apenas uma variável, com as observações correspondentes distribuídas em diferentes linhas.


# - Função melt() do pacote reshape2 usada para transformar o data frame df de formato wide (ou seja, com várias colunas)
#   para long (ou seja, com menos colunas, mas mais linhas). O argumento id é usado para indicar quais colunas não devem
#   ser transformadas em variáveis e mantidas como identificadores. 
#   No caso, as colunas nome e chuteira são mantidas como identificadores, enquanto as colunas idade, peso e altura são
#   transformadas em variáveis.

df_long <- melt(df, id = c('nome', 'chuteira'))
df_long


# Removendo NA utilizando a mesma função melt()

df_long <- melt(df, id = c('nome', 'chuteira'), na.rm = TRUE)
df_long


# "Esticando" o dataframe

# - Função dcast() permite transformar um dataframe de formato longo para um formato wide, ou seja, transformar valores
#   únicos de variáveis em colunas.
# - No exemplo, o dataframe df_long está em formato longo, com as variáveis variable e value.
#   A fórmula nome + chuteira ~ variable especifica que as colunas chuteira e nome são as variáveis que devem ser
#   preservadas (identificadores únicos) e que a variável variable deve ser usada para criar novas colunas no formato wide.

dcast(df_long, formula = nome + chuteira ~ variable)

dcast(df_long, formula = nome ~ variable)

dcast(df_long, formula = ... ~ variable)                # ... pega 'todas' as colunas



# Aplicando o reshape2


names(airquality) <- tolower(names(airquality))    # renomeando colunas de airquality para minúsculas

dim(airquality)
View(airquality)


# Função melt() - long

# - A função melt() é utilizada para "derreter" um df, isto é, transformá-lo de um formato "wide" para um formato "long".
#   Isso é feito transformando as variáveis de colunas para linhas, preservando uma ou mais variáveis identificadoras.

# - No caso específico deste exemplo, o dataframe airquality possui 6 colunas: Ozone, Solar.R, Wind, Temp, Month, e Day.
#   A função melt() transforma estas colunas em duas novas colunas: variable e value, onde a coluna variable corresponde 
#   ao nome das variáveis originais que foram "derretidas" e a coluna value corresponde aos valores destas variáveis.


df_airquality <- melt(airquality)

dim(df_airquality)
View(df_airquality)



# Mantendo duas variáveis

# - A função melt() irá transformar todas as colunas de airquality que não são identificadores (month e day) em uma única
#   coluna chamada variable, e os valores correspondentes a essas colunas em outra coluna chamada value.
# - id e id.vars mesma coisa

df_airquality2 <- melt(airquality, id.vars = c('month', 'day'))

dim(df_airquality2)
View(df_airquality2)

# alterando nome das colunas/variáveis

df_airquality2 <- melt(airquality, id.vars = c('month', 'day'),
                       variable.name = "climate_variable", value.name = "climate_value")

View(df_airquality2)



# Função dcast() - wide

df_long <- melt(airquality, id.vars = c('month', 'day'))

View(df_long)

df_airquality_wide <- dcast(df_long, month + day ~ variable)

View(df_airquality_wide)



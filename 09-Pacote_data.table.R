# Pacote data.table

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()


# Instalando e carregando pacotes

install.packages("data.table")

library(data.table)
library(plyr)
library(dplyr)



# - Objeto data.table herda de data.frame.
# - O pacote data.table oferece melhoria na performance do que o data.frame.



# Criando um data.table

vec1 <- c(1, 2, 3, 4)
vec2 <- c('Vermelho', 'verde', 'Azul', 'Laranja')

dt1 <- data.table(vec1, vec2)
dt1
class(dt1)



# Aplicando Slicing no data,table

dt2 <- data.table(A = 1:9, B = c('Z', 'W', 'Q'), C = rnorm(9), D = TRUE)
dt2

dt2_sl1 <- dt2[3:5, ]
dt2_sl1

dt2_sl2 <- dt2[, .(B, C)]
dt2_sl2

# Aplicando função ao data.table

dt2_funcao1 <- dt2[, .(Total_Col_A = sum(A), Mean_Col_C = mean(C))]
dt2_funcao1

dt2_funcao2 <- dt2[, plot(A, C)]

dt2_funcao3 <- dt2[, .(MySum_Col_A = sum(A)), by = .(Grp = A%%2)]
dt2_funcao3


# Definindo os valores por grupos

dt3 <- data.table(B = c('a', 'b', 'c', 'd', 'e', 'a', 'b', 'c', 'd', 'e'),
                  val = as.integer(c(6:10, 1:5)))
dt3



# Operações com data.tables

dt4 <- data.table(A = rep(letters[2:1], each = 4L),
                  B = rep(1:4, each = 2L),
                  C = sample(8))
dt4

dt4_op1 <- dt4[, sum(C), by = A]
dt4_op1

dt4_op2 <- dt4_op1[order(A)]
dt4_op2

dt4_op3 <- dt4[, sum(B), by = A][order(A)]
dt4_op3




# Iris

dt_iris <- as.data.table(iris)
dt_iris

dt_iris2 <- dt_iris[, .(Sepal.Length = median(Sepal.Length),
                        Sepal.Width = median(Sepal.Width),
                        Petal.Length = median(Petal.Length),
                        Petal.Width = median(Petal.Width)),
                    by = Species]

dt_iris2



# com o pacote dplyr

dt_iris_dplyr <- dt_iris %>%
  group_by(Species) %>%
  summarise(Sepal.Length = median(Sepal.Length),
            Sepal.Width = median(Sepal.Width),
            Petal.Length = median(Petal.Length),
            Petal.Width = median(Petal.Width))

dt_iris_dplyr




# - O parâmetro .SD significa Subset Data e um subset é criado considerando a coluna Species e depois é calculda 
# - a mediana. O resultado deve ser igual ao comando anterior. 
# - O .SD faz parte da notação do pacote data.table.

dt_iris3 <- dt_iris[, lapply(.SD, median), by = Species]
dt_iris3









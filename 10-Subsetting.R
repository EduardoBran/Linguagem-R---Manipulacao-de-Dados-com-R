# Subconjuntos de Dados com Subsetting


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()





# *** Não utilizaremos pacotes para fatiar os dados. Iremos utilizar apenas anotação/sintaxe da Linguagem R ***

# - Muitas das técnicas abaixo podem ser realizadas com a aplicação das funções:
# - subset(), merge(), plyr::arrange()





## Vetores 

x <- c('A', 'E', 'D', 'B', 'C')

# Exbindo todos os dados do vetor

x[]
x


# Índices Positivos - Elementos em posições específicas

x[c(1)]       # "A"
x[c(1, 3)]    # "A" "D"
x[c(1, 1)]    # "A" "A"
x[order(x)]   # "A" "B" "C" "D" "E"


# Índices Negativos - Ignore os elementos em posições específicas

x[-c(1, 3)]   # "E" "B" "C"
x[-c(1, 4)]   # "E" "D" "C"


# Vetor Lógico para gerar subsetting

x[c(TRUE, FALSE)]                       # "A" "D" "C"
x[c(TRUE, FALSE, TRUE, FALSE)]          # "A" "D" "C"


# Vetor de caracteres

y <- setNames(x, letters[1:4])
y

y[c('d', 'c', 'a')]   # "B" "D" "A"
y[c('d', 'a', 'a')]   # "B" "A" "A" 





## Matrizes 

mat <- matrix(1:9, nrow = 3)
colnames(mat) <- c('A', 'B', 'C')
mat

mat[1:2, ]
mat[1:2, 2:3]


# Função outer() permite que uma Matriz se comporte como vetores individuais

vals <- outer(1:5, 1:5, FUN = "paste", sep = ',')
vals

vals[c(4, 15)]





## Dataframes

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df

df$x

df[df$x == 2, ]     # retorna apenas coluna x com elemento = a 2 e todas as colunas

df[c(1, 3), ]       # retorna as linhas 1 e 3 e todas as colunas

df[, c('x', 'z')]   # retorna colunas escolhidas e todas as linhas

str(df["x"])

str(df[, "x"])



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


# Removendo colunas de dataframes

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df

df$z <- NULL
df


# Operadores [], [[]] e $

a <- list(x = 1:3, y = 4:5)
a

a[1]          # 1 2 3

a[[1]]        # 1 2 3

a[[1]][[1]]   # 1

a[["x"]]      # 1 2 3


b <- list(a = list(b = list(c = list(d = 1))))
b

b[[c('a', 'b', 'c', 'd')]]


# chamando coluna com índice

var <- "cyl"
mtcars$var

mtcars[[var]]


x <- list(abc = 1)
x

x$a        # 1

x[["a"]]   # NULL

x[["abc"]] # 1





## Subsetting e atribuição

x <- 1:5
x

x[c(1, 2)] <- 2:3   # alterando 2 elementos dentro do vetor
x

x[-1] <- 4:1
x


# Exemplo de subsetting (imprime toda a estrutura do df ao fazer a conversão com lapply)

head(mtcars)

mtcars[] <- lapply(mtcars, as.integer)   # transformou todos os números em inteiros

head(mtcars)


# Exemplo de NÃO subsetting (imprime apenas uma lista com os valores, não mantém a estrutura)

mtcars <- lapply(mtcars, as.integer)

head(mtcars)





## Lookup tables

x <- c('m', 'f', 'u', 'f', 'f', 'm', 'm')
x

lookup <- c(m = "Male", f = 'Female', u = NA)
lookup

lookup[x]

unname(lookup[x])





## Usando operadores lógicos

x1 <- 1:10 %% 2 == 0  
x1                               # retorna entre 1 e 10 quando dividido por 2 for igual a zero

which(x1)

x2 <- which(x1)
x2

y1 <- 1:10 %% 5 == 0
y1

y2 <- which(y1)
y2

intersect(x2, y2)

x1 & y1

union(x2, y2)

setdiff(x2, y2)

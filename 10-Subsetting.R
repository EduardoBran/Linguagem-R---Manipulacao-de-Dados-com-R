# Subconjuntos de Dados com Subsetting


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()




# *** Não utilizaremos pacotes para fatiar os dados. Iremos utilizar apenas anotação/sintaxe da Linguagem R ***

# - Muitas das técnicas abaixo podem ser realizadas com a aplicação das funções:
# - subset(), merge(), plyr::arrange()




## Vetores 


# Criando vetor

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







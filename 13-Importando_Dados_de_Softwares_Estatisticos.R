# Importando Dados de Softwares Estatísticos (SAS, STATA, SPSS)


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Instalando e carregando pacote

install.packages("haven")
library(haven)



# SAS

vendas <- read_sas("vendas.sas")
View(vendas)

class(vendas)
str(vendas)
summary(vendas)



# Stata
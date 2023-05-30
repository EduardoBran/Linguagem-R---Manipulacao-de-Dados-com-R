# Importando Dados de Softwares Estatísticos (SAS, STATA, SPSS)


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Instalando e carregando pacote

install.packages("haven")
install.packages('foreign')

library(haven)
library('foreign')

library(dplyr)
library(ggplot2)



# SAS

vendas <- read_sas("vendas.sas")
View(vendas)

class(vendas)
str(vendas)
summary(vendas)


# manipulando dados

media_idade_genero <- 
  vendas %>% 
  group_by(gender) %>% 
  summarise(media_idade = mean(age),
            total_purchase = sum(purchase))

renda_genero <- 
  vendas %>% 
  group_by(gender, income) %>%
  count()


# plotando (grafico de barras)

# Converter a variável "gender" e "income" em um fator
vendas$gender <- as.factor(vendas$gender)
vendas$income <- as.factor(vendas$income)

# gráfico de barras usando ggplot

barplot_gender <- 
  ggplot(vendas, aes(x = gender)) +
  geom_bar(fill = 'blue') +
  labs(title = "Distribuição de Clientes por Gênero",
       x = "Gênero",
       y = "Contagem")

barplot_income <- 
  ggplot(vendas, aes(x = income)) +
  geom_bar(fill = "green") +
  labs(title = "Distribuição de Clientes por Renda",
       x = "Renda",
       y = "Contagem")

barplot_income_gender <- ggplot(vendas, aes(x = income, fill = gender)) +
  geom_bar() +
  labs(title = "Distribuição de Clientes por Renda e Gênero",
       x = "Renda",
       y = "Contagem") +
  scale_fill_manual(values = c("blue", "pink"))  # Define as cores para os gêneros masculino e feminino

barplot_income_gender


# gráfico de dispersão

scatterplot <- 
  ggplot(vendas, aes(x = age, y = income)) +
  geom_point() +
  labs(title = "Gráfico de Dispersão: Idade vs. Renda",
       x = "Idade",
       y = "Renda")

scatterplot





# Stata

df_stata <- read_dta("mov.dta")
View(df_stata)

class(df_stata)
str(df_stata)
summary(df_stata)





# Pacote Foreign

florida <- read.dta("florida.dta")
View(florida)




# SPSS
# http://cw.routledge.com/textbooks/9780415372985/resources/datasets.asp (Website com exemplos de dados gravados com SPSS)

dados <- read.spss("international.sav")

df <- data.frame(dados)
View(df)


# Criando um boxplot
boxplot(df$gdp)




# Se você estiver familiarizado com estatística, você vai ter ouvido falar de Correlação. 
# É uma medida para avaliar a dependência linear entre duas variáveis. 
# Ela pode variar entre -1 e 1; 
# Se próximo de 1, significa que há uma forte associação positiva entre as variáveis. 
# Se próximo de -1, existe uma forte associação negativa: 
# Quando a correlação entre duas variáveis é 0, essas variáveis são possivelmente independentes: 
# Ou seja, não há nenhuma associação entre X e Y.

# Coeficiente de Correlação. Indica uma associação negativa entre GDP e alfabetização feminina
cor(df$gdp, df$f_illit)


# **** Importante ****
# Correlação não implica causalidade
# A correlação, isto é, a ligação entre dois eventos, não implica 
# necessariamente uma relação de causalidade, ou seja, que um dos 
# eventos tenha causado a ocorrência do outro. A correlação pode 
# no entanto indicar possíveis causas ou áreas para um estudo mais 
# aprofundado, ou por outras palavras, a correlação pode ser uma 
# pista.





# Estudo de Caso - Limpando, Transformando e Manipulando Dados de Voos


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()



# Vamos trabalhar com um conjunto de dados de voos do Aeroporto de Houston (EUA)



# Instalando e carregando pacotes

install.packages("hflights")  # carrega dados de voos de Houston

library(hflights) 
library(dplyr)

?hflights



# Criando um objeto tbl

dados_flights <- tbl_df(hflights)

View(dados_flights)



# Resumindo os dados

str(dados_flights)

glimpse(dados_flights)



# Visualizando como dataframe

View( data.frame(head(dados_flights)) )



# Filtrando os dados com slice

View( dados_flights[dados_flights$Month == 1 & dados_flights$DayofMonth == 1, ] )


# Filtrando os dados com filter()

View( filter(dados_flights, Month == 1, DayofMonth == 10) )

View( filter(dados_flights, UniqueCarrier == "AA" | UniqueCarrier == "UA") )

View( filter(dados_flights, UniqueCarrier %in% c("AA", "UA")) ) # mesma coisa do filtro acima



# Utilizando select() 

View( select(dados_flights, Year:DayofMonth) )     # seleciona todas as colunas de Year até DayofMonth

View( select(dados_flights, Year:DayofMonth, contains("Taxi"), contains("Delay")) )
# seleciona todas as colunas de Year até DayofMonth e colunas que contem "Taxi" e "Delay" no nome



# Organizando os dados

flights <- 
  dados_flights %>% 
  select(UniqueCarrier, DepDelay) %>%         # selecionando colunas
  arrange(DepDelay)                           # organizando por ordem crescente da coluna DepDelay


flights2 <- 
  dados_flights %>% 
  select(Distance, AirTime) %>%               # selecionando colunas
  mutate(Speed = Distance / AirTime * 60)     # adicionando nova coluna Speed                       


head(aggregate(ArrDelay ~ Dest, dados_flights, mean))


# contar o número de voos em cada combinação de mês e dia do mês.

flights3 <- 
  dados_flights %>% 
  group_by(Month, DayofMonth) %>% 
  tally(sort = TRUE)






# Split-Apply-Combine - plyr

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Manipulacao-de-Dados-com-R")
getwd()


# Instalando e carregando pacotes

install.packages("plyr")
install.packages("gapminder")   # dados sobre países, população, expectativa de vida e etc

library(plyr)
library(gapminder)



# Técnica de Remodelagem de Dados Split-Apply-Combine com plyr


# Esta regra consiste em dividir os dados, depois aplicar alguma regra e assim combinar para gerar o resultado final.

# Através desta técnica iremos unir as aulas sobre dplyr, tidyr, reshape2 onde aplicávamos as técnicas de maneira separadas.
# Agora aplicaremos tudo junto em uma mesma função através do pacote "plyr"



# Split-Apply-Combine utilizando tudo em uma única função 

View(gapminder)

df_gm <- ddply(gapminder,                                   # expecativa de vida máx e min por continente
               ~ continent,                                 # agrupando por continente
               summarize,
               max_lifeExp_continent = max(lifeExp),
               min_lifeExp_continent = min(lifeExp))


df_gm2 <- ddply(gapminder,                                  # contando quantos países por continente
                ~ continent,                      
               summarize,
               n_uniq_countries = length(unique(country)))  # aplicando unique porque tem o mesmo país mais de 1x nos dados


df_gm3 <- ddply(gapminder,                                  # média de expecativa vida, pop e renda por continente
                ~ continent,
                summarize,
                mean_lifeExp_continent = mean(lifeExp),
                mean_pop_continet = mean(pop),
                mean_gdp_Percap = mean(gdpPercap))

df_gm4 <- ddply(gapminder,                                  # contando quantos países por continente utilizando função
                ~ continent,                                  
                function(x) c(n_uniq_countries = length(unique(x$country))))



# Utilizando dplyr e várias funções para aplicar mesma técnica acima

library(dplyr)

df_gm_dplyr <- gapminder %>% 
  group_by(continent) %>% 
  summarize(max_lifeExp_continent = max(lifeExp),
            min_lifeExp_continent = min(lifeExp))

df_gm_dplyr2 <- gapminder %>%
  group_by(continent) %>%
  summarize(n_uniq_countries = length(unique(country)))

df_gm_dplyr3 <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_lifeExp_continent = mean(lifeExp),
            mean_pop_continet = mean(pop),
            mean_gdp_Percap = mean(gdpPercap))




# Exemplo com o dataset mpg

data(mpg) # carrega mpg

str(mpg)


# Trabalhando com um subset do dataset mpg

subset_mpg <- mpg[, c(1, 7:9)] # selecionar todas as linhas e apenas as colunas 1, 7, 8 e 9 do dataframe mpg.


# Sumarizando e agregando dados

df_mpg <- ddply(subset_mpg,              # média da coluna cty utilizando manufacturer como agrupamento
                ~ manufacturer,
                summarize,
                mean_cty = mean(cty))


df_mpg2 <- ddply(subset_mpg,
                ~ manufacturer,
                summarize,
                mean_cty = mean(cty),
                sd_cty = sd(cty),
                max_hwy = max(hwy))


df_mpg3 <- ddply(subset_mpg,
                 .(manufacturer, drv),    # agrupamento com mais de 1 coluna
                 summarize,
                 mean_cty = mean(cty),
                 mean_hwy = mean(hwy))



# Utilizando dplyr e várias funções

df_mpg3_dplyr <- subset_mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarize(mean_cty = mean(cty),
            mean_hwy = mean(hwy))





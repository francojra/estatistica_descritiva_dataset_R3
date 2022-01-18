# Descrição de dados -----------------------------------------------------------------------------------------------------------------------

### Descrever valores de média, mediana, desvio padrão, valores máximos e mínimos.

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

dados <- datasets::chickwts
dados

# Sobre os dados ---------------------------------------------------------------------------------------------------------------------------

### Experimento conduzido para medir e comparar a efetividade de vários suplementos
### alimentares sobre a taxa de crescimento de galinhas.

### Lista dos suplementos alimentares:
# 1. Caseína
# 2. Feijão
# 3. Linhaça
# 4. Almôndegas
# 5. Soja
# 6. Girassol

# Estatística descritiva dos dados ---------------------------------------------------------------------------------------------------------

library(dplyr) # Pacote usado para análises descritivas

### Cálculo da média e erro padrão usando o pacote dplyr

d <- dados %>% 
  group_by(feed) %>%
  summarise(media_feed = mean(weight),
            se = sd(weight) / sqrt(length(weight)))
d

# Etapas da produção dos gráficos ----------------------------------------------------------------------------------------------------------

# 1. Definir variáveis e tipo de gráfico;
# 2. Definir títulos dos eixos;
# 3. Acrescentar um tema ao gráfico, reduzir largura das barras e retirar a legenda
# 4. Transformar mês em variável fatorial e mudar nome dos eixos
# 5. Nomear os gráficos e uni-los em uma janela.

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

library(ggplot2) # Pacote para produzir os gráficos
#install.packages("hrbrthemes")
library(hrbrthemes) # Pacote para mudar o tema do gráfico (cor preta)

ggplot(d, aes(x = feed, y = media_feed, fill = feed)) +
  geom_col(width = 0.6) +
  geom_text(aes(x = feed,
                label = round(media_feed)), 
                size = 4, vjust = 0.03) +
  scale_x_discrete(breaks = c(5, 6, 7, 8, 9),
                   labels = c("Maio", "Junho", "Julho",
                              "Agosto", "Setembro")) +
  labs(x = "Meses", y = "Temperatura média (Fahrenheit)") +
  theme_ipsum_rc(base_size = 10) +
  theme(legend.position = "none")



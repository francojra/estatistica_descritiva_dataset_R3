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

d <- arrange(d, desc(media_feed))
d

# Etapas da produção dos gráficos ----------------------------------------------------------------------------------------------------------

# 1. Definir variáveis e tipo de gráfico;
# 2. Definir títulos dos eixos;
# 3. Acrescentar um tema ao gráfico;
# 4. Reduzir largura das barras e retirar a legenda;
# 5. Mudar nome dos eixos;
# 6. Ordenar as barras da maior para menor.

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

library(ggplot2) # Pacote para produzir os gráficos
#install.packages("hrbrthemes")
library(hrbrthemes) # Pacote para mudar o tema do gráfico (cor preta)

positions <- c("sunflower", "casein", "meatmeal", "soybean", "linseed", "horsebean")

ggplot(d, aes(x = feed, y = media_feed, fill = feed)) +
  geom_col(width = 0.6) +
  geom_errorbar(aes(x = feed, ymin = media_feed - se, 
                ymax = media_feed + se), 
                width = 0.14, position = position_dodge(.9), size = 0.9) +
  scale_fill_manual(values = c("#1b9e77", "#d95f02", "#7570b3",
                               "#e7298a", "#66a61e", "#e6ab02")) +
  scale_x_discrete(limits = positions,
    breaks = c("casein", "horsebean", "linseed", 
                              "meatmeal", "soybean", "sunflower"),
    labels = c("Caseína", "Feijão", "Linhaça",
                              "Almôndegas", "Soja", "Girassol")) +
  labs(x = "Suplemento alimentar", y = "Peso (g)") +
  theme_ipsum_rc(base_size = 10) +
  theme(legend.position = "none")



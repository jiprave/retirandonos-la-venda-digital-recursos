#############################################################
# Figura 1 (Ed. 10 del newsletter). Patrones organizacionales a partir de Google Trends
# Pérez-Rave (2026)
#############################################################

#------------------------------------------------------------
# 1. Lectura de datos
#------------------------------------------------------------

datos <- read.csv(
  "https://raw.githubusercontent.com/jiprave/retirandonos-la-venda-digital-recursos/main/dataset_edicion10.csv.csv",
  sep = ",",
  stringsAsFactors = FALSE
)
#------------------------------------------------------------
# 2. Conversión de la fecha
#------------------------------------------------------------

datos$Mes <- as.Date(paste0(datos$Mes, "-01"))

#------------------------------------------------------------
# 3. Convertir a formato largo
#------------------------------------------------------------

datos.long <- data.frame(
  Mes = rep(datos$Mes, 5),
  Variable = factor(
    rep(c("MP", "IA", "RC", "ISO", "CE"), each = nrow(datos)),
    levels = c("MP", "IA", "RC", "ISO", "CE")
  ),
  Valor = c(
    datos$MP,
    datos$IA,
    datos$RC,
    datos$ISO,
    datos$CE
  )
)

#------------------------------------------------------------
# 4. Gráfico
#------------------------------------------------------------

library(ggplot2)

p <- ggplot(datos.long,
       aes(x = Mes,
           y = Valor,
           colour = Variable,
           group = Variable)) +
  
  geom_line(size = 0.8) +
  
  labs(
    x = "Mes",
    y = "Índice Google Trends",
    colour = NULL
  ) +
  
  theme_minimal(base_size = 12) +
  
  theme(
    legend.position = "bottom"
  ) +
  
  facet_wrap(~Variable)

p

#------------------------------------------------------------
# 5. Guardar figura
#------------------------------------------------------------

ggsave(
  "Figura10_1.png",
  plot = p,
  width = 10,
  height = 6,
  dpi = 300
)

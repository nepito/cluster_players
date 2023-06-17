library(tidyverse)
library(umap)
source("/workdir/R/select_variables.R")
# library(xgTools)
set.seed(2)
data_path <- "/workdir/tests/data/all_players.csv"
players_1 <- read_csv(data_path, show_col_types = FALSE) |>
  filter(`Minutes played` > 900)

metric <- "soccerment"
variables <- players_1 %>%
  select_variables[[metric]]()
my_umap <- variables %>%
  scale() %>%
  umap()

datos <- tibble(x = my_umap$layout[, 1], y = my_umap$layout[, 2])
n_grupos <- 5
groups <- kmeans(datos, n_grupos)

### Los jugadores a clasificar
players_1$grupos <- factor(groups$cluster)

predict.kmeans <- function(object, newdata) {
  centers <- object$centers
  n_centers <- nrow(centers)
  dist_mat <- as.matrix(dist(rbind(centers, newdata)))
  dist_mat <- dist_mat[-seq(n_centers), seq(n_centers)]
  max.col(-dist_mat)
}
datos$grupos <- factor(groups$cluster)
ggplot(datos, aes(x = x, y = y, color = grupos)) +
  geom_point()
ggsave(glue::glue("figurita_{metric}.png"))

players_1 %>%
  write_csv(glue::glue("results/clustered_macrogroup_with_{metric}.csv"))

library(tidyverse)
library(umap)
# library(xgTools)
set.seed(2)
players_1 <- read_csv("/workdir/results/cleaned_LigaMX_1_with_grupo_daves.csv", show_col_types = FALSE) |>
  distinct()

macro_grupo <- 4

cleaned_players <- players_1 %>%
  filter(`Minutes played` > 900 & Position != "GK") |>
  filter(grupos == macro_grupo)
players_varaibles <- cleaned_players %>%
  select(c(Player, "Minutes played", Position))
metric <- "central_attackers"
variables <- cleaned_players %>%
  select_variables[[metric]]()
my_umap <- variables %>%
  scale() %>%
  umap()

neighbors <- my_umap$knn$indexes[, 1:10]
neighbors_distances <- my_umap$knn$distances[, 1:10]

my_umap_10 <- umap.knn(indexes = neighbors, distances = neighbors_distances)


my_umap <- cleaned_players %>%
  select(-c(Player, "Minutes played", Position)) %>%
  umap(n_neighbors = 10, knn = my_umap_10)

datos <- tibble(x = my_umap$layout[, 1], y = my_umap$layout[, 2])
n_grupos <- 3
groups <- kmeans(datos, n_grupos)

datos$grupos <- factor(groups$cluster)
ggplot(datos, aes(x = x, y = y, color = grupos)) +
  geom_point()
ggsave(glue::glue("figurita_second_{metric}.png"))

cleaned_players$s_grupos <- factor(groups$cluster)



cleaned_players %>%
  select("Player", "Position", s_grupos) %>%
  left_join(players_1, by = c("Player", "Position")) %>%
  write_csv(glue::glue("results/cleaned_all_players_second_with_grupo_{metric}.csv"))

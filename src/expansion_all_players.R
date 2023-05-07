library(tidyverse)
library(umap)
#library(xgTools)
set.seed(2)
players_1 <- read_csv("/workdir/tests/data/cleaned_LigaMX_1.csv", show_col_types = FALSE)


cleaned_players <- players_1 %>%
  filter(`Minutes played` > 900 & Position != "GK")

my_umap <- cleaned_players %>%
  select(-c(Player, "Minutes played", Position)) %>%
  scale() %>%
  umap()

neighbors <- my_umap$knn$indexes[, 1:10]
neighbors_distances <- my_umap$knn$distances[, 1:10]

my_umap_10 <- umap.knn(indexes = neighbors, distances = neighbors_distances)


my_umap <- cleaned_players %>%
  select(-c(Player, "Minutes played", Position)) %>%
  umap(n_neighbors = 10, knn = my_umap_10)

datos <- tibble(x = my_umap$layout[, 1], y = my_umap$layout[, 2])
n_grupos <- 6
groups <- kmeans(datos, n_grupos)

datos$grupos <- factor(groups$cluster)
ggplot(datos, aes(x = x, y = y, color = grupos)) +
  geom_point()
ggsave("figurita.png")

cleaned_players$grupos <- factor(groups$cluster)



cleaned_players %>%
  select("Player", "Position", grupos) %>%
  left_join(players_1, by = c("Player", "Position")) %>%
  write_csv("results/cleaned_LigaMX_1_with_grupo.csv")

pca_liga_mx <- get_pca(cleaned_players)
nombres <- paste0("PC", 1:7)
names(pca_liga_mx$x[1:7]) <- nombres
the_roles <- cleaned_players %>%
  select(Player) %>%
  cbind(as_tibble(pca_liga_mx$x[, 1:7]))

the_roles_deciles <- the_roles %>%
  mutate(PC1 = ntile(PC1, 10)) %>%
  mutate(PC2 = ntile(PC2, 10)) %>%
  mutate(PC3 = ntile(PC3, 10)) %>%
  mutate(PC4 = ntile(PC4, 10)) %>%
  mutate(PC5 = ntile(PC5, 10)) %>%
  mutate(PC6 = ntile(PC6, 10)) %>%
  mutate(PC7 = ntile(PC7, 10))

deciles_to_plot <- the_roles_deciles %>%
  pivot_longer(cols = 2:8, names_to = "PC", values_to = "deciles")

larga <- the_roles_deciles %>%
  pivot_longer(cols = 2:8, names_to = "PC", values_to = "deciles")
aquino <- larga %>%
  filter(Player == "J. Aquino")

aquino %>% ggplot(aes(PC, deciles)) +
  geom_col() +
  coord_polar()

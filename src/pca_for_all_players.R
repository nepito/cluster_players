library(tidyverse)
library(umap)
# library(xgTools)
set.seed(2)
cleaned_players <- read_csv("results/cleaned_LigaMX_1_with_grupo.csv", show_col_types = FALSE)


pca_liga_mx <- cleaned_players |>
  get_pca()
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
player_name <- "E. Haaland"
aquino <- larga %>%
  filter(Player == player_name)

aquino %>% ggplot(aes(PC, deciles)) +
  geom_col() +
  coord_polar() +
  ggtitle(player_name)

ggsave("haaland.jpg")

library(tidyverse)
library(umap)
source("/workdir/R/expansion_all_players.R")
source("/workdir/R/select_variables.R")
sub_group = 3
players <- readr::read_csv("results/cleaned_all_players_second_with_grupo_central_attackers.csv", show_col_types = FALSE) |>
  distinct() |>
  filter(s_grupos == sub_group)

players_pca <- players |>
  get_pca()

players_rotations <- get_rotations_from_pca(players_pca)

all_variables <- comprehenr::to_vec(for(i in 1:6) sort_pca_positive(players_rotations, i)[1:4,2]) |>
  unique()

cuantiles_players <- players |>
  select(all_of(c("Player", all_variables)))
for (variable in all_variables) {
  cuan_var <- ntile(cuantiles_players[[variable]], 100)
  cuantiles_players[variable] <- cuan_var
}

typo_valiable <- comprehenr::to_vec(for (varible in all_variables) type_of_variable[[varible]])
tov <- tibble::tibble("variable" = all_variables, "type_variable" = typo_valiable)

larga <- cuantiles_players[!duplicated(cuantiles_players$Player),] |>
  pivot_longer(!Player, names_to = "variable", values_to = "deciles") |>
  left_join(tov) |>
  write_csv("results/larga_player.csv")

n_var <- length(all_variables) + 1
d_rice <- cuantiles_players[334, 2:n_var] |> as.numeric()
dista <- c()
for (i in 1:nrow(cuantiles_players)) {
  player <- cuantiles_players[i, 2:n_var] |> as.numeric()
  dista <- append(dista, sqrt(sum((player - d_rice)^2)))
}
cuantiles_players$dista <- dista
cuantiles_players$index <- 1:nrow(cuantiles_players)

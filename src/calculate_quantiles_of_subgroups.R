library(tidyverse)
library(umap)
source("/workdir/R/expansion_all_players.R")
source("/workdir/R/select_variables.R")
source("/workdir/R/tyoe_of_variable.R")
source("/workdir/R/forwards.R")
sub_group <- 3
players <- read_subgroup_of_players("results/second_clustered_macro_2_with_daves.csv", sub_group)

all_variables <- players |>
  get_principal_variables()

cuantiles_players <- players |>
  select(all_of(c("Player", all_variables)))
for (variable in all_variables) {
  cuan_var <- ntile(cuantiles_players[[variable]], 100)
  cuantiles_players[variable] <- cuan_var
}

typo_valiable <- comprehenr::to_vec(for (varible in all_variables) type_of_variable[[varible]])
tov <- tibble::tibble("variable" = all_variables, "type_variable" = typo_valiable)

larga <- cuantiles_players[!duplicated(cuantiles_players$Player), ] |>
  pivot_longer(!Player, names_to = "variable", values_to = "deciles") |>
  left_join(tov) |>
  write_csv("results/larga_player.csv")

n_var <- length(all_variables) + 1
d_rice <- cuantiles_players[434, 2:n_var] |> as.numeric()
dista <- c()
for (i in 1:nrow(cuantiles_players)) {
  player <- cuantiles_players[i, 2:n_var] |> as.numeric()
  dista <- append(dista, sqrt(sum((player - d_rice)^2)))
}
cuantiles_players$dista <- dista
cuantiles_players$index <- 1:nrow(cuantiles_players)
cuantiles_players$year <- players$year

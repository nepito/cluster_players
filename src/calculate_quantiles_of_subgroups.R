library(tidyverse)
library(umap)
source("/workdir/R/expansion_all_players.R")
source("/workdir/R/select_variables.R")
source("/workdir/R/type_of_variable.R")
source("/workdir/R/forwards.R")
source("/workdir/R/find_a_player.R")
source("/workdir/R/cli_options.R")

opciones <- cli_cluster_project()
player_name <- opciones[["player"]]
players_and_groups <- obtain_subgroup_from_name(player_name)
sub_group <- players_and_groups[["subgroup"]]
group <- players_and_groups[["macrogroup"]]
path_file <- players_and_groups[["path_file"]]
players <- read_subgroup_of_players(path_file, sub_group)

all_variables <- players |>
  get_principal_variables()

path_best_players <- glue::glue("/workdir/results/best_player_by_group_{group}_and_subgroup_{sub_group}.csv")

best_players <- comprehenr::to_vec(for (varible in all_variables) which.max(players[[varible]]))
players[best_players, c(1, 2, 8, 114)] |>
  add_column(all_variables) |>
  write_csv(path_best_players)

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

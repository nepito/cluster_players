library(tidyverse)
library(umap)
source("/workdir/R/select_variables.R")

player_longer <- tibble::tibble()
sorted_players <- read_csv("results/sorted_players.csv", show_col_types = FALSE)
metrics <- c("", "daves", "soccerment", "central_attackers", "central_midfielder")
for (macro_grupo in 2:5) {
  metric <- metrics[macro_grupo]
  macro_players <- sorted_players |>
    filter(grupos == macro_grupo)
  macro_variables <- macro_players |> select_variables[[metric]]()
  macro_names <- macro_players[, c(1, 2, 8, 114)]
  all_variables <- names(macro_variables)
  for (variable in all_variables) {
    cuan_var <- ntile(macro_variables[[variable]], 100)
    macro_names[variable] <- cuan_var
  }
  lp <- macro_names |>
    pivot_longer(!c("Player", "Team", "Minutes played", "year"), names_to = "variable", values_to = "deciles")
  player_longer <- rbind(player_longer, lp)
}
all_variables <- player_longer$variable |> unique()
typo_valiable <- comprehenr::to_vec(for (varible in all_variables) type_of_variable[[varible]])
tov <- tibble::tibble("variable" = all_variables, "type_variable" = typo_valiable)
player_longer |>
  filter(year == 23) |>
  select(c(Player, deciles, variable)) |>
  left_join(tov) |>
  write_csv("results/longer_player_table.csv")
sorted_players[, c(1, 2, 8, 114)] |>
  filter(year == 23) |>
  select(-year) |>
  write_csv("results/minutes_played.csv")

library(tidyverse)
source("/workdir/R/select_variables.R")
source("/workdir/R/type_of_variable.R")

player_longer <- tibble::tibble()
sorted_players <- read_csv("results/sorted_players.csv", show_col_types = FALSE)
clustar_variables <- c(names(sorted_players)[c(1, 2, 8, 114:117)], names(type_of_variable))
metrics <- c("", "just_select_daves", "soccerment", "central_attackers", "central_midfielder")
daves_values <- sorted_players |> select_variables[["daves"]]()
daves_variables <- names(daves_values)
for (variable in daves_variables) {
  sorted_players[variable] <- daves_values[variable]
}
sorted_players <- sorted_players |> select(all_of(clustar_variables))
for (variable in names(type_of_variable)) {
  cuan_var <- ntile(sorted_players[[variable]], 100)
  sorted_players[variable] <- cuan_var
}
for (macro_grupo in 2:5) {
  metric <- metrics[macro_grupo]
  macro_players <- sorted_players |>
    filter(grupos == macro_grupo)
  macro_variables <- macro_players |> select_variables[[metric]]()
  macro_names <- macro_players[, c(1:5)]
  all_variables <- names(macro_variables)
  for (variable in all_variables) {
    macro_names[variable] <- macro_variables[variable]
  }
  lp <- macro_names |>
    pivot_longer(!c("Player", "Team", "Minutes played", "year", "league_id"), names_to = "variable", values_to = "deciles")
  player_longer <- rbind(player_longer, lp)
}
all_variables <- player_longer$variable |> unique()
typo_valiable <- comprehenr::to_vec(for (varible in all_variables) type_of_variable[[varible]])
tov <- tibble::tibble("variable" = all_variables, "type_variable" = typo_valiable)
year_to_select <- 23
player_longer |>
  filter(year == year_to_select) |>
  select(c(Player, league_id, deciles, variable)) |>
  left_join(tov) |>
  write_csv(glue::glue("results/longer_player_table_{year_to_select}.csv"))
sorted_players[, c(1:5)] |>
  filter(year == year_to_select) |>
  select(-year) |>
  write_csv(glue::glue("results/minutes_played_{year_to_select}.csv"))

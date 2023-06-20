find_macro_group_for_all_players <- function(data_path = "/workdir/results/clustered_macrogroup_with_soccerment.csv", last_column = 115) {
  readr::read_csv(data_path, show_col_types = FALSE) |>
    dplyr::distinct() |>
    dplyr::select(c(1, 2, 4, "Birth country", "Passport country", 114:last_column))
}

obtain_group_from_name <- function(player_name) {
  player_row <- find_macro_group_for_all_players() |>
    dplyr::filter(Player == player_name, year == 23)
  return(list("name" = player_row[["Player"]], "macrogroup" = player_row[["grupos"]]))
}

obtain_subgroup_from_name <- function(player_name) {
  player_group <- obtain_group_from_name(player_name)
  data_path <- "/workdir/results/second_clustered_macro_4_with_central_attackers.csv"
  player_row <- find_macro_group_for_all_players(data_path, last_column = 116) |>
    .filter_player_and_year(player_name)
  return(
    list(
      "name" = player_row[["Player"]],
      "macrogroup" = player_row[["grupos"]],
      "subgroup" = player_row[["s_grupos"]]
    )
  )
}

.filter_player_and_year <- function(player_row, player_name, season_year = 23) {
  player_row |>
    dplyr::filter(Player == player_name, year == season_year)
}

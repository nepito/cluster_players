find_macro_group_for_all_players <- function(data_path = "/workdir/results/clustered_macrogroup_with_soccerment.csv") {
  readr::read_csv(data_path, show_col_types = FALSE) |>
    dplyr::distinct() |>
    dplyr::select(c(1, 2, 4, "Birth country", "Passport country", 114:115))
}

obtain_group_from_name <- function(player_name) {
  player_row <- find_macro_group_for_all_players() |>
    dplyr::filter(Player == player_name, year == 23)
  return(list("name" = player_row[["Player"]], "macrogroup" = player_row[["grupos"]]))
}

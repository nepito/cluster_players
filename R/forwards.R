read_subgroup_of_players <- function(path, sub_group) {
  players <- readr::read_csv(path, show_col_types = FALSE) |>
    dplyr::distinct() |>
    dplyr::filter(s_grupos == sub_group)
}

read_subgroup_of_players <- function(path, sub_group) {
  players <- readr::read_csv(path, show_col_types = FALSE) |>
    dplyr::distinct() |>
    dplyr::filter(s_grupos == sub_group)
}

get_principal_variables <- function(players) {
  players |>
    get_pca() |>
    get_rotations_from_pca() |>
    .obtain_unique_variables()
}

.obtain_unique_variables <- function(principal_variables) {
  comprehenr::to_vec(for (i in 1:6) sort_pca_positive(principal_variables, i)[1:4, 2]) |>
    unique()
}
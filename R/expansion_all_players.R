#' @import dplyr
#' @import tibble

get_pca_by_group <- function(data, group) {
  my_pca <- data %>%
    dplyr::filter(grupos == group) %>%
    dplyr::select(-c(Player, "Minutes played", Position, grupos)) %>%
    prcomp(scale = TRUE, center = TRUE, retx = T)
  return(my_pca)
}

#' @export
get_pca <- function(data) {
  my_pca <- data |>
    dplyr::select(-c("Player", "Minutes played", "Position", "grupos")) |>
    select_soccerment() |>
    prcomp(scale = TRUE, center = TRUE, retx = T)
  return(my_pca)
}

get_rotations_from_pca <- function(my_pca) {
  names_rows <- row.names(my_pca$rotation)
  rotaciones <- my_pca$rotation[, 1:8] |>
    tibble::as_tibble() |>
    cbind(tibble::as_tibble(names_rows))
  return(rotaciones)
}

show_15_players_of_group <- function(data, group) {
  data %>%
    dplyr::filter(grupos == group) %>%
    dplyr::select(c(Player, Position, grupos)) %>%
    head(15) %>%
    print()
}


sort_pca <- function(rotations, axis) {
  names_pc <- names(rotations)
  rotations %>%
    dplyr::select(all_of(c(axis, 9))) %>%
    arrange(-abs(.data[[names_pc[axis]]])) %>%
    print()
}

sort_pca_positive <- function(rotations, axis) {
  names_pc <- names(rotations)
  rotations |>
    dplyr::select(all_of(c(axis, 9))) |>
    dplyr::arrange(.data[[names_pc[axis]]])
}

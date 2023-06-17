get_pca_by_group <- function(data, group) {
  my_pca <- data %>%
    filter(grupos == group) %>%
    select(-c(Player, "Minutes played", Position, grupos)) %>%
    prcomp(scale = TRUE, center = TRUE, retx = T)
  return(my_pca)
}

#' @export
get_pca <- function(data) {
  my_pca <- data %>%
    select(-c(Player, "Minutes played", Position, grupos)) %>%
    select_soccerment() |>
    prcomp(scale = TRUE, center = TRUE, retx = T)
  return(my_pca)
}

get_rotations_from_pca <- function(my_pca) {
  names_rows <- row.names(my_pca$rotation)
  rotaciones <- my_pca$rotation[, 1:8] %>%
    as_tibble() %>%
    cbind(as.tibble(names_rows))
  return(rotaciones)
}

show_15_players_of_group <- function(data, group) {
  data %>%
    filter(grupos == group) %>%
    select(c(Player, Position, grupos)) %>%
    head(15) %>%
    print()
}


sort_pca <- function(rotations, axis) {
  names_pc <- names(rotations)
  rotations %>%
    select(all_of(c(axis, 9))) %>%
    arrange(-abs(.data[[names_pc[axis]]])) %>%
    print()
}

sort_pca_positive <- function(rotations, axis) {
  names_pc <- names(rotations)
  rotations %>%
    select(all_of(c(axis, 9))) %>%
    arrange(.data[[names_pc[axis]]])
}

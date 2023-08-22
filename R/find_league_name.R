find_league_name_from_list <- function(list_files) {
  list_files |>
    .extract_name_files() |>
    .extract_name_leagues()
}

.extract_name_leagues <- function(name_files) {
  comprehenr::to_vec(for (name in name_files) stringr::str_split(name, "_[:digit:]{2}")[[1]][1])
}

.extract_name_files <- function(list_files) {
  comprehenr::to_vec(for (file in list_files) stringr::str_split(file, "/")[[1]][4])
}

find_year_from_list <- function(list_files) {
  list_files |>
    .extract_last_year_from_list() |>
    .remove_csv_extension()
}

.extract_last_year_from_list <- function(list_files) {
  comprehenr::to_vec(for (file in list_files) stringr::str_split(file, "-")[[1]][2])
}

.remove_csv_extension <- function(list_files) {
  comprehenr::to_vec(for (file in list_files) stringr::str_split(file, "\\.")[[1]][1])
}

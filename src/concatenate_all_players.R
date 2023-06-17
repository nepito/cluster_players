library("tidyverse")
library("comprehenr")
csv_files <- list.files("/workdir/data/", pattern = "csv$")
all_players_paths <- to_vec(for (file in csv_files) glue::glue("/workdir/data/{file}"))
years_and_csv <- to_vec(for (year in all_players_paths) str_split(year, "-")[[1]][2])
years <- to_vec(for (year in years_and_csv) str_split(year, "\\.")[[1]][1])
all_players <- tibble::tibble()
for (i in 1:length(all_players_paths)) {
  new_league <- read_csv(all_players_paths[i], show_col_types = FALSE) |>
    add_column(year = years[i])
  all_players <- rbind(all_players, new_league)
}

all_players |> write_csv("/workdir/tests/data/all_players.csv")

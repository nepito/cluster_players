library("tidyverse")
library("comprehenr")
source("/workdir/R/find_league_name.R")
csv_files <- list.files("/workdir/data/", pattern = "csv$")
all_players_paths <- to_vec(for (file in csv_files) glue::glue("/workdir/data/{file}"))
years <- find_year_from_list(all_players_paths)
all_players <- tibble::tibble()
for (i in 1:length(all_players_paths)) {
  new_league <- read_csv(all_players_paths[i], show_col_types = FALSE) |>
    add_column(year = years[i])
  all_players <- rbind(all_players, new_league)
  print(all_players_paths[i])
}

all_players |> write_csv("/workdir/tests/data/all_players.csv")

library("tidyverse")
library("comprehenr")
csv_files <- list.files("/workdir/data/", pattern = "csv$")
all_players_paths <- to_vec(for (file in csv_files) glue::glue("/workdir/data/{file}"))
all_players <- read_csv(all_players_paths, show_col_types = FALSE) |>
  write_csv("/workdir/tests/data/all_players.csv")

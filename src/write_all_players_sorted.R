library(tidyverse)

paths <- c(
  "results/second_clustered_macro_2_with_daves.csv",
  "results/second_clustered_macro_3_with_soccerment.csv",
  "results/second_clustered_macro_4_with_central_attackers.csv",
  "results/second_clustered_macro_5_with_central_midfielder.csv"
)
read_csv(paths, show_col_types = FALSE) |>
  write_csv("results/sorted_players.csv")

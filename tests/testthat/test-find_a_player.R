describe("Find macro group", {
  it("From 'results/clustered_macrogroup_with_soccerment.csv'", {
data_path <- "/workdir/results/clustered_macrogroup_with_soccerment.csv"
players_1 <- dplyr::read_csv(data_path, show_col_types = FALSE) |>
  distinct()
    path_of_expected <- "tests/data/player_with_first_group.csv"
    expected <- dplyr::read_csv(path_of_expected , show_col_types = FALSE)
    obtained <- find_macro_group_for_all_players(data = "/workdir/results/clustered_macrogroup_with_soccerment.csv")
    expect_equal(obtained, expected)
  })
})
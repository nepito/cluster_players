describe("Find macro group", {
  it("From 'results/clustered_macrogroup_with_soccerment.csv'", {
    data_path <- "/workdir/results/clustered_macrogroup_with_soccerment.csv"
    players_1 <- readr::read_csv(data_path, show_col_types = FALSE) |>
      distinct()
    path_of_expected <- "/workdir/tests/data/player_with_first_group.csv"
    expected <- readr::read_csv(path_of_expected, show_col_types = FALSE)
    obtained <- find_macro_group_for_all_players()
    expect_equal(obtained, expected)
  })
  it("Return the name and the macrogroup from the name", {
    player_name <- "Hee-Chan Hwang"
    obtained <- obtain_group_from_name(player_name)
    expected <- list("name" = "Hee-Chan Hwang", "macrogroup" = 4)
    expect_equal(obtained, expected)
  })
  it("Find second group", {
    player_name <- "Hee-Chan Hwang"
    obtained <- obtain_subgroup_from_name(player_name)
    expected <- list(
      "name" = "Hee-Chan Hwang",
      "macrogroup" = 4,
      "subgroup" = 2,
      "path_file" = "/workdir/results/second_clustered_macro_4_with_central_attackers.csv"
    )
    expect_equal(obtained, expected)
  })
})

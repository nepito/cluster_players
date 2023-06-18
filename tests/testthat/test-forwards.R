describe("read data and filter by subgroups", {
  it("Data of macro 2 second grouped using daves variables", {
    data_path <- "/workdir/tests/data/second_clustered_macro_2_with_daves.csv"
    expected_path <- "/workdir/tests/data/data_2_daves_3.csv"
    obtained <- read_subgroup_of_players(path = data_path, sub_group = 3)
    expected <- readr::read_csv(expected_path, show_col_types = FALSE)
    expect_equal(obtained, expected)
  })
})

describe("Get the principal variables", {
  it("get_principal_variables", {
    subgroup_path <- "/workdir/tests/data/data_2_daves_3.csv"
    players <- readr::read_csv(subgroup_path, show_col_types = FALSE)
    obtained <- get_principal_variables(players)
    expected <- c(
      "Passes to penalty area per 90", "Passes to final third per 90", "Progressive passes per 90",
      "Through passes per 90", "Lateral passes per 90", "Long passes per 90",
      "Progressive runs per 90", "Back passes per 90", "Dribbles per 90",
      "Crosses to goalie box per 90", "Crosses per 90", "Shots blocked per 90",
      "Interceptions per 90", "Touches in box per 90",
      "Shots per 90"
    )
    expect_equal(obtained, expected)
  })
})

describe("read data and filter by subgroups", {
  it("Data of macro 2 second grouped using daves variables", {
    data_path <- "/workdir/tests/data/second_clustered_macro_2_with_daves.csv"
    expected_path <- "/workdir/tests/data/data_2_daves_3.csv"
    obtained <- read_subgroup_of_players(path = data_path, sub_group = 3)
    expected <- readr::read_csv(expected_path, show_col_types = FALSE)
    expect_equal(obtained, expected)
  })
})

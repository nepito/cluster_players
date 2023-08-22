describe("find_league_name_from_list()", {
  it("Gold 🪙", {
    list_files <- c("/workdir/data/femenil_mx_22-23.csv", "/workdir/data/LigaMX_22-23.csv", "/workdir/data/ligue_1_22-23.csv")
    expected <- c("femenil_mx", "LigaMX", "ligue_1")
    obtained <- find_league_name_from_list(list_files)
    expect_equal(obtained, expected)
  })
  it("Silver 🥈: name league from name files", {
    name_files <- c("femenil_mx_22-23.csv", "LigaMX_22-23.csv", "ligue_1_22-23.csv")
    expected <- c("femenil_mx", "LigaMX", "ligue_1")
    obtained <- extract_name_leagues(name_files)
    expect_equal(obtained, expected)
  })
  it("Silver 🥈: name files", {
    list_files <- c("/workdir/data/femenil_mx_22-23.csv", "/workdir/data/LigaMX_22-23.csv", "/workdir/data/ligue_1_22-23.csv")
    expected <- c("femenil_mx_22-23.csv", "LigaMX_22-23.csv", "ligue_1_22-23.csv")
    obtained <- extract_name_files(list_files)
    expect_equal(obtained, expected)
  })
})

describe("find_year_from_list()", {
  it("Gold 🪙", {
    list_files <- c("/workdir/data/femenil_mx_20-21.csv", "/workdir/data/LigaMX_21-22.csv", "/workdir/data/ligue_1_22-23.csv")
    obtained <- find_year_from_list(list_files)
    expected <- c("21", "22", "23")
    expect_equal(obtained, expected)
  })
  it("Silver 🥈: The last year in name files", {
    list_files <- c("/workdir/data/femenil_mx_20-21.csv", "/workdir/data/LigaMX_21-22.csv", "/workdir/data/ligue_1_22-23.csv")
    obtained <- extract_last_year_from_list(list_files)
    expected <- c("21.csv", "22.csv", "23.csv")
    expect_equal(obtained, expected)
  })
})
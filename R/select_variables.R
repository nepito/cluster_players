select_soccerment <- function(all_variables) {
  all_variables |>
    select(
      c(
        "Interceptions per 90",
        "Sliding tackles per 90",
        "Shots blocked per 90",
        "Fouls per 90",
        "Aerial duels per 90",
        "Passes to final third per 90",
        "Long passes per 90",
        "Progressive passes per 90",
        "Crosses per 90",
        "Progressive runs per 90",
        "Dribbles per 90",
        "Touches in box per 90",
        "Through passes per 90",
        "Shots per 90",
        "Crosses to goalie box per 90",
        "Passes to penalty area per 90",
        "Back passes per 90",
        "Lateral passes per 90",
      )
    )
}

drop_goalkeeper_variables <- function(all_variables) {
  all_variables |>
    select(
      -c(
        "Conceded goals per 90",
        "Shots against per 90",
        "Prevented goals", "Prevented goals per 90",
        "Exits per 90", "Aerial duels per 90_2"
      )
    )
}

select_daves <- function(all_variables) {
  all_variables |>
    select(
      c(
        "xG per 90",
        "xA per 90",
        "Touches in box per 90",
        "Progressive runs per 90",
        "Back passes per 90",
        "Lateral passes per 90",
        "Average long pass length, m",
        "Key passes per 90",
        "Shots per 90",
        "Shots on target, %",
        "Progressive passes per 90",
        "Sliding tackles per 90",
        "Passes per 90",
        "Fouls suffered per 90",
        "Dribbles per 90",
        "Successful dribbles, %",
        "Penalties taken",
        "Penalty conversion, %"
      )
    ) |>
    mutate(
      shots = ifelse(`Shots on target, %` == 0, 0,100 * `Shots per 90` / `Shots on target, %`),
      Penalties_won = ifelse(`Penalty conversion, %` == 0, 0, 100 * `Penalties taken` / `Penalty conversion, %`),
      Successful_dribbles = ifelse(`Successful dribbles, %` == 0, 0, 100 * `Dribbles per 90` / `Successful dribbles, %`)
    ) |>
    select(
      -c("Penalty conversion, %", "Successful dribbles, %", "Shots on target, %")
    )
}

select_second <- function(all_variables) {
  all_variables |>
    select(
      c(
        "Interceptions per 90",
        "Shots blocked per 90",
        "Fouls per 90",
        "Aerial duels per 90",
        "Passes to final third per 90",
        "Long passes per 90",
        "Short / medium passes per 90",
        "Through passes per 90",
        "Passes to penalty area per 90",
        "Touches in box per 90",
        "Back passes per 90",
        "Lateral passes per 90",
        "Average long pass length, m",
        "Key passes per 90",
        "Shots per 90",
        "Progressive passes per 90",
        "Sliding tackles per 90",
        "Passes per 90",
        "Dribbles per 90",
        "Received passes per 90",
        "Received long passes per 90",
        "Second assists per 90",
        "Shot assists per 90",
        "Third assists per 90",
        "Smart passes per 90",
        "Forward passes per 90",
        "Crosses per 90",
        "Crosses to goalie box per 90"
      )
    )
}

central_attackers <- function(all_variables) {
  all_variables |>
    select(
      c(
        "Key passes per 90",
        "Progressive passes per 90",
        "Passes per 90",
        "Dribbles per 90",
        "Received passes per 90",
        "Fouls suffered per 90",
        "Fouls per 90",
        "Aerial duels per 90",
        "Touches in box per 90",
        "Received long passes per 90",
        "Back passes per 90",
        "Crosses to goalie box per 90",
      )
    )
}

central_midfielder <- function(all_variables) {
  all_variables |>
    select(
      c(
        "Aerial duels per 90",
        "Interceptions per 90",
        "Shots blocked per 90",
        "Passes per 90",
        "Key passes per 90",
        "Progressive passes per 90",
        "Passes to final third per 90",
        "Long passes per 90",
        "Short / medium passes per 90",
        "Through passes per 90",
        "Passes to penalty area per 90",
        "Back passes per 90",
        "Lateral passes per 90",
        "Forward passes per 90",
        "Touches in box per 90",
        "Dribbles per 90",
        "Fouls suffered per 90",
        "Fouls per 90",
        "Received passes per 90",
        "Received long passes per 90",
        "Second assists per 90",
        "Shot assists per 90",
        "Third assists per 90",
        "Smart passes per 90",
        "Crosses per 90",
        "Crosses to goalie box per 90"
      )
    )
}

select_variables = list(
  "daves" = select_daves,
  "soccerment" = select_soccerment,
  "second" = select_second,
  "central_attackers" = central_attackers,
  "central_midfielder" = central_midfielder
)
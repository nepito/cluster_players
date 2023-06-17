library(tidyverse)
logo <- list(
  "inglaterra"="/workdir/tests/data/logo_premier.png",
  "Primeira liga"="/workdir/tests/data/logo_primeira.png"
  )
nies <- png::readPNG("/workdir/tests/data/logo_nies.png", native = TRUE)
premier <- png::readPNG(logo[["Primeira liga"]], native = TRUE)
larga_players <- readr::read_csv("results/larga_player.csv") |>
  distinct()
player_name <- "M. Taremi"
player_stats <- larga_players |>
  dplyr::filter(Player == player_name) |>
  arrange(type_variable)
players <- readr::read_csv("results/second_clustered_macro_4_with_central_attackers.csv", show_col_types = FALSE) |>
  dplyr::filter(Player == player_name)
write_title <- function(player) {
  glue::glue("{player$Player}, {player$Team}, Primeira liga \n Percentile ranking ({player$`Minutes played`} minutes played)")
}
title <- write_title(players)

player_stats$id <- seq(1, nrow(player_stats))

n_var <- larga_players$variable |>
  unique() |>
  length()

player_to_plot <- player_stats[1:n_var, ] |>
  separate(variable, sep = " per ", c("variable", NA)) |>
  mutate(type_variable = factor(type_variable))
player_to_plot$variable <- factor(
  player_to_plot$variable,
  levels = player_to_plot$variable[order(player_to_plot$type_variable, decreasing = TRUE)]
)

empty_bar <- 2
to_add <- data.frame(matrix(NA, empty_bar * nlevels(player_to_plot$type_variable), ncol(player_to_plot)))
colnames(to_add) <- colnames(player_to_plot)
to_add$type_variable <- rep(levels(player_to_plot$type_variable), each = empty_bar)
player_to_plot <- rbind(player_to_plot, to_add)
player_to_plot <- player_to_plot %>% arrange(type_variable)
player_to_plot$id <- seq(1:nrow(player_to_plot))

label_data <- player_to_plot
number_of_bar <- nrow(label_data)
angle <- 90 - 360 * (label_data$id - 0.5) / number_of_bar # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust <- ifelse(angle < -90, 1, 0)
label_data$angle <- ifelse(angle < -90, angle + 180, angle)

base_data <- player_to_plot %>%
  group_by(type_variable) %>%
  summarize(start = min(id), end = max(id) - empty_bar) %>%
  rowwise() %>%
  mutate(title = mean(c(start, end)))

grid_data <- base_data
grid_data$end <- grid_data$end[c(nrow(grid_data), 1:nrow(grid_data) - 1)] + 1
grid_data$start <- grid_data$start - 1
grid_data <- grid_data[-1, ]

player_to_plot %>% ggplot(aes(id, deciles, fill = factor(type_variable))) +
  geom_segment(data = grid_data, aes(x = end, y = 100, xend = start, yend = 100), colour = "grey", alpha = 1, size = 0.3, inherit.aes = FALSE) +
  geom_segment(data = grid_data, aes(x = end, y = 80, xend = start, yend = 80), colour = "grey", alpha = 1, size = 0.3, inherit.aes = FALSE) +
  geom_segment(data = grid_data, aes(x = end, y = 60, xend = start, yend = 60), colour = "grey", alpha = 1, size = 0.3, inherit.aes = FALSE) +
  geom_segment(data = grid_data, aes(x = end, y = 40, xend = start, yend = 40), colour = "grey", alpha = 1, size = 0.3, inherit.aes = FALSE) +
  geom_segment(data = grid_data, aes(x = end, y = 20, xend = start, yend = 20), colour = "grey", alpha = 1, size = 0.3, inherit.aes = FALSE) +
  annotate("text", x = rep(max(player_to_plot$id), 5), y = c(20, 40, 60, 80, 100), label = c("20", "40", "60", "80", "100"), color = "grey", size = 3, angle = 0, fontface = "bold", hjust = 1) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    legend.position = c(0.9, 0.1),
    legend.box = "horizontal"
  ) +
  guides(fill = guide_legend(title = "")) +
  geom_col() +
  coord_polar() +
  scale_y_continuous(limits = c(-50, 120), breaks = seq(20, 100, by = 20)) +
  ggtitle(title) +
  ylab("") +
  xlab("") +
  geom_text(aes(label = deciles), vjust = 0) +
  geom_text(data = label_data, aes(x = id, y = deciles + 10, label = variable, hjust = hjust), color = "black", fontface = "bold", alpha = 0.6, size = 2.5, angle = label_data$angle, inherit.aes = FALSE) +
  patchwork::inset_element(p = nies, left = 0.005, bottom = 0.01, right = 0.295, top = 0.1) +
  patchwork::inset_element(p = premier, left = 0.900, bottom = 0.90, right = 1.05, top = 1.05)

ggsave(glue::glue("{player_name}.jpg"))

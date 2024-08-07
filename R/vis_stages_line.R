vis_stages_line <- function(sf_stages_line) {
  ggplot() +
    annotation_map_tile(zoom = 8, type = "cartolight") +
    layer_spatial(sf_stages_line, aes(color = stage_id)) +
    theme(legend.position = "bottom") +
    labs(
      color = "Stage Number",
      title = "Deutschland Tour 2024",
      subtitle = "Color indicates Stage Number")
}
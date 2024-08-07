vis_stages_line_interactive <- function(sf_stages_line) {
  sf_vis <- sf_stages_line |>
    mutate(stage_id = as_factor(stage_id))
  
  factpal <- colorFactor(topo.colors(nrow(sf_vis)), sf_vis$stage_id)
  
  leaflet(sf_vis) |>
    addPolylines(color = ~factpal(stage_id)) |>
    addTiles()
}
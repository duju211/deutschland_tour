source("libraries.R")

walk(dir_ls("R"), source)

list(
  tar_target(
    gpx_url, c(
      "https://www.deutschland-tour.com/fileadmin/content/2_Deutschland_Tour/DT_24/Elite/DT24_E1_SW-HN_177km_inklneutral.gpx",
      "https://www.deutschland-tour.com/fileadmin/content/2_Deutschland_Tour/DT_24/Elite/DT24_E2_HN-GD_173km_inklneutral.gpx",
      "https://www.deutschland-tour.com/fileadmin/content/2_Deutschland_Tour/DT_24/Elite/DT24_E3_GD-VS_211km_inklneutral.gpx",
      "https://www.deutschland-tour.com/fileadmin/content/2_Deutschland_Tour/DT_24/Elite/DT24_E4_Annw-SB_182km_inklneutral.gpx")),
  
  tar_target(df_stages, map_df(gpx_url, \(x) stage(x), .id = "stage_id")),
  tar_target(
    sf_stages, st_as_sf(
      df_stages, coords = c("lon", "lat"), crs = st_crs(4326))),
  tar_target(
    sf_stages_multipoint,
    summarise(sf_stages, geometry = st_combine(geometry), .by = stage_id)),
  tar_target(sf_stages_line, st_cast(sf_stages_multipoint, "LINESTRING")),
  tar_target(gg_stages_line, vis_stages_line(sf_stages_line)),
  tar_target(
    gg_stages_line_interactive, vis_stages_line_interactive(sf_stages_line)),
  
  tar_render(deutschland_tour_report, "deutschland_tour.Rmd")
)

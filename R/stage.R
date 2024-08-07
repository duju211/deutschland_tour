stage <- function(gpx_url) {
  res_path <- file_temp()
  
  req_perform(request(gpx_url), path = res_path)
  
  gpx_xml <- read_xml(res_path)
  
  gpx_trackpoints <- gpx_xml |>
    xml_child(1) |>
    xml_child(2) |>
    xml_children()
  
  tibble(
    lat = xml_attr(gpx_trackpoints, "lat"),
    lon = xml_attr(gpx_trackpoints, "lon"),
    elevation = xml_text(xml_children(gpx_trackpoints))) |>
    mutate(point_nr = row_number())
}
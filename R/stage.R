stage <- function(gpx_url, css_track_point) {
  resp <- req_perform(request(gpx_url))
  
  gpx_trackpoints <- resp_body_string(resp) |>
    read_html() |>
    html_elements(css_track_point)
  
  tibble(
    lat = html_attr(gpx_trackpoints, "lat"),
    lon = html_attr(gpx_trackpoints, "lon"),
    elevation = html_text(gpx_trackpoints))
}
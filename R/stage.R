stage <- function(gpx_url) {
  resp <- req_perform(request(gpx_url))
  
  gpx_trackpoints <- resp_body_string(resp) |>
    read_html() |>
    html_elements("trkpt")
  
  tibble(
    lat = html_attr(gpx_trackpoints, "lat"),
    lon = html_attr(gpx_trackpoints, "lon"),
    elevation = html_text(gpx_trackpoints))
}
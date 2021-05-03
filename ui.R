library(leaflet) # probably should be in global.R but put here for easier deletion

htmlTemplate(
  filename = "template.html",
  leaflet_widget = leafletOutput("leaf1")
)
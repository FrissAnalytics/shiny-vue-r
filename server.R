function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)
  
  observeEvent(input$data_store, {

    rVuex("movieDetails", get_movie_details(input$data_store$id) %>% toJSON)
    
  })
  
  plotServer("server1")
  
  plotServer("server2")
  
  rVuex("setPopular", df_popular %>%toJSON) 
  
  observeEvent(input$search, {
  
    req(input$search$value)
  
    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)
  
    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )
  
    rVuex("setSuggestions", result %>% head(200) %>% toJSON)
  })

  
  get_widget_data <- function(widget) { htmltools::as.tags(widget)[[2]]$children[[1]] }
 
  rand_lng <- function(n = 10) rnorm(n, -93.65, .01)
  
  rand_lat <- function(n = 10) rnorm(n, 42.0285, .01)
 
  p <- leaflet() %>% 
    addTiles() %>% 
    addCircles(rand_lng(50), rand_lat(50), radius = runif(50, 50, 150))
  
  
  session$sendCustomMessage(
    "setShinyInput",
    list(input = "leafsettings", value = get_widget_data(p))
  )
  
  session$sendCustomMessage(
    "setShinyInput",
    list(input = "leaf2settings", value = get_widget_data(p))
  )
  
  observe({
    invalidateLater(1000, session)
    leafletProxy("leaf2") %>%
      clearShapes() %>%
      addCircles(rand_lng(50), rand_lat(50), radius = runif(50, 50, 150))
  })
  
  
}
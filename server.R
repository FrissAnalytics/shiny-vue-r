function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)
  
  output$plot1 <- renderPlot({

    input$"v-plot1"
    
    df <- imdb_movies %>% sample_frac(0.1) %>% filter(production_company %in% top5$production_company)

    ggplot(df, aes(production_company)) + geom_bar()

  })
  
  output$plot2 <- renderPlot({
    
    input$"v-plot2"
    
    df <- imdb_movies %>% sample_frac(0.05) %>% filter(production_company %in% top3$production_company)
    
    ggplot(df, aes(production_company)) + geom_bar()
    
  })
  
  rVuex("setPopular", df_popular %>%toJSON) 
  

  ###  leaflet widget example
  # helper function to extract x from a widget
  get_widget_data <- function(widget) { htmltools::as.tags(widget)[[2]]$children[[1]] }
  # functions from leaflet example
  rand_lng <- function(n = 10) rnorm(n, -93.65, .01)
  rand_lat <- function(n = 10) rnorm(n, 42.0285, .01)
  # quick leaflet widget
  p <- leaflet() %>% 
    addTiles() %>% 
    addCircles(rand_lng(50), rand_lat(50), radius = runif(50, 50, 150))
  # update store with leaflet data and options
  rVuex("setLeafletx", get_widget_data(p))
  
 observeEvent(input$search, {

    req(input$search$value)

    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)

    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )

    rVuex("setSuggestions", result %>% head(200) %>%toJSON)
 })

}
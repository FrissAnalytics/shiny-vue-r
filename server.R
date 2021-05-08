function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)
 
  # initial vuex data
  rVuex("setPopular", df_popular) 
  
  rVuex("setCovid", hopkins) 
  
  rVuex("setCountries", countries )
  
  rVuex("setAirports", airports )
  
  # auto-completion example
  observeEvent(input$search, {
  
    req(input$search$value)
  
    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)
  
    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )
  
    rVuex("setSuggestions", result %>% head(200))
  })
  
  # R as a data broker example
  observeEvent(input$data_store, {
    
    details <- get_movie_details(input$data_store$id)
    
    rVuex("movieDetails", details)
    
  })
  
  # ggplot moduleServer example
  plotServer("server1")
  
  plotServer("server2")

}
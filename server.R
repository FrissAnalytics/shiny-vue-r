function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)
 
  # init vuex data
  rVuexSetState("popular", df_popular) 
  
  rVuexSetState("covid", hopkins) 
  
  rVuexSetState("countries", countries )
  
  rVuexSetState("airports", airports )
  
  rVuexSetState("total", am_data$total)
  
  # auto-completion example
  observeEvent(input$search, {
  
    req(input$search$value)
  
    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)
  
    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )
  
    rVuexSetState("suggestions", result %>% head(200))
  })
  
  # R as a data broker example
  observeEvent(input$data_store, {
    
    details <- get_movie_details(input$data_store$id)
    
    rVuexSetState("movieDetails", details)
    
  })
  
  # ggplot moduleServer example
  plotServer("server1")
  
  plotServer("server2")

}
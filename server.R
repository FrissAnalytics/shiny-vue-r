function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)
 
  # init vuex data
  rVuexSetState("popular", df_popular) 
  
  rVuexSetState("covid", hopkins) 
  
  rVuexSetState("countries", countries )
  
  rVuexSetState("airports", airports )
  
  rVuexSetState("total", am_data$total)
  
  rVuexSetState("oscars", tmdb_oscar_winners)
  
  rVuexSetState("kaggle", kaggle_oscars_tmdb)
  
  rVuexSetState("storylines", storylines, auto_unbox = FALSE)
  
  rVuexSetState("totalTimeline", am_data$total_timeline)
  
  # auto-completion example
  observeEvent(input$search, {
  
    req(input$search$value)
  
    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)
  
    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )
  
    rVuexSetState("suggestions", result %>% head(50))
  })
  
  # R as a data broker example
  observeEvent(input$data_store, {
    
    # movies
    if(input$data_store$type == "movie-details"){
      
      cat("\nget movie details")
      
      details <- get_movie_details2(input$data_store$id)
      
      rVuexSetState("movieDetails", details)
      
    } 
    
    # persons
    if(input$data_store$type == "person-details"){
      
      cat("\nget person details")
      
      details <- get_person_details(input$data_store$id)
      
      rVuexSetState("personDetails", details)
      
    }
    
  })
  

  # ggplot moduleServer example
  plotServer("server1")
  
  plotServer("server2")

}
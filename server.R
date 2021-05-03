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

}
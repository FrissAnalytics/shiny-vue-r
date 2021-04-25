library(shiny)
library(httr)
library(jsonlite)
library(tidyverse)
library(TMDb)


load("data/imdb_movies.RData")

api_key   <- "1832c46bf5ad73f96183eaddb5f8ab88"

  
url       <- paste0("https://api.themoviedb.org/3/movie/550?api_key=",api_key)

movie     <- GET(url) %>% content

df_movies <- imdb_movies %>% arrange(desc(avg_vote)) %>% top_n(1000)

df_movies <- df_movies[, c("imdb_title_id", "original_title", "metascore", "avg_vote", "year", "genre", "director", "production_company")]

top10     <- df_movies  %>% count(production_company) %>% top_n(10)

df_bars   <- data.frame( movies_per_year = df_movies$year %>% table %>% as.vector)

c3_data   <- list( type = "bar", json = df_bars, colors = list(movies_per_year = "#304FFE"))


### get some TMDB toy data
schema <- fromJSON("data/tmdb_schema.json")

base_url <- schema$images$secure_base_url

now_playing <- movie_now_playing(api_key, page = 1, language = "en")

popular_movies <- NULL

for(page in 1:3){
  df <- movie_popular(api_key, page = page, language = "en")$results  %>% filter(original_language == "en")
  popular_movies <- rbind(popular_movies, df)
}


top_rated   <- movie_top_rated(api_key, page = 1, language = "en")

upcoming    <- movie_upcoming(api_key, page = 1, language = "en")

popular     <- person_popular(api_key, page = 1)

most_popular <- popular$results[1,]

person      <- person_tmdb(api_key, most_popular$id)


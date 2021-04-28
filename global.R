library(shiny)
library(httr)
library(jsonlite)
library(tidyverse)
library(TMDb)
library(curl)
library(magrittr)


load("data/imdb_movies.RData")

# 
# load("data/imdb_names.RData")
# 
# api_key   <- "1832c46bf5ad73f96183eaddb5f8ab88"
# 
# url       <- paste0("https://api.themoviedb.org/3/movie/550?api_key=",api_key)
# 
# movie     <- GET(url) %>% content
# 
# df_movies <- imdb_movies %>% arrange(desc(avg_vote)) %>% top_n(1000)
# 
# df_movies <- df_movies[, c("imdb_title_id", "original_title", "metascore", "avg_vote", "year", "genre", "director", "production_company")]
# 
# top10     <- df_movies  %>% count(production_company) %>% top_n(10)
# 
# df_bars   <- data.frame( movies_per_year = df_movies$year %>% table %>% as.vector)
# 
# c3_data   <- list( type = "bar", json = df_bars, colors = list(movies_per_year = "#304FFE"))
# 
# schema    <- fromJSON("data/tmdb_schema.json")
# 
# base_url  <- schema$images$secure_base_url
# 
# now_playing <- movie_now_playing(api_key, page = 1, language = "en")
# 
# popular_movies <- NULL
# 
# for(page in 1:8){
# 
#   df <- movie_popular(api_key, page = page, language = "en")$results %>%
#           filter(original_language == "en")
# 
#   popular_movies <- rbind(popular_movies, df)
# }
# 
# popular_movies  <- popular_movies[!is.na(popular_movies$backdrop_path), ]
# 
# top_rated       <- movie_top_rated(api_key, page = 1, language = "en")
# 
# upcoming        <- movie_upcoming(api_key, page = 1, language = "en")
# 
# popular         <- person_popular(api_key, page = 1)
# 
# most_popular    <- popular$results[1,]
# 
# person          <- person_tmdb(api_key, most_popular$id)
# 
# birth           <- imdb_names %>% count(place_of_birth, sort = TRUE)
# 
# reason_of_death <- imdb_names %>%
#                      filter(!is.na(reason_of_death) & reason_of_death != "undisclosed") %>%
#                      count(reason_of_death, sort = TRUE)


# ## discover API examples
# 
# # 1
# x <- GET(paste0("https://api.themoviedb.org/3/discover/movie?api_key=",api_key,"&with_genres=27")) %>% content
# 
# # 2
# base_url2 <- "https://api.themoviedb.org/3"
# url <- paste0(base_url2, "/discover/movie?with_genres=878&with_cast=500&sort_by=vote_average.desc&api_key=",api_key)
# 
# x <- GET(url) %>% content
# 
# 
# ## async GET request test
# 
# # see also https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html
# # see also
# 
# # helper to create request to get movie details given movie id
# movie <- function(id) {
#   paste0("https://api.themoviedb.org/3/movie/",id,"/credits?api_key=",api_key)
# }
# 
# # create pool
# pool <- new_pool()
# 
# # request storage
# data <- list()
# 
# # callback
# cb   <- function(req){ data <<- c(data, list(req)) }
# 
# # create uris
# uris <- popular_movies$id[1:100] %>% sapply(movie)
# 
# # scheduled requests
# x <- uris  %>% sapply(curl_fetch_multi, done=cb, pool=pool)
# 
# # perform requests
# out  <- multi_run(pool = pool)
# 
# # extract data
# L    <- lapply(data, function(req){req$content %>% rawToChar %>% fromJSON( flatten = TRUE)})
# 
# ## extract casts
# casts <- NULL
# 
# for( i in 1:length(L)){
#   movie       <- L[[i]]
#   df          <- movie$cast
#   df$movie_id <- movie$id
#   casts       <- rbind(casts, df)
# }
# 
# cast_popular <- casts %>% distinct(id, .keep_all = TRUE) %>% slice_max(popularity, n = 500)
# 
# cat(toJSON(cast_popular$profile_path), file = "data/popular.json")

# TMDB data
imdb_movies     <- read_csv("data/IMDb movies.csv")
imdb_names      <- read_csv("data/IMDb names.csv")
imdb_ratings    <- read_csv("data/IMDb ratings.csv")
imdb_principals <- read_csv("data/IMDb title_principals.csv")

save(imdb_movies, file = "data/imdb_movies.RData")
save(imdb_names, file = "data/imdb_names.RData")
save(imdb_ratings, file = "data/imdb_ratings.RData")
save(imdb_principals, file = "data/imdb_principals.RData")


#
library(tidytext)

movies               <- imdb_movies$original_title %>% unique %>% sort
directors            <- imdb_movies$director %>% unique %>% sort
writers              <- imdb_movies$writer %>% unique %>% sort
genres               <- imdb_movies$genre %>% unique %>% sort
production_companies <- imdb_movies$production_company %>% unique %>% sort

# clean up genres
genres <- str_split(imdb_movies$genre, " ") %>% unlist %>% tolower %>% gsub(", ", "", .)


tt <- table(genres,useNA = "no")
tt <- tt[order(tt,decreasing = TRUE)]

countries <- str_split(imdb_movies$country, ", ") %>% unlist %>% tolower %>% gsub(", ", "", .)

count(data.frame(countries), countries, sort = TRUE)

# topics
data("stop_words")

# topics
topics <- imdb_movies %>%
  select(description) %>%
  unnest_tokens(output = word, input = description) %>%
  anti_join(stop_words) %>%
  group_by(word) %>%
  tally() %>%
  arrange(desc(n)) %>%
  head(5000)


# movie_videos(api_key = api_key, id = 578, language = "en", append_to_response = "credits")
# movie_similar(api_key = api_key, id = 578, language = "de", append_to_response = "credits")
# movie_reviews(api_key, id = 578, page = 2, language = "en", append_to_response = "credits")
# movie_images(api_key = api_key, id = 550, language = "en")
# movie_keywords(api_key, id = 550)
# person_combined_credits(api_key = api_key, id = 287)
# person_external_ids(api_key = api_key, id = 287)
# person_images(api_key = api_key, id = 287)
# person_latest(api_key = api_key)
# person_movie_credits(api_key = api_key, id = 287)

# # movies by genre
# x1 <- keyword_movies(api_key, 1721, page = 1, language = "en")
# 
# # now playing
# x5 <- movie_now_playing(api_key, page = 1, language = "en")
# 
# movie_releases(api_key = api_key, id = 578, append_to_response = "credits")
#
# movie_top_rated(api_key = api_key, page = 1, language = "en")
# 
# movie_upcoming(api_key, page = 1, language = "en")
# 
# search_movie(api_key = api_key, query = "star wars")
# 
# person_popular(api_key, page = 1)
# 
# person_tagged_images(api_key = api_key, id = 287)
# 
# person_tmdb(api_key = api_key, id = 287, append_to_response = "latest")
# 
# search_keyword(api_key = api_key, query = "furious")
# 
# search_multi(api_key = api_key, query = "star wars")
# 
# search_person(api_key = api_key, query = "Megan Fox")
# 
# # breaking bad
# tv(api_key = api_key, id = 1396)
# 
# tv_episode(api_key = api_key, id = 1396, season_number = 4, episode_number = 4)
# 
# tv_episode_images(api_key = api_key, id = 1396, season_number = 1, episode_number = 1)
# 
# tv_episode_videos(api_key = api_key, id = 62161, season_number = 1, episode_number = 2)
# 
# tv_images(api_key = api_key, id = 1396)
# 
# tv_keywords(api_key = api_key, id = 1396)
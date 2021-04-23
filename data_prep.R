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
genres <- str_split(genres, " ") %>% unlist %>% tolower %>% gsub(",", "", .) %>% unique %>% sort

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
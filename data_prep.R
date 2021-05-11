# TMDB data
imdb_movies     <- read_csv("data/IMDb movies.csv")
imdb_names      <- read_csv("data/IMDb names.csv")
imdb_ratings    <- read_csv("data/IMDb ratings.csv")
imdb_principals <- read_csv("data/IMDb title_principals.csv")

save(imdb_movies, file = "data/imdb_movies.RData")
save(imdb_names, file = "data/imdb_names.RData")
save(imdb_ratings, file = "data/imdb_ratings.RData")
save(imdb_principals, file = "data/imdb_principals.RData")


# airports
airports        <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat", col_names = FALSE)
airports        <- airports[,c(2,3,4,5,7,8,9)]
names(airports) <- c("name", "city", "country", "IATA", "lat","lng","altitude")

save(airports, file = "data/airports.RData")


# http://files.tmdb.org/p/exports/movie_ids_05_01_2021.json.gz
# http://files.tmdb.org/p/exports/person_ids_05_01_2021.json.gz
# http://files.tmdb.org/p/exports/keyword_ids_05_01_2021.json.gz
# http://files.tmdb.org/p/exports/production_company_ids_05_01_2021.json.gz

# 41528 
keyword_ids <-  file("data/tmdb/files/keyword_ids_05_01_2021.json") %>% stream_in

# 603536
movie_ids   <-  file("data/tmdb/files/movie_ids_05_01_2021.json") %>% stream_in

# 2000797 
person_ids  <-  file("data/tmdb/files/person_ids_05_01_2021.json") %>% stream_in

person_ids  <- person_ids %>% arrange(desc(popularity )) %>% select(-one_of(adult))

# 119228
production_company_id <-  file("data/tmdb/files/production_company_ids_05_01_2021.json") %>% stream_in


x <- person_ids$name %>% tolower() 
person_ids[base::startsWith(x,"keanu"),]

persons  <- person_ids  %>% select(id:popularity) %>% arrange(desc(popularity )) %>% head(100000)
movies   <- movie_ids  %>% select(id:video) %>% arrange(desc(popularity )) %>% head(100000)

save(persons, file = "data/persons.RData")
save(movies , file = "data/movies.RData")

save(person_ids , file = "data/person_ids.RData")
save(movie_ids , file = "data/movie_ids.RData")

###
### smaller imdb movie list (with tmdb ids)
###

title_imdb <- imdb_movies$original_title %>% tolower()
title_tmdb <- movie_ids$original_title %>% tolower()


ii <- intersect(title_imdb , title_tmdb)

m1 <- match(ii, title_imdb)
m2 <- match(ii, title_tmdb)

imdb_movies <- imdb_movies[m1,]
imdb_movies$movie_id_tmdb <- movie_ids$id[m2]

save(imdb_movies , file = "data/imdb_movies_tmdb.RData")

person_ids[base::startsWith(x,"keanu"),]
quantile(person_ids$popularity, probs = c(0.999))
table(person_ids$popularity > 0.6)

###
### oscar data 
###
 
# oscar winners wiki
library(rvest)
html        <- read_html("https://en.wikipedia.org/wiki/List_of_actors_with_Academy_Award_nominations")

oscars_wiki <- html %>% html_element("table.sortable") %>% html_table()

# data downloaded from www.kaggle.com
# see https://www.kaggle.com/unanimad/the-oscar-award
# see https://www.kaggle.com/fmejia21/demographics-of-academy-awards-oscars-winners
oscar_demographics_kaggle <- read_csv("data/Oscars-demographics-DFE.csv")
oscars_kaggle             <- read_csv("data/the_oscar_award.csv")

# winners 
tmdb_oscar_winners <- TMDb::list_get(api_key, 28)
tmdb_oscar_winners <- tmdb_oscar_winners$items

save(tmdb_oscar_winners, file = "tmdb_oscar_winners.RData")

# save results
save(oscars_wiki, file = "data/oscars_wiki.RData")
save(oscar_demographics_kaggle, file = "data/oscars_demographics_kaggle")
save(oscars_kaggle, file = "data/oscars_kaggle.RData")

###
### add tmdb actor and movie to kaggle set
###

# %>% tolower() %>% str_replace_all("[^[:alnum:]]", "") %>%  str_replace_all("[[:punct:]]", "") %>% str_trim("both") %>% gsub(pattern = " ", "", .)
oscars_kaggle <- oscars_kaggle %>% drop_na(film)

df                     <- data.frame(oscars_kaggle, tmdb_movie_id = NA, tmdb_original_title = NA, tmdb_actor_id = NA, tmdb_actor_name = NA)

m1                     <- match(oscars_kaggle$film,movie_ids$original_title)
df$tmdb_movie_id       <- movie_ids$id[m1] 
df$tmdb_original_title <- movie_ids$original_title[m1] 

m2                     <- match(oscars_kaggle$name,person_ids$name)
df$tmdb_actor_id       <- person_ids$id[m2] 
df$tmdb_actor_name     <- person_ids$name[m2] 

kaggle_oscars_tmdb     <- df

save(kaggle_oscars_tmdb, file = "data/kaggle_oscars_tmdb.RData")

# see also
# https://rpubs.com/jssandom/oscar-winners-and-imdb
# 
# https://medium.com/swlh/analyzing-oscar-winners-and-nominees-with-plotly-interactive-visualizations-9488f508f026
# 
# https://venngage.com/blog/oscar-racism-interactive-infographic/
#   
# https://www.kaggle.com/unanimad/the-oscar-award
# 
# https://www.kaggle.com/fmejia21/demographics-of-academy-awards-oscars-winners
# 
# https://en.wikipedia.org/wiki/List_of_actors_with_Academy_Award_nominations
# 
# https://www.oscars.org/oscars/awards-databases-0
# 
# http://awardsdatabase.oscars.org/
  
###
###
###

# paste0("http://api.themoviedb.org/3/movie/",id,"/watch/providers?api_key=",api_key)

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

# person_combined_credits(api_key = api_key, id = 287)
# person_images(api_key = api_key, id = 287)
# person_external_ids(api_key = api_key, id = 287)

# paste0("http://api.themoviedb.org/3/movie/",id,"/watch/providers?api_key=",api_key)

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
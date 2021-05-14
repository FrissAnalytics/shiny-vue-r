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


# oscar data 
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


# add tmdb actor and movie to kaggle set
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

# see al
# https://www.kaggle.com/unanimad/the-oscar-award
# https://www.kaggle.com/fmejia21/demographics-of-academy-awards-oscars-winners
# https://en.wikipedia.org/wiki/List_of_actors_with_Academy_Award_nominations


# country ids in each set
ids <- am_data$world_timeline$list[[1]]$id

for(i in 2:length(am_data$world_timeline$date)){
  new_ids <- am_data$world_timeline$list[[i]]$id
  ids     <- ids %>% intersect(new_ids)
}

column_names          <- c("date", "confirmed", "deaths", "recovered", "id")
df_covid_world        <- data.frame(id = rep(ids, nr_dates), confirmed = NA, deaths = NA, recovered = NA)

for(i in 1:nr_dates){
  end   <- i * nr_countries
  start <- end - nr_countries + 1

  df <- am_data$world_timeline$list[[i]] %>% filter(id %in% ids )
  m  <- match(ids, df$id)

  df_covid_world[start:end,c("confirmed", "deaths", "recovered", "id")] <- df[m,c("confirmed", "deaths", "recovered", "id")]
  df_covid_world[start:end,"date"] <- am_data$world_timeline$date[[i]]
}

save(df_covid_world, ids, file = "data/df_covid_world.RData")




# lagged
 df_covid_world <- df_covid_world %>%
   group_by(id) %>%
   arrange(date) %>%
   mutate(delta_confirmed = confirmed - lag(confirmed)) %>%
   mutate(delta_deaths = deaths - lag(deaths)) %>%
   mutate(delta_recovered = recovered - lag(recovered)) %>%  drop_na()

df_covid_world$date <- df_covid_world$date %>% lubridate::ymd()


library(rgeos)
library(rworldmap)

wmap <- getMap(resolution="high")
centroids <- gCentroid(wmap, byid=TRUE)
df <- as.data.frame(centroids)
df$country <- rownames(df)

library(countrycode)
df_countries        <- codelist[,c("country.name.en","iso2c","continent")]
names(df_countries) <- c("country", "id","continent" )
df_countries        <- df_countries %>% filter(id %in% ids) %>% filter(country %in% rownames(df))
df_countries        <- left_join(df_countries, df, by = "country")
save(df_countries, file = "data/df_countries.RData")

am_countries <- fromJSON("https://raw.githubusercontent.com/amcharts/amcharts4/master/dist/geodata/es2015/json/data/countries2.json")
df_countries <- data.frame(country = NA, id = names(am), continent = NA)

for(i in 1:length(am_countries)){
  df_countries$country[i]   <- am_countries[[i]]$country
  df_countries$continent[i] <- am_countries[[i]]$continent
}
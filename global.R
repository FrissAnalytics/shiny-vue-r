library(shiny)
library(jsonlite)
library(tidyverse)
library(magrittr)
library(plotly)
library(TMDb)
library(curl)
library(leaflet)
library(htmltools)

source("helpers.R")
source("modules/plotServer.R")

# kaggle imdb movies set
load("data/imdb_movies_tmdb.RData")

# kaggle oscar winners 
load("data/oscars_kaggle.RData")

# kaggle oscar winners demographics
load("data/oscars_demographics_kaggle")

# oscar winners pulled from wikipedia
load("data/oscars_wiki.RData")

# movie ids pulled from the movie database on may 1st
load("data/movie_ids.RData")

# person ids pulled from the movie database on may 1st
load("data/person_ids.RData")

# airport locations
load("data/airports.RData")

# The Movie DataBase 
api_key    <- "1832c46bf5ad73f96183eaddb5f8ab88"

# john hopkins daily data 
hopkins    <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-05-2021.csv")

hopkins    <- hopkins %>% drop_na(Lat, Long_)

# choropleth country data
countries  <- fromJSON("data/ne_110m_admin_0_countries.json")

# amcharts data
urls       <- c("https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/total_timeline.json",
                "https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/total.json",
                "https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/world_timeline.json")

keys       <- c("total_timeline", "total", "world_timeline")

am_data    <- get_urls(urls, keys)

# create tall df holding covid counts for all countries and dates
# we will reshape this df on demand using dplyr
# nr_dates <- am_data$world_timeline$date %>% length
# 
# country ids in each set
# ids <- am_data$world_timeline$list[[1]]$id
# 
# for(i in 2:length(am_data$world_timeline$date)){
#   new_ids <- am_data$world_timeline$list[[i]]$id
#   ids     <- ids %>% intersect(new_ids)
# }

# column_names          <- c("date", "confirmed", "deaths", "recovered", "id")
# df_covid_world        <- data.frame(id = rep(ids, nr_dates), confirmed = NA, deaths = NA, recovered = NA)
# 
# for(i in 1:nr_dates){
#   end   <- i * nr_countries
#   start <- end - nr_countries + 1
# 
#   df <- am_data$world_timeline$list[[i]] %>% filter(id %in% ids ) 
#   m  <- match(ids, df$id)
# 
#   df_covid_world[start:end,c("confirmed", "deaths", "recovered", "id")] <- df[m,c("confirmed", "deaths", "recovered", "id")]
#   df_covid_world[start:end,"date"] <- am_data$world_timeline$date[[i]]
# }
# 
#save(df_covid_world, ids, file = "data/df_covid_world.RData")
load("data/df_covid_world.RData")

# lagged
# df_covid_world <- df_covid_world %>% 
#   group_by(id) %>% 
#   arrange(date) %>% 
#   mutate(delta_confirmed = confirmed - lag(confirmed)) %>% 
#   mutate(delta_deaths = deaths - lag(deaths)) %>% 
#   mutate(delta_recovered = recovered - lag(recovered)) %>%  drop_na()
# 
# df_covid_world$date <- df_covid_world$date %>% lubridate::ymd()
#   

# https://raw.githubusercontent.com/amcharts/amcharts4/master/dist/geodata/es2015/json/data/countries2.json


# library(rgeos)
# library(rworldmap)
# 
# # get world map
# wmap <- getMap(resolution="high")
# 
# # get centroids
# centroids <- gCentroid(wmap, byid=TRUE)
# 
# # get a data.frame with centroids
# df <- as.data.frame(centroids)
# 
# df$country <- rownames(df)
# 
# library(countrycode)
# 
# df_countries        <- codelist[,c("country.name.en","iso2c","continent")]
# 
# names(df_countries) <- c("country", "id","continent" )
# 
# df_countries        <- df_countries %>% filter(id %in% ids) %>% filter(country %in% rownames(df))
# 
# df_countries        <- left_join(df_countries, df, by = "country")
# 
# save(df_countries, file = "data/df_countries.RData")

# am_countries <- fromJSON("https://raw.githubusercontent.com/amcharts/amcharts4/master/dist/geodata/es2015/json/data/countries2.json")
# 
# df_countries <- data.frame(country = NA, id = names(am), continent = NA)
# 
# 
# for(i in 1:length(am_countries)){
#   df_countries$country[i]   <- am_countries[[i]]$country
#   df_countries$continent[i] <- am_countries[[i]]$continent
# }

load("data/df_countries.RData")

storylines <- fromJSON("data/timeline.json")

###
### 
###

top10      <- imdb_movies %>% drop_na(production_company) %>% count(production_company) %>% top_n(10)

# popular movies
df_popular <- popular_urls(15) %>% get_urls_async %>% arrange(desc(popularity))

# combine oscars with tmdb ids
load("tmdb_oscar_winners.RData")

load("data/kaggle_oscars_tmdb.RData")



# "Big Five" Best Picture, Best Director, Best Actor, Best Actress, and Best Screenplay (Best Original Screenplay or Best Adapted Screenplay)
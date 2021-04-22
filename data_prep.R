# TMDB data
imdb_movies     <- read_csv("data/IMDb movies.csv")
imdb_names      <- read_csv("data/IMDb names.csv")
imdb_ratings    <- read_csv("data/IMDb ratings.csv")
imdb_principals <- read_csv("data/IMDb title_principals.csv")

save(imdb_movies, file = "data/imdb_movies.RData")
save(imdb_names, file = "data/imdb_names.RData")
save(imdb_ratings, file = "data/imdb_ratings.RData")
save(imdb_principals, file = "data/imdb_principals.RData")
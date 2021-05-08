popular_urls <- function(n){
  sapply(1:n, function(k){
    paste0("http://api.themoviedb.org/3/movie/popular?api_key=1832c46bf5ad73f96183eaddb5f8ab88&page=",k,"&language=en")
  })
}

get_urls_async <- function(urls){
  
  # create pool
  pool <- new_pool()
  
  # storage
  data <- list()
  
  # callback
  cb   <- function(req){ data <<- c(data, list(req)) }
  
  # scheduled requests
  x <- urls  %>% sapply(curl_fetch_multi, done=cb, pool=pool)
  
  # perform requests
  out  <- multi_run(pool = pool)
  
  # extract data
  L    <- lapply(data, function(req){req$content %>% rawToChar %>% fromJSON( flatten = TRUE)})
  
  # merge into single data frame
  df <- NULL
  
  for(l in 1:length(L)){
    df <- rbind(df, L[[l]]$results)
  }
  
  # remove rows with missing values
  df %>% drop_na()
  
}


get_urls_async2 <- function(urls){
  
  # create pool
  pool <- new_pool()
  
  # storage
  data <- list()
  
  # callback
  cb   <- function(req){ data <<- c(data, list(req)) }
  
  # scheduled requests
  x <- urls  %>% sapply(curl_fetch_multi, done=cb, pool=pool)
  
  # perform requests
  out  <- multi_run(pool = pool)
  
  # store results + url
  L    <- list(results = lapply(data, function(req){req$content %>% rawToChar %>% fromJSON( flatten = TRUE)}), 
               urls = sapply(data, function(req){req$url}))
}

get_movie_details <- function(id){
  
  urls <- c(
    paste0("http://api.themoviedb.org/3/movie/", id, "/credits?api_key=", api_key),
    paste0("http://api.themoviedb.org/3/movie/", id, "/videos?api_key=", api_key),       
    paste0("http://api.themoviedb.org/3/movie/", id, "/images?api_key=", api_key))
  
  type <- c("credits","videos","images")
  
  # make requests
  L <- get_urls_async2(urls)

  # get results  
  results <- L$results
  
  # make sure results are in known order
  m <- match(L$urls, urls)

  # add name for easy reference
  names(results) <- type[m]
  
  return(results)
  
}

get_urls <- function(urls, keys){
  L              <- get_urls_async2(urls)
  results        <- L$results
  names(results) <- keys[match(L$urls, urls)]
  
  return(results)
}


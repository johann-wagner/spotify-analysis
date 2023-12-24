### ############################################################################
### ############################################################################
###                                                                          ###
### SPOTIFY ANALYSIS - Data Loading                                          ###
###                                                                          ###
### ############################################################################
### ############################################################################






# Setup and Configuration ------------------------------------------------------

source(
  "0-00_setup_and_configuration.R",
  echo = TRUE,
  max.deparse.length = 1e4
)

# Only download raw data if it hasn't already been downloaded
if(!dir.exists(here("raw_data"))) {
  dir.create(here("raw_data"), showWarnings = FALSE)
  
  
  
  
  
  # Data Loading -----------------------------------------------------------------
  
  # List contents of Spotify Analysis Folder
  # Only have access if Johann has given you read access to the email you 
  # authorised in 0-00_setup_and_configuration.R
  spotify_dribble <- drive_ls("Spotify Analysis")
  
  # Download raw data
  map2(
    spotify_dribble$id,
    spotify_dribble$name,
    ~ drive_download(
      file = as_id(.x),
      path = here("raw_data", .y),
      overwrite = TRUE
    )
  )
}



# Read in individual raw json as nested lists
# JRAW = RAW JSON
# RAW_JSON causes alphabetical ordering inconveniences in R environment.
JRAW_FOLLOW <- read_json(
  path = here(
    "raw_data",
    "Follow.json"
  )
)

JRAW_IDENTIFIERS <- read_json(
  path = here(
    "raw_data",
    "Identifiers.json"
  )
)

JRAW_IDENTITY <- read_json(
  path = here(
    "raw_data",
    "Identity.json"
  )
)

JRAW_INFERENCES <- read_json(
  path = here(
    "raw_data",
    "Inferences.json"
  )
)

JRAW_MARQUEE <- read_json(
  path = here(
    "raw_data",
    "Inferences.json"
  )
)

JRAW_PAYMENT <- read_json(
  path = here(
    "raw_data",
    "Payments.json"
  )
)

JRAW_PLAYLIST <- read_json(
  path = here(
    "raw_data",
    "Playlist1.json"
  )
)

JRAW_STREAMING_HISTORY_0 <- read_json(
  path = here(
    "raw_data",
    "StreamingHistory0.json"
  )
)

JRAW_STREAMING_HISTORY_1 <- read_json(
  path = here(
    "raw_data",
    "StreamingHistory1.json"
  )
)

JRAW_STREAMING_HISTORY_2 <- read_json(
  path = here(
    "raw_data",
    "StreamingHistory2.json"
  )
)

JRAW_USER_DATA <- read_json(
  path = here(
    "raw_data",
    "Userdata.json"
  )
)

JRAW_YOUR_LIBRARY <- read_json(
  path = here(
    "raw_data",
    "YourLibrary.json"
  )
)

# Data Tidying ----------------------------------------------------------------

# Nested lists into tidy tibbles
RAW_FOLLOW <- JRAW_FOLLOW %>% 
  as_tibble()

RAW_IDENTIFIERS <- JRAW_IDENTIFIERS %>% 
  as_tibble()

RAW_IDENTITY <- JRAW_IDENTITY %>% 
  as_tibble()

RAW_INFERENCES <- JRAW_INFERENCES %>% 
  as_tibble()

RAW_PAYMENT <- JRAW_PAYMENT %>% 
  as_tibble()

RAW_PLAYLIST <- JRAW_PLAYLIST %>%
  bind_rows() %>%
  unnest_wider(items) %>%
  unnest_wider(track)
  
  
  
RAW_STREAMING_HISTORY_0 <- JRAW_STREAMING_HISTORY_0 %>% 
  bind_rows() %>% 
  as_tibble()

RAW_STREAMING_HISTORY_1 <- JRAW_STREAMING_HISTORY_1 %>% 
  bind_rows() |> 
  as_tibble()

RAW_STREAMING_HISTORY_2 <- JRAW_STREAMING_HISTORY_2 %>% 
  bind_rows() |> 
  as_tibble()

RAW_USER_DATA <- JRAW_USER_DATA %>% 
  bind_rows() |> 
  as_tibble()


RAW_YOUR_LIBRARY_TRACKS <- JRAW_YOUR_LIBRARY[["tracks"]] %>% 
  bind_rows() |> 
  as_tibble()

RAW_YOUR_LIBRARY_ALBUMS <- JRAW_YOUR_LIBRARY[["albums"]] %>% 
  bind_rows() |> 
  as_tibble()

RAW_YOUR_LIBRARY_SHOWS <- JRAW_YOUR_LIBRARY[["shows"]] %>% 
  bind_rows() |> 
  as_tibble()

RAW_YOUR_LIBRARY_EPISODES <- JRAW_YOUR_LIBRARY[["episodes"]] %>% 
  bind_rows() |> 
  as_tibble()

RAW_YOUR_LIBRARY_ARTISTS <- JRAW_YOUR_LIBRARY[["artists"]] %>% 
  bind_rows() |> 
  as_tibble()

# Data Wrangling ---------------------------------------------------------------





# Data Analysis ----------------------------------------------------------------

# gapminder %>% map_chr(class)
# gapminder %>% map_dbl(n_distinct)


# Data Visualisation -----------------------------------------------------------






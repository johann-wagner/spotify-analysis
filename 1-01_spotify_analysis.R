### ############################################################################
### ############################################################################
###                                                                          ###
### SPOTIFY ANALYSIS                                                         ###
###                                                                          ###
### ############################################################################
### ############################################################################






# Setup and Configuration ------------------------------------------------------

source(
  "0-00_setup_and_configuration.R",
  echo = TRUE,
  max.deparse.length = 1e4
)





# Data Loading -----------------------------------------------------------------

# List contents of Spotify Analysis Folder
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

# Read in raw json files using map(); issue with code
# DATA <- here("raw_data") %>% 
#   dir(
#     pattern = "*json"
#   ) %>% 
#   map(
#     ~ read_json,
#     here("raw_data", .x)
#     )

# Read in individual raw json as nested lists
# JRAW = RAW JSON
# RAW_JSON causes alphabetical ordering inconveniences in R environment.
JRAW_FOLLOW <- read_json(
  path = here(
    "raw_data",
    "Follow.json"
    ),
  simplifyVector = TRUE,
  flatten = TRUE
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


# Data Wrangling ---------------------------------------------------------------





# Data Analysis ----------------------------------------------------------------

# gapminder %>% map_chr(class)
# gapminder %>% map_dbl(n_distinct)


# Data Visualisation -----------------------------------------------------------






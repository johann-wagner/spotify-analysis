### ############################################################################
### ############################################################################
###                                                                          ###
### SPOTIFY ANALYSIS - Extended Spotify Streaming History                    ###
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
raw_data_filepath <- here("raw_data", "extended_streaming_history")

# Only download raw data if it hasn't already been downloaded
if(!dir.exists(here("raw_data", "extended_streaming_history"))) {
  dir.create(here("raw_data", "extended_streaming_history"), showWarnings = FALSE)
  
  # List contents of Spotify Analysis Folder
  # Only have access if Johann has given you read access to the email you 
  # authorised in 0-00_setup_and_configuration.R
  spotify_dribble <- drive_ls("Spotify Analysis/Spotify Extended Streaming History")
  
  # Download raw data
  map2(
    spotify_dribble$id,
    spotify_dribble$name,
    ~ drive_download(
      file = as_id(.x),
      path = glue(raw_data_filepath, "/", .y),
      overwrite = TRUE
    )
  )
}


# Read in individual raw json as nested lists
# JRAW = RAW JSON
# RAW_JSON causes alphabetical ordering inconveniences in R environment.
# Get all files with .json extension
json_files <- list.files(
  path = raw_data_filepath,
  pattern = "Streaming_History_Audio_*"
  )

# Read each file using map and store them in a list
extended_streaming_history_list <- json_files |> 
  map(~ read_json(glue(raw_data_filepath, "/", .x)))

# Bind all data frames into a single tibble
extended_streaming_history <- extended_streaming_history_list |> 
  bind_rows()





# Exploratory Data Analysis -----------------------------------------------

# Summary of the data
skim(extended_streaming_history)

# Missing Values
extended_streaming_history |> 
  filter(
    is.na(master_metadata_track_name),
    is.na(spotify_episode_uri)
  ) |> 
  skim()

# Convert ms to minutes
extended_streaming_history_wrangled <- extended_streaming_history |> 
  mutate(
    # Convert ms to minutes
    min_played = as.numeric(ms_played / 60000),
    
    # Convert endTime into lubridate datetime
    end_date_time = str_sub(ts, end = 10) |> 
      as_date(format = "%Y-%m-%d"),
    
    # Convert artistName to factor
    track_name = as.factor(master_metadata_track_name),
    
    # Convert artist name to factor
    artist_name = as.factor(master_metadata_album_artist_name),
    
    # Convert artistName to factor
    album_name = as.character(master_metadata_album_album_name)
  )

extended_streaming_history_music <- extended_streaming_history_wrangled |> 
  filter(!is.na(artist_name))

# Top 10 Songs
extended_streaming_history_music |> 
  group_by(track_name) |> 
  summarise(
    total_play_time = sum(min_played)
  ) |> 
  arrange(desc(total_play_time))

# Top 10 Artists
extended_streaming_history_music |> 
  group_by(artist_name) |> 
  summarise(
    total_play_time = sum(min_played)
  ) |> 
  arrange(desc(total_play_time))

# Top 10 Albums
extended_streaming_history_music |> 
  group_by(album_name) |> 
  summarise(
    total_play_time = sum(min_played)
  ) |> 
  arrange(desc(total_play_time))

# Listening across time
extended_streaming_history_time_series <- extended_streaming_history_music |> 
  group_by(end_date_time) |> 
  summarise(
    total_play_time = sum(min_played)
  ) |> 
  complete(end_date_time = seq.Date(min(end_date_time), max(end_date_time), by = "day")) |> 
  replace_na(list(total_play_time = 0))

extended_streaming_history_time_series |>
  ggplot(aes(x = end_date_time, y = total_play_time)) +
  geom_line() +
  geom_smooth() +
  labs(
    title = "Listening across time",
    x = "Date",
    y = "Total Play Time (minutes)"
  )

ts(extended_streaming_history_time_series$total_play_time/60, frequency = 365) |> 
  stlf() |> 
  plot()


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

# Only download raw data if it hasn't already been downloaded
if(!dir.exists(here("raw_data", "extended_streaming_history"))) {
  dir.create(here("raw_data", "extended_streaming_history"), showWarnings = FALSE)

  
  
  
  
  
  # Data Loading -----------------------------------------------------------------
  
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
      path = here(
        "raw_data", "extended_streaming_history", .y),
      overwrite = TRUE
    )
  )
}

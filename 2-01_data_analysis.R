### ############################################################################
### ############################################################################
###                                                                          ###
### SPOTIFY ANALYSIS - Data Analysis                                         ###
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
source(
  "1-01_data_loading.R",
  echo = TRUE,
  max.deparse.length = 1e4
)





# Data Analysis -----------------------------------------------------------
# Combine all streaming history tibbles into one tibble
RAW_STREAMING_HISTORY <- bind_rows(
  RAW_STREAMING_HISTORY_0,
  RAW_STREAMING_HISTORY_1,
  RAW_STREAMING_HISTORY_2
)

RAW_STREAMING_HISTORY |> 
  skim()

CLEANED_STREAMING_HISTORY <- RAW_STREAMING_HISTORY |> 
  mutate(
    # Convert ms to minutes
    min_played = as.numeric(msPlayed / 60000),
    
    # Convert artistName to factor
    artist_name = as.factor(artistName),
    
    # Convert endTime into lubridate datetime
    end_date_time = as_date(endTime, format = "%Y-%m-%d %H:%M")
  )


CLEANED_STREAMING_HISTORY |> 
  skim(end_date_time)



STREAMING_HISTORY_PER_DAY <- CLEANED_STREAMING_HISTORY |> 
  group_by(end_date_time) |>
  summarise(
    total_hours_played = sum(min_played / 60)
  )



# What were the top 5 days I listened to music?
# What days of the week were these dates?
STREAMING_HISTORY_PER_DAY |> 
  mutate(
    day_of_week = wday(end_date_time, label = TRUE)
  ) |> 
  arrange(desc(total_hours_played)) |> 
  head(5)

# Minutes played per day
STREAMING_HISTORY_PER_DAY |> 
  ggplot(aes(x = end_date_time, y = total_hours_played)) +
  
  geom_point(
    aes(colour = ifelse(
      total_hours_played > 12,
      "red",
      "lightgrey"),
      )
    ) +
  geom_line(colour = "darkgrey") +
  geom_smooth() +
  
  geom_label(
    label = "Flying to Australia",
    x = as.Date("2023-05-30"),
    y = STREAMING_HISTORY_PER_DAY |> 
      filter(end_date_time == as.Date("2023-05-30")) |> 
      pull(total_hours_played),
    vjust = -0.5
  ) +
  geom_label(
    label = "Flying to Austria",
    x = as.Date("2023-02-18"),
    y = STREAMING_HISTORY_PER_DAY |> 
      filter(end_date_time == as.Date("2023-02-18")) |> 
      pull(total_hours_played),
    vjust = -0.5
  ) +
  
  scale_color_identity() +
  
  expand_limits(
    y = c(0, 20)
  ) +
  
  labs(
    x = "",
    y = "Hours Played",
    title = "Hours Played Per Day",
    subtitle = "Spotify Streaming History"
  ) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(
      size = 20,
      face = "bold"
    ),
    plot.subtitle = element_text(
      size = 15
    ),
    axis.title = element_text(
      size = 15
    ),
    axis.text = element_text(
      size = 10
    )
  )

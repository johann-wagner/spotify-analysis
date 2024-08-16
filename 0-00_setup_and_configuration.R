### ############################################################################
### ############################################################################
###                                                                          ###
### SETUP AND CONGFIGURATION                                                 ###
###                                                                          ###
### ############################################################################
### ############################################################################





# Packages ---------------------------------------------------------------------

### "Tidyverse"-oriented packages:

# The tidyverse is a collection of R packages designed for data science.
# All packages share a similar design philosophy, grammar, and data structures.
# Tidyverse includes packages such as:
# ggplot2, dplyr, tidyr, readr, purr, tibble, stringr, lubriate, and forcats.
### https://www.tidyverse.org/
library(tidyverse)

### Data Exploration ---------------------------------------------------------
# To easily display summary statistics
### https://github.com/ropensci/skimr
library(skimr)

### Data Cleaning/Wrangling --------------------------------------------------
# To easily examine and clean dirty data
### https://www.rdocumentation.org/packages/janitor/versions/2.2.0
library(janitor)

# To easily use date-time data
### https://lubridate.tidyverse.org/
library(lubridate)

# To easily handle categorical variables using factors.
### https://forcats.tidyverse.org/
library(forcats)

# To easily interprete strings that are small, fast, and dependency-free
### https://glue.tidyverse.org/
library(glue)

# To interpolate ("glue") data into strings.
# Compared to paste() and sprintf()
# Easier to write and less time consuming to maintain.
### https://glue.tidyverse.org/reference/index.html
library(glue)

# To allow interaction between files on Google Drive and R
library(googledrive)

library(ggplot2)
library(skimr)
library(lubridate)
#library(geomrepel)
library(ggthemes)
### Other packages:

# To enable easy file referencing in project-oriented workflows
# In contrast to using setwd()
### https://here.r-lib.org/
library(here)

# A fast JSON parser and generator
### https://cran.r-project.org/web/packages/jsonlite/index.html
library(jsonlite)





# Google Drive Authentication --------------------------------------------------

# To establish a connection between a Google Drive account and R
drive_auth()

# Example of how to download from Google Drive
# drive_download(
#   # Where to download file from
#   "https://drive.google.com/file/d/1Fjq1r6016H4isB2Cx2wg-Xm9zY7lHhYV/view?usp=drive_link",
# 
#   # Where to save it locally
#   path = here("foldertest", "text2")
#   )

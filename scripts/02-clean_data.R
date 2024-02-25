#### Preamble ####
# Purpose: Clean the Australian Prime Minister data set from Wikipedia. 
# Author: Hari Lee Robledo
# Date: 24 February 2024
# Email: hari.leerobledo@mail.utoronto.ca
# Pre-requisites: none

### Work Space Setup ###

library(babynames)
library(here)
library(httr)
library(rvest)
library(tidyverse)
library(janitor)
library(knitr)
library(lubridate)
library(purrr)
library(xml2)

# Code is referenced from: https://tellingstorieswithdata.com/07-gather.html#prime-ministers-of-the-united-kingdom

#CLEAN DATA
initial_clean <-
  parsed_data |>
  separate(
    raw_text, into = c("name", "not_name"), sep = "\\(", extra = "merge",
  ) |> 
  
  mutate(date = str_extract(not_name, "[[:digit:]]{4}–[[:digit:]]{4}"),
         born = str_extract(not_name, "[[:space:]][[:digit:]]{4}")
         ) |>
  select(name, date, born)
  

aus_cleaned_data <-
  initial_clean |>
  separate(date, into = c("birth", "died"), 
           sep = "–") |>
  mutate(
    born = str_remove_all(born, "born[[:space:]]"),
    birth = if_else(!is.na(born), born, birth)
  ) |> # Alive PMs have slightly different format
  select(-born) |>
  rename(born = birth) |> 
  mutate(across(c(born, died), as.integer)) |> 
  mutate(Age_at_Death = died - born) |> 
  distinct() # Some of the PMs had two goes at it.
```

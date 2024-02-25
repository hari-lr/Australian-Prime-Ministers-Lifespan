#### Preamble ####
# Purpose: Simulate the Australian Prime Minister data set from Wikipedia. 
# Author: Hari Lee Robledo
# Date: 24 February 2024
# Email: hari.leerobledo@mail.utoronto.ca
# Pre-requisites: none


#| message: false
#| echo: false
#| warning: false

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

#SIMULATE DATA
set.seed(853)

simulated_dataset <-
  tibble(
    prime_minister = babynames |>
      filter(prop > 0.01) |>
      distinct(name) |>
      unlist() |>
      sample(size = 10, replace = FALSE),
    birth_year = sample(1700:1990, size = 10, replace = TRUE),
    years_lived = sample(50:100, size = 10, replace = TRUE),
    death_year = birth_year + years_lived
  ) |>
  select(prime_minister, birth_year, death_year, years_lived) |>
  arrange(birth_year)

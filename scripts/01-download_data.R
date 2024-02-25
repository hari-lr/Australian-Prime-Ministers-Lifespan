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

#SCRAPE DATA
raw_data <-
  read_html(
    "https://en.wikipedia.org/wiki/List_of_prime_ministers_of_Australia"
  )
write_html(raw_data, "pms.html")

#READ DATA
raw_data <- read_html("pms.html")

#PARSE DATA
parse_data_selector_gadget <-
  raw_data |>
  html_element(".wikitable") |>
  html_table()

parsed_data <-
  parse_data_selector_gadget |> 
  clean_names() |> 
  rename(raw_text = `name_birth_death_constituency`) |> 
  select(raw_text) |> 
  filter(raw_text != "Name (Birth-Death) Constituency") |> 
  distinct() 

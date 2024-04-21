#### Preamble ####
# Purpose: Tests for cleaned data
# Author: Sarah Lee
# Date: 18 April 2024
# Contact: sarahhhh.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: cleaned data from the raw data


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(testthat)

cleaned_total <- read_parquet(here::here("data/analysis_data/cleaned_total.parquet"))
cleaned_sex <- read_parquet(here::here("data/analysis_data/cleaned_sex.parquet"))
cleaned_age <- read_parquet(here::here("data/analysis_data/cleaned_age.parquet"))
cleaned_sex_race <- read_parquet(here::here("data/analysis_data/cleaned_sex_race.parquet"))
cleaned_age_sex <- read_parquet(here::here("data/analysis_data/cleaned_age_sex.parquet"))
cleaned_sex_age_race <- read_parquet(here::here("data/analysis_data/cleaned_sex_age_race.parquet"))


#### Test data ####
#cleaned_total
is.character(cleaned_sex$UNIT)
is.numeric(cleaned_sex$YEAR)
is.numeric(cleaned_sex$ESTIMATE)

#cleaned_sex
is.character(cleaned_sex$UNIT)
is.numeric(cleaned_sex$YEAR)
is.character(cleaned_sex$SEX)
is.numeric(cleaned_sex$ESTIMATE)

#cleaned_age
# Check if variables are numeric or character
variable <- names(cleaned_age)
variable_types <- sapply(cleaned_age, class)

# Print the variable names and their types
for(i in 1:length(cleaned_age)) {
  cat("variable:", variable[i], "\t Type:", variable_types[i], "\n")
}

#cleaned_sex_race
# Check if variables are numeric or character
variable <- names(cleaned_sex_race)
variable_types <- sapply(cleaned_sex_race, class)

# Print the variable names and their types
for(i in 1:length(cleaned_sex_race)) {
  cat("variable:", variable[i], "\t Type:", variable_types[i], "\n")
}

#cleaned_age_sex
# Check if variables are numeric or character
variable <- names(cleaned_age_sex)
variable_types <- sapply(cleaned_age_sex, class)

# Print the variable names and their types
for(i in 1:length(cleaned_age_sex)) {
  cat("variable:", variable[i], "\t Type:", variable_types[i], "\n")
}

#cleaned_sex_age_race
# Check if variables are numeric or character
variable <- names(cleaned_sex_age_race)
variable_types <- sapply(cleaned_sex_age_race, class)

# Print the variable names and their types
for(i in 1:length(cleaned_sex_age_race)) {
  cat("variable:", variable[i], "\t Type:", variable_types[i], "\n")
}


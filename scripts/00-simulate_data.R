#### Preamble ####
# Purpose: Simulates... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(dplyr)
library(waffle)



#### Simulate data ####
# Set seed for reproducibility
set.seed(123)

# Create a data frame with Suicide Rates on Age, Sex and Race by Year of 1000 population
data <- data.frame(
  UNIT = rep("Deaths per 100,000 resident population, crude", 1000), # Assuming 1000 observations
  YEAR = sample(1950:2018, 1000, replace = TRUE), # Random years between 1950 and 2018
  SEX = sample(c("Male", "Female"), 1000, replace = TRUE), # Random sex
  RACE = sample(c("White", "Black or African American", "Asian or Pacific Islander", "American Indian or Alaska Native"), 1000, replace = TRUE), # Random race
  AGE = sample(c("10-14 years", "15-24 years", "20-24 years", "25-44 years","35-44 years", "45-64 years","55-64 years",
                 "65 years and over", "65-74 years", "75-84 years", "85 years and over"), 1000, replace = TRUE), # Random age group
  ESTIMATE = round(rnorm(1000, mean = 20, sd = 10), 1) # Random death rates with mean 20 and standard deviation 10 rounded to one decimal point
)

# See first few rows of data frame
head(data)




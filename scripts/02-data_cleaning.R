#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(dplyr)


#### Clean data ####
raw_data <- read_csv("data/raw_data/Death_rates_for_suicide__by_sex__race__Hispanic_origin__and_age__United_States_20240410.csv")

#Total suicide rate by sex
cleaned_sex <- raw_data %>%
  select(UNIT, STUB_NAME, STUB_LABEL, YEAR, AGE, ESTIMATE) %>%
  filter(STUB_LABEL %in% c("Male", "Female"))

#Total suicide rate by age range
cleaned_age <- raw_data %>%
  select(UNIT, STUB_NAME, STUB_LABEL, YEAR, AGE, ESTIMATE) %>%
  filter(STUB_LABEL %in% c("10-14 years", "15-24 years", "20-24 years", "25-44 years", "35-44 years",
                    "45-64 years", "55-64 years", "65 years and over", "65-74 years", "75-84 years", 
                    "85 years and over"))

#Total suicide rate by sex and race
cleaned_sex_race <- raw_data %>%
  select(UNIT, STUB_NAME, STUB_LABEL, YEAR, AGE, ESTIMATE) %>%
  filter(STUB_LABEL %in% c("Male: White", "Male: Black or African American", "Male: American Indian or Alaska Native",
                           "Male: Asian or Pacific Islander", "Female: White", "Female: Black or African American",
                           "Female: American Indian or Alaska Native", "Female: Asian or Pacific Islander"))
print(cleaned_sex_race)

#### Save data ####
write_csv(cleaned_sex, "data/analysis_data/cleaned_sex.csv")
write_csv(cleaned_age, "data/analysis_data/cleaned_age.csv")
write_csv(cleaned_sex_race, "data/analysis_data/cleaned_sex_race.csv")

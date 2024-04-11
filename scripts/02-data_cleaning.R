#### Preamble ####
# Purpose: Cleans the raw suicides data 
# Author: Sarah Lee
# Date: 10 April 2024
# Contact: sarahhhh.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Raw data on Suicide Rates


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)


#### Clean data ####
raw_data <- read_csv("data/raw_data/Death_rates_for_suicide__by_sex__race__Hispanic_origin__and_age__United_States_20240410.csv")

###Total suicide rate by sex###
cleaned_sex <- raw_data %>%
  select(UNIT, YEAR, STUB_LABEL, ESTIMATE) %>%
  filter(STUB_LABEL %in% c("Male", "Female")) %>%
  rename(SEX = STUB_LABEL)

write_parquet(cleaned_sex, "data/analysis_data/cleaned_sex.parquet")

###Total suicide rate by age range###
cleaned_age <- raw_data %>%
  select(UNIT, YEAR, STUB_LABEL, ESTIMATE) %>%
  filter(STUB_LABEL %in% c("10-14 years", "15-24 years", "20-24 years", "25-44 years", "35-44 years",
                    "45-64 years", "55-64 years", "65 years and over", "65-74 years", "75-84 years", 
                    "85 years and over")) %>%
  rename(AGE = STUB_LABEL) 

write_parquet(cleaned_age, "data/analysis_data/cleaned_age.parquet")

###Total suicide rate by sex and race###
cleaned_sex_race <- raw_data %>%
  select(UNIT, YEAR, STUB_LABEL, ESTIMATE) %>%
  filter(STUB_LABEL %in% c("Male: White", "Male: Black or African American", "Male: American Indian or Alaska Native",
                           "Male: Asian or Pacific Islander", "Female: White", "Female: Black or African American",
                           "Female: American Indian or Alaska Native", "Female: Asian or Pacific Islander")) %>%
  separate(STUB_LABEL, into = c("SEX", "RACE"), sep = ":\\s+", extra = "merge")  %>%
  filter(!is.na(ESTIMATE))

write_parquet(cleaned_sex_race, "data/analysis_data/cleaned_sex_race.parquet")

###Total suicide rate by sex, age, race###
cleaned_sex_age_race <- raw_data %>%
  select(UNIT,YEAR, STUB_LABEL, ESTIMATE) %>%
  filter(STUB_LABEL %in% c("Male: White: 15-24 years", "Male: White: 25-44 years", "Male: White: 45-64 years",
         "Male: White: 65 years and over", "Male: White: 75-84 years", "Male: White: 85 years and over", 
         "Male: Black or African American: 15-24 years", "Male: Black or African American: 25-44 years", 
         "Male: Black or African American: 45-64 years", "Male: Black or African American: 65 years and over", 
         "Male: Black or African American: 65-74 years", "Male: Black or African American: 75-84 years", 
         "Male: Black or African American: 85 years and over", "Male: American Indian or Alaska Native: 15-24 years", 
         "Male: American Indian or Alaska Native: 25-44 years", "Male: American Indian or Alaska Native: 45-64 years", 
         "Male: American Indian or Alaska Native: 65 years and over", "Male: Asian or Pacific Islander: 15-24 years", 
         "Male: Asian or Pacific Islander: 25-44 years", "Male: Asian or Pacific Islander: 45-64 years", 
         "Male: Asian or Pacific Islander: 65 years and over", "Female: White: 15-24 years", "Female: White: 25-44 years", 
         "Female: White: 45-64 years", "Female: White: 65 years and over", "Female: White: 75-84 years", 
         "Female: White: 85 years and over", "Female: Black or African American: 15-24 years", 
         "Female: Black or African American: 25-44 years", "Female: Black or African American: 45-64 years", 
         "Female: Black or African American: 65 years and over", "Female: Black or African American: 65-74 years", 
         "Female: Black or African American: 75-84 years", "Female: Black or African American: 85 years and over", 
         "Female: American Indian or Alaska Native: 15-24 years", "Female: American Indian or Alaska Native: 25-44 years", 
         "Female: American Indian or Alaska Native: 45-64 years", "Female: American Indian or Alaska Native: 65 years and over", 
         "Female: Asian or Pacific Islander: 15-24 years", "Female: Asian or Pacific Islander: 25-44 years", 
         "Female: Asian or Pacific Islander: 45-64 years", "Female: Asian or Pacific Islander: 65 years and over")) %>%
  separate(STUB_LABEL, into = c("SEX", "RACE", "AGE"), sep = ":\\s+", extra = "merge") %>%
  filter(!is.na(ESTIMATE))

write_parquet(cleaned_sex_age_race, "data/analysis_data/cleaned_sex_age_race.parquet")

#### Save data ####
write_csv(cleaned_sex, "data/analysis_data/cleaned_sex.csv")
write_csv(cleaned_age, "data/analysis_data/cleaned_age.csv")
write_csv(cleaned_sex_race, "data/analysis_data/cleaned_sex_race.csv")
write_csv(cleaned_sex_age_race, "data/analysis_data/cleaned_sex_age_race.csv")


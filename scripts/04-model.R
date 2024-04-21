#### Preamble ####
# Purpose: Models for Suicide rates based on age, sex and race
# Author: Sarah Lee
# Date: 11 April 2024
# Contact: sarahhhh.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Parquet files for cleaned suicide data


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
cleaned_age <- read_parquet("data/analysis_data/cleaned_age.parquet")
cleaned_sex <- read_parquet("data/analysis_data/cleaned_sex.parquet")
cleaned_sex_race <- read_parquet("data/analysis_data/cleaned_sex_race.parquet")
cleaned_sex_age_race <- read_parquet("data/analysis_data/cleaned_sex_age_race.parquet")

### Model data ####

#Estimate is the suicide rate (dependent variable), creating a model based on age
first_model <-
  stan_glm(
    formula = ESTIMATE ~ AGE,
    data = cleaned_age,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )
summary(first_model)

#Estimate is the suicide rate (dependent variable), creating a model based on sex
second_model <-
  stan_glm(
    formula = ESTIMATE ~ SEX,
    data = cleaned_sex,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )
summary(second_model)

#Estimate is the suicide rate (dependent variable), creating a model based on sex and race
third_model <-
  stan_glm(
    formula = ESTIMATE ~ SEX + RACE,
    data = cleaned_sex_race,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

summary(third_model)

#Estimate is the suicide rate (dependent variable), creating a model based on sex and age
fourth_model <-
  stan_glm(
    formula = ESTIMATE ~ SEX + AGE,
    data = cleaned_age_sex,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

summary(fourth_model)

#Estimate is the suicide rate (dependent variable), creating a model based on age, sex and race
fifth_model <-
  stan_glm(
    formula = ESTIMATE ~ AGE + SEX + RACE,
    data = cleaned_sex_age_race,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )
summary(fifth_model)


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)

saveRDS(
  third_model,
  file = "models/third_model.rds"
)

saveRDS(
  fourth_model,
  file = "models/fourth_model.rds"
)

saveRDS(
  fifth_model,
  file = "models/fifth_model.rds"
)


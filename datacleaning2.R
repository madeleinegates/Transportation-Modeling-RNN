# Data Cleaning Pt 2

# This takes the data files created in "Data_cleaning.Rmd" and adds
# ID values and a numeric version of travel_mode
# Also reorders columns

library(tidyverse)

train <- read.csv("train.csv") %>% select(-c(X, survey_year, time)) %>%
  mutate(id = group_indices(., household_id, person_n)) %>%
  mutate(y = ifelse(travel_mode ==  "walk", 0,
                ifelse(travel_mode == "cycle", 1,
                       ifelse(travel_mode == "pt", 2, 3)))) %>%
  select(trip_id, household_id, person_n, trip_n, id, 
         travel_mode, y,
         year, month, day, day_of_week, start_time_linear, everything()) 

dev <- read.csv("dev.csv") %>% select(-c(X, survey_year, time)) %>%
  mutate(id = group_indices(., household_id, person_n)) %>%
  mutate(y = ifelse(travel_mode ==  "walk", 0,
                    ifelse(travel_mode == "cycle", 1,
                           ifelse(travel_mode == "pt", 2, 3)))) %>%
  select(trip_id, household_id, person_n, trip_n, id, 
         travel_mode, y,
         year, month, day, day_of_week, start_time_linear, everything()) 

test <- read.csv("test.csv") %>% select(-c(X, survey_year, time)) %>%
  mutate(id = group_indices(., household_id, person_n)) %>%
  mutate(y = ifelse(travel_mode ==  "walk", 0,
                    ifelse(travel_mode == "cycle", 1,
                           ifelse(travel_mode == "pt", 2, 3)))) %>%
  select(trip_id, household_id, person_n, trip_n, id, 
         travel_mode, y,
         year, month, day, day_of_week, start_time_linear, everything()) 


write.csv(train, "train_final.csv", row.names = FALSE)
write.csv(dev, "dev_final.csv", row.names = FALSE)
write.csv(test, "test_final.csv", row.names = FALSE)

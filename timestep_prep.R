# Time Step Prep

# This takes the data files created in "datacleaning2.R" and adds
# a column for the last travel mode (numeric, from 0 to 3) used by a given 
# individual.If no previous trip was recorded, a value of 4 is recorded.
# One hot encoding is used.

library(tidyverse)
train <- read.csv("train_final.csv")
train2 <- train %>% select(-c(trip_id, household_id, person_n, travel_mode, month, day))
train2$y_last <- NA
train2 <- train2 %>% relocate(y_last, .before = y)
for(i in 1:max(train2$id)){
  my_vec <- train2[train2$id == i,]$trip_n
  for(j in my_vec){
    k = j-1
    if(k %in% my_vec){
      train2[train2$id == i & train2$trip_n == j,]$y_last <- train2[train2$id == i & train2$trip_n == k,]$y 
    }
    else{train2[train2$id == i & train2$trip_n == j,]$y_last <- 4}
  }
}
train2 <- train2 %>% mutate(y_last_0 = ifelse(y_last == 0, 1, 0),
                            y_last_1 = ifelse(y_last == 1, 1, 0),
                            y_last_2 = ifelse(y_last == 2, 1, 0),
                            y_last_3 = ifelse(y_last == 3, 1, 0),
                            y_last_4 = ifelse(y_last == 4, 1, 0)) %>%
  relocate(c(y_last_0, y_last_1, y_last_2, y_last_3, y_last_4), .before = y)

write.csv(train2, "training_laststep.csv", row.names = FALSE)


df <- read.csv("dev_final.csv")
df2 <- df %>% select(-c(trip_id, household_id, person_n, travel_mode, month, day))
df2$y_last <- NA
df2 <- df2 %>% relocate(y_last, .before = y)
for(i in 1:max(df2$id)){
  my_vec <- df2[df2$id == i,]$trip_n
  for(j in my_vec){
    k = j-1
    if(k %in% my_vec){
      df2[df2$id == i & df2$trip_n == j,]$y_last <- df2[df2$id == i & df2$trip_n == k,]$y 
    }
    else{df2[df2$id == i & df2$trip_n == j,]$y_last <- 4}
  }
}
df2 <- df2 %>% mutate(y_last_0 = ifelse(y_last == 0, 1, 0),
                            y_last_1 = ifelse(y_last == 1, 1, 0),
                            y_last_2 = ifelse(y_last == 2, 1, 0),
                            y_last_3 = ifelse(y_last == 3, 1, 0),
                            y_last_4 = ifelse(y_last == 4, 1, 0)) %>%
  relocate(c(y_last_0, y_last_1, y_last_2, y_last_3, y_last_4), .before = y)
write.csv(df2, "dev_laststep.csv", row.names = FALSE)


df <- read.csv("test_final.csv")
df2 <- df %>% select(-c(trip_id, household_id, person_n, travel_mode, month, day))
df2$y_last <- NA
df2 <- df2 %>% relocate(y_last, .before = y)
for(i in 1:max(df2$id)){
  my_vec <- df2[df2$id == i,]$trip_n
  for(j in my_vec){
    k = j-1
    if(k %in% my_vec){
      df2[df2$id == i & df2$trip_n == j,]$y_last <- df2[df2$id == i & df2$trip_n == k,]$y 
    }
    else{df2[df2$id == i & df2$trip_n == j,]$y_last <- 4}
  }
}
df2 <- df2 %>% mutate(y_last_0 = ifelse(y_last == 0, 1, 0),
                      y_last_1 = ifelse(y_last == 1, 1, 0),
                      y_last_2 = ifelse(y_last == 2, 1, 0),
                      y_last_3 = ifelse(y_last == 3, 1, 0),
                      y_last_4 = ifelse(y_last == 4, 1, 0)) %>%
  relocate(c(y_last_0, y_last_1, y_last_2, y_last_3, y_last_4), .before = y)
write.csv(df2, "test_laststep.csv", row.names = FALSE)



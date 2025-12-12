# INTERMEDIATE R ASSIGNMENT
# DUE - DEC 12 2025
# Amna Naqvi

############ PART 1 - BASICS AND TIDYVERSE ESSENTIALS ############
# 1) installing package and saving data to 'movies'
install.packages("ggplot2movies")
library(ggplot2movies)
movies <- ggplot2movies::movies

# 2) inspecting movies
str(movies)
class(movies)

# 3) omitting votes, r1:r10 and rows w missing budgets and mpaa ratings
## loading necessary packages
library(tidyverse)
library(purrr)
library(dplyr)
## getting rid of votes, r1:r10, rows w missing budgets and mpaa ratings 
movies_final <- ggplot2movies::movies %>%
  select(-votes, -(r1:r10)) %>%
  filter(!is.na(budget),
         !is.na(mpaa), mpaa != "") #gets rid of ratings that say 'NA' or ''

# 4a) creating 'genre' column
movies_final <- movies_final %>% 
  pivot_longer(Action:Short, names_to = "genre", values_to = "flag") %>%
  filter(flag == 1) %>%
  group_by(across(-c(genre, flag))) %>%
  summarise(genre = paste(genre, collapse = ", "), .groups = "drop")

# 4b) omitting missing genres
movies_genre <- movies_final %>%
  filter(genre != "") #gets rid of any blanks under genre

movies_genre <- movies_genre %>%
  tidyr::separate_longer_delim(genre, delim = ", ")

genre_summary <- movies_genre %>%
  group_by(genre) %>%
  summarise(mean_rating = mean(rating, na.rm = TRUE)) %>%
  arrange(desc(mean_rating))

high3 <- head(genre_summary, 3) 
#shows top 3 genres from high to low: Drama, Animation, Documentary
low3 <- tail(genre_summary, 3) 
#shows lowest 3 genres from high to low: Romance, Comedy, Action

# 5a) data visualization

# first type
movies_final |>
  ggplot(aes(x = year, y = rating)) +
  geom_point() +
  labs(title = "Average Film Rating by Year", x = "Year Released", y = 
         "Film Rating") +
  theme_minimal()

# second type
movies_final |>
  ggplot(aes(x = year, y = rating)) +
  geom_area() +
  labs(title = "Average Film Rating by Year", x = "Year Released", y = 
         "Film Rating") +
  theme_minimal()

# third type
movies_final |>
  ggplot(aes(x = year, y = rating)) +
  geom_count() +
  labs(title = "Average Film Rating by Year", x = "Year Released", y = 
         "Film Rating") +
  theme_minimal()
# 5b) extending third type of plot for determining relationship btw rating 
# and year across mpaa ratings
movies_final |>
  ggplot(aes(x = year, y = rating)) +
  geom_count() +
  geom_smooth(se = FALSE, color = "lightblue") +
  labs(title = "Average Film Rating by Year Across MPAA Ratings", 
       x = "Year Released", 
       y = "Film Rating") +
  theme_minimal() +
  facet_wrap(~ mpaa)

############ PART 2 - FUNCTIONS, ITERATION, AND DEBUGGING ############
# 6a) roll_dice & sample

roll_dice <- function(d = 20, num_rolls = 1) {
  sample(1:d, size = num_rolls, replace = TRUE)
}

roll_dice(d = 10, num_rolls = 2)
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


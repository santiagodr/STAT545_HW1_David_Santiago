# Read data, joins and cleaning 
# Need one single dataframe for all species that overlap in the two files with variables of interest

library(tidyverse)
library(readxl)
library(stringr)

# Read separate files
bird_func_data <- read_tsv("bird_func_dat.txt")
bird_morph_data <- read_excel("Measurements of passerine birds.xlsx")

# check str of dataframes
glimpse(bird_func_data)
glimpse(bird_morph_data)

# Fix scientific names in bird_morph_data to be one binomial name, so that we can join based on 
# that variable --> Scientific
bird_morph_data <- bird_morph_data %>% 
  mutate(Scientific = str_c(Genus, Species, sep = " "))

# There are 9995 species in func_data vs 2366 species in morph_data
# Join both databases, but only keeping the species in common
# select only meaningful variables for functional or morphological traits
bird_data_clean <- bird_morph_data %>% 
  inner_join(bird_func_data) %>% 
  select(Family, Scientific, `BodyMass-Value`, Length:`Bill D`, `Diet-Inv`:`Diet-5Cat`, 
         `ForStrat-watbelowsurf`:PelagicSpecialist, Nocturnal)

# export data to file
write_csv(bird_data_clean, "bird_data_clean.csv")

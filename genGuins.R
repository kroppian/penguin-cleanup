
# install.packages("palmerpenguins");   install.packages("tidyverse")
library(palmerpenguins)
library(conflicted)  
library(tidyverse)

data(package = 'palmerpenguins')
data("penguins")

# Pull out the data
penguins <- penguins_raw
species <- read.csv("species.csv")
islands <- read.csv("island.csv")

# Separate species and name 
penguins <- penguins %>% 
            separate_wider_delim(Species, delim= "(" , names = c("CommonName", "ScientificName")) %>%
            mutate(ScientificName=gsub(")", "", ScientificName)) %>%
            mutate(CommonName=gsub("penguin", "Penguin", CommonName)) %>%
            mutate(CommonName=trimws(CommonName))


# Join species and island info
merged <- penguins %>% left_join(species, by = join_by(CommonName)) %>% left_join(islands)


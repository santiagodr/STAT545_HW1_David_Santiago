# Run analysis and produce graphs
#setwd("hw07")

library(tidyverse)

# Load clean file
bird_data <- read_csv("bird_data_clean.csv")

glimpse(bird_data)

# Number of species in each Diet category
fig1 <- dplyr::count(bird_data, `Diet-5Cat`) %>%
  arrange(-n) %>%
  mutate(`Diet-5Cat` = factor(`Diet-5Cat`, `Diet-5Cat`)) %>%
  ggplot(aes(x=`Diet-5Cat`, y=n)) + geom_bar(stat="identity", fill = "skyblue4") +
  labs(x = "Main Diet Category", y = "Number of species") +
  theme_bw()
ggsave("fig1_spbydiet.png", plot = fig1, width = 6, height = 4)

# Diet is also represented as the % use of different food sources, lets show this visaully by
# subsetting data for 9 species and rearranging data to create two variables and
# percentange of use of each diet type per species

bird_diet <- bird_data %>%
  sample_n(9, replace = TRUE) %>% 
  select(Scientific, `Diet-Inv`:`Diet-PlantO`) %>% 
  gather(diet_types, percentage_use, `Diet-Inv`:`Diet-PlantO`)

fig2 <- bird_diet %>% 
  ggplot(aes(y = percentage_use, x = diet_types)) + theme_bw() +
  geom_bar(position = "dodge", stat = "identity", fill = "#A2CD5A") +
  theme(axis.text.x = element_text(angle=90, hjust = 1)) +
  labs(x = "Diet categories", y = "Estimated percentage use (%)") +
  facet_wrap(~Scientific) 
ggsave("fig2_sample_.png", plot = fig1, width = 6, height = 4)





ggplot(bird_diet, aes(percentage_use)) + 
  scale_fill_brewer(palette = "Spectral") +
  geom_histogram(aes(fill = diet_types),
                 binwidth = 5,
                 col = "black",
                 size = .5) +
  labs(x = "Percentage of use", y = "Number of species") +
  theme_classic()
 


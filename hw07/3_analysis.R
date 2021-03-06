# Run analysis and produce graphs
#setwd("hw07")

library(tidyverse)

# Load clean file
bird_data <- read_csv("bird_data_clean.csv")

# fix class of some variables
bird_data <- bird_data %>% 
  mutate(Length = as.double(Length),
         Tarsus = as.double(Tarsus),
         Toe = as.factor(Toe),
         `Diet-5Cat` = as.factor(`Diet-5Cat`))

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

bird_sample <- bird_data %>%
  sample_n(9, replace = TRUE) %>% 
  select(Scientific, `Diet-Inv`:`Diet-PlantO`) %>% 
  gather(diet_types, percentage_use, `Diet-Inv`:`Diet-PlantO`)

fig2 <- bird_sample %>% 
  ggplot(aes(y = percentage_use, x = diet_types)) + theme_bw() +
  geom_bar(position = "dodge", stat = "identity", fill = "#A2CD5A") +
  theme(axis.text.x = element_text(angle=90, hjust = 1)) +
  labs(x = "Diet categories", y = "Estimated percentage use (%)") +
  facet_wrap(~Scientific) 
ggsave("fig2_sample_diet_use.png", plot = fig2, width = 6, height = 4)

#### Now into more complex stuff
# Lets show the distribution of traits per diet category
bird_diet <- bird_data %>%
  select(Scientific, `Diet-5Cat`, `BodyMass-Value`:`Bill D`) %>% 
  gather(trait, value, `BodyMass-Value`:`Bill D`)

bird_diet <- bird_diet %>% 
  mutate(`Diet-5Cat` = as.factor(`Diet-5Cat`),
         trait = as.factor(trait),
         value = as.double(value))

# Plot to show distribution of each morphological trait by Diet category
fig3 <- bird_diet %>% 
ggplot(aes(x = `Diet-5Cat`, y = value, fill = `Diet-5Cat`)) +
  geom_boxplot() + theme_bw() +
  theme(axis.text.x = element_text(angle=90, hjust = 1)) +
  labs(x = "Diet categories", y = "Mean value of trait") +
  facet_wrap(~trait, scales = "free_y")
ggsave("fig3_trait_distribution_per_diet.png", plot = fig3, width = 6, height = 6)


# Is there a difference between Mass and Bill length among diet categories
fig4 <- bird_data %>% 
  ggplot(aes(`BodyMass-Value`, `Bill L`)) + theme_bw() +
  geom_jitter(aes(col = `Diet-5Cat`), alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(aes(col = `Diet-5Cat`), method = lm, se = F) +
  labs(x = "log Body Mass (g)", y = "log Bill Length (mm)")
ggsave("fig4_bill_mass.png", plot = fig4, width = 6, height = 6) 

# What about Tarsus length and Mass among diet categories
fig5 <- bird_data %>% 
  ggplot(aes(`BodyMass-Value`, Tarsus)) + theme_bw() +
  geom_jitter(aes(col = `Diet-5Cat`), alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(aes(col = `Diet-5Cat`), method = lm, se = F) +
  labs(x = "log Body Mass (g)", y = "log Tarsus (mm)")
ggsave("fig5_tarsus_mass.png", plot = fig5, width = 6, height = 6)


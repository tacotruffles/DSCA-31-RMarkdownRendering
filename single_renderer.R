library('tidyverse')

# Goal:
#  - Utilize iris dataset and create summary
#  - Get summary statistics per species
#  - Each species should be in its own Rmd

# Get data and clean names
dat_raw = iris
dat = dat_raw %>% janitor::clean_names()

# List of species to map
unique_species = dat$species %>% unique()

# Create list of "params"
param_list = map(unique_species,
                 ~list(species_filter = .,
                       dat = dat))

# Create tibble of report locations
reports = tibble(
  output_file = stringr::str_c("single_examples/", unique_species, "-report.html"),
  params = param_list
  )

# Render your Rmd files **Note** You must create the directory first (or could do programatically)
reports %>%
  purrr::pwalk(rmarkdown::render, input = 'single_render.Rmd')



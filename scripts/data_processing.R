###########################
##### DATA PROCESSING #####
###########################

### load packages
#install.packages("janitor")
library(janitor)
library(dplyr)

### import data
tree <- 
raw <- read.csv("/home/tecorn/BIOL8230/jbi14547-sup-0003-appendixs3.csv")
head(raw)

### clean data
df <- df_raw %>%
  select(-c(PC1, PC2, Data.sources, Reference,Long,Lat)) %>% # remove PCs, references, and coordinates
  clean_names() %>% # convert headers to snake_case
  distinct() # check for duplicates

print(names(df))

summary(df)

# 8 NAs in tll
# 27 NAs in ps_vn

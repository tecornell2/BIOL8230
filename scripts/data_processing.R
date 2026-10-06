###########################
##### DATA PROCESSING #####
###########################

### load packages
#install.packages("janitor")
library(janitor)
library(dplyr)
library(ape)
library(geiger)

### import data
raw <- read.csv("/home/tecorn/BIOL8230/jbi14547-sup-0003-appendixs3.csv")
tree <- read.tree("/home/tecorn/BIOL8230/squamate_phylogeny.txt")

######################
##### DATA FRAME #####
######################

df <- df_raw %>%
  select(-c(PC1, PC2, Data.sources, Reference,Long,Lat)) %>% # remove PCs, references, and coordinates
  clean_names() %>% # convert headers to snake_case
  distinct() # check for duplicates

print(names(df))

summary(df)

# 8 NAs in tll
# 27 NAs in ps_vn

# transform data
dat <- df[, -1, drop = FALSE]
rownames(dat) <- species

# geiger expects continuous trait data
dat <- as.matrix(dat)
storage.mode(dat) <- "numeric"


#####################
##### PHYLOGENY #####
#####################

# check num of species in data.frame compared to phylogeny
species <- trimws(as.character(df[[1]]))
sum(species %in% tree$tip.label)
head(setdiff(species, tree$tip.label))
# 121 sp

plot(tree)
tdat <- treedata(tree,dat)

head(tdat)

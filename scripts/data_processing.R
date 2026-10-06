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

##########################
####### DATA FRAME #######
##########################

df <- df_raw %>%
  select(-c(PC1, PC2, Data.sources, Reference,Long,Lat)) %>% # remove PCs, references, and coordinates
  clean_names() %>% # convert headers to snake_case
  distinct() # check for duplicates

print(names(df))

summary(df)

# 8 NAs in tll
# 27 NAs in ps_vn


##############################
####### TRANSFORM DATA #######
##############################

# data broken down into two sets- discrete and continuous

# continuous trait data
dat_cont <- df[, -(1:4), drop = FALSE]
rownames(dat_cont) <- species
dat_cont <- as.matrix(dat_cont)

# discrete trait data
dat_disc <- df[,4, drop = FALSE]
rownames(dat_disc) <- species
dat_disc <- as.matrix(dat_disc)


###########################
######## PHYLOGENY ########
###########################

# check num of species in data.frame compared to phylogeny
sum(species %in% tree$tip.label)
# 121 sp


tdat_cont <- treedata(tree,dat_cont)

tdat_disc <- treedata(tree,dat_disc)


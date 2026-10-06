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

#####################
##### PHYLOGENY #####
#####################

plot(tree)

node_num <- getMRCA(tree,c("Ophioscincus_truncatus","Lerista_kennedyensis"))
cladeG_tree <- extract.clade(tree,node_num)

plot(cladeG_tree)

dat <- treedata(cladeG_tree,df) # no nodes????

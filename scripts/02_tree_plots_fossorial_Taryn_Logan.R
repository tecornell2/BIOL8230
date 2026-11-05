### CONT. FROM DATA_PROCESSING.R

# used the following variables from data_processing.R
      # df
      # species
      # dat_disc
      # tdat_disc

# create vector for fossoriality data

fossorial<-rep(1, length(species)) # vector of only 1s
fossorial[df[,4]=="terrestrial"]<-2
names(fossorial)<-row.names(dat_disc)

##############################
###### PLOT: FOSSORIAL #######
##############################

colr<-rep("grey", length(fossorial)) # grey = fossorial = 1
colr[fossorial == 2]<-"darkgreen" # darkgreen = terrestrial = 2
names(colr)<-names(fossorial)
colr<-colr[tdat_disc$phy$tip.label]

# plot tree with fossorial trait at tips
plot(tdat_disc$phy, show.tip.label = FALSE)
tiplabels(pch = 16, col = colr, cex = 1)

###########################
###### PLOT: GENERA #######
###########################

library(phytools)

phy <- tdat_disc$phy

# generate one color per genus
box_cols <- setNames(
  hcl.colors(length(nodes), "Dark 3"),
  names(nodes)
)

# plot tree
plot(phy, show.tip.label = TRUE,  main = "121 species of Sphenomorphinae", cex = 0.3)
# generate box around each genera
for (genus in names(nodes)) {
  box <- cladebox( # draws a box around a node's clade
    node = nodes[genus], 
    col = adjustcolor(box_cols[genus], alpha.f = 0.15) # lighten colors
  )
  # opaque outline
  polygon(box$x, box$y, col = NA, border = box_cols[genus], lwd = 1.5) # x and y coordinates from cladebox()
}
# add node labels
nodelabels(
  text = names(nodes),
  node = nodes,
  cex = 0.7,
  bg = "white",
  adj = c(0, 0.3)
)



#I could not get the code above this to run so this is what I did to get the same plot from above 
###########################
###### Logan's Code #######
###########################
###########################
###### PLOT: GENERA #######
###########################

phy <- tdat_disc$phy

# define genera (from each focal group)
focal_clades <- list(
  "Anomalopus group" = c(
    "Anomalopus", "Calyptotis", "Coeranoscincus",
    "Coggeria", "Ophioscincus", "Concinnia",
    "Nangura", "Silvascincus"
  ),
  "Glaphyromorphus" = c("Glaphyromorphus", "Eulamprus"),
  "Hemiergis" = c("Hemiergis", "Eremiascincus"),
  "Lerista" = c("Lerista", "Ctenotus")
)

# extract genus (that is the name for each genus)
genus <- sub("_.*", "", phy$tip.label)

# getting the node for each focal group
nodes <- sapply(focal_clades, function(genera) {
  tips <- phy$tip.label[genus %in% genera]
  if (length(tips) > 1) getMRCA(phy, tips) else NA
})

box_cols <- c(
  "Anomalopus group" = "blue",
  "Glaphyromorphus"  = "orange",
  "Hemiergis"        = "green",
  "Lerista"          = "red"
)

# plot tree
plot(
  phy, show.tip.label = TRUE,
  main = "121 species of Sphenomorphinae",
  cex = 0.3
)

# opaque outline
for (group in names(nodes)) {
  if (!is.na(nodes[group])) {
    box <- cladebox(
      node = nodes[group],
      col = adjustcolor(box_cols[group], alpha.f = 0.15)
    )
    
    polygon(
      box$x, box$y,
      col = NA,
      border = box_cols[group],
      lwd = 1.5
    )
  }
}

# focal-group labels
nodelabels(
  text = names(nodes),
  node = nodes,
  cex = 0.7,
  bg = "white",
  adj = c(0, 0.3)
)






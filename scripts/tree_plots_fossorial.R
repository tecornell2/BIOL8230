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

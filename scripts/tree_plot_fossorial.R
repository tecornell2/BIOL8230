# used the following variables from data_processing.R
      # df
      # species
      # dat_disc
      # tdat_disc

# create vector for fossoriality data

fossorial<-rep(1, length(species)) # vector of only 1s
fossorial[df[,4]=="terrestrial"]<-2
names(fossorial)<-row.names(dat_disc)

###################
###### PLOT #######
###################

colr<-rep("grey", length(fossorial)) # grey = fossorial = 1
colr[fossorial == 2]<-"darkgreen" # darkgreen = terrestrial = 2
names(colr)<-names(fossorial)
colr<-colr[tdat_disc$phy$tip.label]

# plot tree with fossorial mode at tips
plot(tdat_disc$phy, show.tip.label = FALSE)
tiplabels(pch = 16, col = colr, cex = 1)

p <- recordPlot()

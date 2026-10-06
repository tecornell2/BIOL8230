### WIP

### TARYN ATTEMPTS BASIC PLOTS




#### PRICE SCRIPT
# set up a vector of "grey" for the length of the feeding mode vector this will act as the diet =1 which is sand
colr<-rep("grey", length(feeding))
# where feeding = 2 replace "grey" with darkgreen
colr[feeding ==2]<-"darkgreen" 
names(colr)<-names(feeding)
# sort the colours so they match the same order as the tip labels in the tree
colr<-colr[prunedtr$tip.label] 
# plot tree with feeding mode at tips
plot(prunedtr, show.tip.label=F)
tiplabels(pch=16, col=colr, cex=1)

# PHYLOMORPHOSPACE: SOIL DENSITY AND LIMB LENGTH 

library(ape)
library(geiger)
library(phytools)

# Variables to plot against soil bulk density
limb_traits <- c("fll", "hll", "tll")

# Axis labels
limb_labels <- c(
  fll = "Front limb length",
  hll = "Hind limb length",
  tll = "Total limb length"
)

# Display the three plots together
par(mfrow = c(1, 3), mar = c(5, 5, 3, 1))

for (trait in limb_traits) {
  
  # Retain species with complete data for the current plot
  plot_df <- df[
    complete.cases(df[, c("species", "bd_wmean", trait)]),
    c("species", "bd_wmean", trait)
  ]
  
  # Remove species not present in the phylogeny
  plot_df <- plot_df[
    plot_df$species %in% tree$tip.label,
  ]
  
  # Create a two-column trait matrix
  X <- as.matrix(
    plot_df[, c("bd_wmean", trait)]
  )
  
  # Assign species names as matrix row names
  rownames(X) <- plot_df$species
  
  # Give the columns informative names
  colnames(X) <- c(
    "Soil density",
    limb_labels[trait]
  )
  
  # Match the phylogeny and trait data
  tdat <- geiger::treedata(
    phy = tree,
    data = X,
    sort = TRUE,
    warnings = TRUE
  )
  
  # Ensure that matrix rows follow the tree-tip order
  X_matched <- tdat$data[
    tdat$phy$tip.label,
    ,
    drop = FALSE
  ]
  
  # Draw the phylomorphospace
  phytools::phylomorphospace(
    tree = tdat$phy,
    X = X_matched,
    label = "off",
    xlab = expression(
      paste("Soil bulk density (g/", cm^3, ")")
    ),
    ylab = limb_labels[trait],
    node.size = c(0, 0),
    control = list(
      col.edge = adjustcolor("grey40", alpha.f = 0.6),
      col.node = "grey40"
    ),
    pch = 21,
    bg = "steelblue",
    col = "black",
    cex = 1.1,
    bty = "l"
  )
  
  title(
    main = paste("Soil density vs.", limb_labels[trait])
  )
}

# Return to the default plotting layout
par(mfrow = c(1, 1))

#Logan's Code 
##############################
######PHYLOMORPHOSPACE #######
##############################
tree <- tdat_disc$phy

focal_genera <- list(
  "Anomalopus group" = c(
    "Anomalopus", "Calyptotis", "Coeranoscincus",
    "Coggeria", "Ophioscincus", "Concinnia",
    "Nangura", "Silvascincus"
  ),
  "Glaphyromorphus" = c("Glaphyromorphus", "Eulamprus"),
  "Hemiergis" = c("Hemiergis", "Eremiascincus"),
  "Lerista" = c("Lerista", "Ctenotus")
)

box_cols <- c(
  "Anomalopus group" = "blue",
  "Glaphyromorphus" = "orange",
  "Hemiergis" = "green",
  "Lerista" = "red"
)

# Assign focal groups
genus <- sub("_.*$", "", df$species)
df$focal_group <- NA_character_

for (grp in names(focal_genera)) {
  df$focal_group[genus %in% focal_genera[[grp]]] <- grp
}

limb_traits <- c("fll", "hll", "tll")

limb_labels <- c(
  fll = "Front limb length",
  hll = "Hind limb length",
  tll = "Total limb length"
)

# Reset plotting device and layout
graphics.off()
par(mfrow = c(1, 3), mar = c(5, 4, 3, 1))

for (trait in limb_traits) {
  
  plot_df <- df[
    complete.cases(df[, c("species", "bd_wmean", trait)]) &
      df$species %in% tree$tip.label,
  ]
  
  X <- as.matrix(plot_df[, c("bd_wmean", trait)])
  rownames(X) <- plot_df$species
  colnames(X) <- c("Soil bulk density", limb_labels[trait])
  
  td <- geiger::treedata(
    phy = tree,
    data = X,
    sort = TRUE,
    warnings = TRUE
  )
  
  X_matched <- td$data[td$phy$tip.label, , drop = FALSE]
  
  # Match focal groups to the tree-tip order
  matched_rows <- match(td$phy$tip.label, plot_df$species)
  matched_groups <- plot_df$focal_group[matched_rows]
  point_cols <- unname(box_cols[matched_groups])
  
  # Draw branches and morphospace without visible tip symbols
  phytools::phylomorphospace(
    tree = td$phy,
    X = X_matched,
    label = "off",
    xlab = "Soil bulk density",
    ylab = limb_labels[trait],
    node.size = c(0, 0),
    pch = NA,
    col = "grey40",
    cex = 0
  )
  
  # Draw colored terminal nodes at the exact branch endpoints
  points(
    X_matched[, 1],
    X_matched[, 2],
    pch = 21,
    bg = point_cols,
    col = "black",
    cex = 1.1
  )
  
  title(main = paste("Soil density vs.", limb_labels[trait]))
}

par(mfrow = c(1, 1))

#############################################
#############################################
######PHYLOMORPHOSPACE density shade ########
#############################################


# plotting morphospaces, and estimating point density
library(geiger)
library(phytools)
library(MASS)

# phylogenetic tree from the existing dataset
tree <- tdat_disc$phy

# genera that belong to each focal group
focal_genera <- list(
  "Anomalopus group" = c(
    "Anomalopus", "Calyptotis", "Coeranoscincus",
    "Coggeria", "Ophioscincus", "Concinnia",
    "Nangura", "Silvascincus"),
  "Glaphyromorphus" = c("Glaphyromorphus", "Eulamprus"),
  "Hemiergis" = c("Hemiergis", "Eremiascincus"),
  "Lerista" = c("Lerista", "Ctenotus"))

# color for each focal group
box_cols <- c(
  "Anomalopus group" = "blue",
  "Glaphyromorphus" = "orange",
  "Hemiergis" = "green",
  "Lerista" = "red")

# genus of each species (focal group)
genus <- sub("_.*$", "", df$species)
df$focal_group <- NA_character_
for (grp in names(focal_genera)) {
  df$focal_group[genus %in% focal_genera[[grp]]] <- grp
}

# three limb measurements to plot
limb_traits <- c("fll", "hll", "tll")

# labels y-axes
limb_labels <- c(
  fll = "Front limb length",
  hll = "Hind limb length",
  tll = "Total limb length")
graphics.off()

# plots in one row and space for the legend
par(mfrow = c(1, 3), mar = c(4.5, 4.2, 3, 1),oma = c(3, 0, 0, 0))

# one morphospace plot for each limb measurement
for (trait in limb_traits) {
  # combine soil bulk density and the selected limb measurement into a matrix for plotting
  X <- as.matrix(plot_df[, c("bd_wmean", trait)])
  rownames(X) <- plot_df$species
  colnames(X) <- c("Soil bulk density", limb_labels[trait])
  # species data to the phylogenetic tree/ remove species that cannot be matched
  td <- geiger::treedata(phy = tree, data = X, sort = TRUE, warnings = TRUE)
  # trait values in the same order as the tree tips
  X_matched <- td$data[td$phy$tip.label, , drop = FALSE]
  # each tree tip to its focal group and corresponding color
  matched_rows <- match(td$phy$tip.label, plot_df$species)
  matched_groups <- plot_df$focal_group[matched_rows]
  point_cols <- unname(box_cols[matched_groups])
  # axis limits from the trait values/ add in a little extra space around the points
  xlim <- range(X_matched[, 1], finite = TRUE)
  ylim <- range(X_matched[, 2], finite = TRUE)
  xpad <- max(diff(xlim) * 0.08, 0.01)
  ypad <- max(diff(ylim) * 0.08, 0.01)
  xlim <- xlim + c(-xpad, xpad)
  ylim <- ylim + c(-ypad, ypad)
  
  
  # empty plotting area with the correct axes and title
  plot(
    NA,
    xlim = xlim,
    ylim = ylim,
    xlab = "Soil bulk density",
    ylab = limb_labels[trait],
    main = paste("Soil density vs.", limb_labels[trait]),
    bty = "l")
  
  # estimate the distribution of species within each focal group/ color a transparent shaded region around its points
  for (grp in names(box_cols)) {
    # species belonging to the current focal group
    idx <- which(matched_groups == grp)
    # estimate density only when there are enough species
    if (
      length(idx) >= 5 &&
      length(unique(X_matched[idx, 1])) >= 2 &&
      length(unique(X_matched[idx, 2])) >= 2
    ) {
      # estimate where species points are most concentrated
      dens <- MASS::kde2d(
        X_matched[idx, 1],
        X_matched[idx, 2],
        n = 100,
        lims = c(xlim, ylim)
      )
      # find the outer density to outline the region (points)
      contour_lines <- contourLines(
        dens$x, dens$y, dens$z,
        levels = max(dens$z) * 0.15
      )
      # fill the density region with the group's transparent color
      for (cl in contour_lines) {
        polygon(
          cl$x, cl$y,
          col = adjustcolor(box_cols[grp], alpha.f = 0.18),
          border = adjustcolor(box_cols[grp], alpha.f = 0.6)
        )
      }
    }
  }
  
  
  # phylogenetic branches over the shaded density regions
  phytools::phylomorphospace(
    tree = td$phy,
    X = X_matched,
    label = "off",
    xlab = "Soil bulk density",
    ylab = limb_labels[trait],
    node.size = c(0, 0),
    pch = NA,
    col = "grey40",
    cex = 0,
    add = TRUE)
  
  # colored circle at the end of each branch (using the color assigned to that species' focal group)
  points(
    X_matched[, 1],
    X_matched[, 2],
    pch = 21,
    bg = point_cols,
    col = "black",
    cex = 1.1 )
}


# standard single-plot layout
par(mfrow = c(1, 1))

# shared horizontal legend for the four focal groups
par(xpd = NA)

legend(
  "bottom",
  inset = c(0, -0.25),
  legend = names(box_cols),
  pt.bg = box_cols,
  pch = 21,
  col = "black",
  horiz = TRUE,
  bty = "n",
  cex = 0.9
)

#############################################################
#############################################################
######PHYLOMORPHOSPACE density shade (no node color) ########
#############################################################
graphics.off()

par(mfrow = c(1, 3),mar = c(4.5, 4.2, 3, 1),oma = c(3, 0, 0, 0))

# one plot for each limb measurement
for (trait in limb_traits) {
  # species with complete data for soil bulk density and this limb trait
  plot_df <- df[
    complete.cases(df[, c("species", "bd_wmean", trait)]) &
      df$species %in% tree$tip.label,]
  
  # combine the two measurements into a matrix for plotting
  X <- as.matrix(plot_df[, c("bd_wmean", trait)])
  rownames(X) <- plot_df$species
  colnames(X) <- c("Soil bulk density", limb_labels[trait])
  # match the species data to the phylogenetic tree
  td <- geiger::treedata(
    phy = tree,
    data = X,
    sort = TRUE,
    warnings = TRUE
  )
  
  # arrange trait values in the same order as the tree tips
  X_matched <- td$data[td$phy$tip.label, , drop = FALSE]
  # identify the focal group belonging to each species
  matched_rows <- match(td$phy$tip.label, plot_df$species)
  matched_groups <- plot_df$focal_group[matched_rows]
  # axis limits from the trait values/ add in a little extra space around the points
  xlim <- range(X_matched[, 1], finite = TRUE)
  ylim <- range(X_matched[, 2], finite = TRUE)
  xpad <- max(diff(xlim) * 0.08, 0.01)
  ypad <- max(diff(ylim) * 0.08, 0.01)
  xlim <- xlim + c(-xpad, xpad)
  ylim <- ylim + c(-ypad, ypad)
  
  # empty plotting area with the correct axes and title
  plot(
    NA,
    xlim = xlim,
    ylim = ylim,
    xlab = "Soil bulk density",
    ylab = limb_labels[trait],
    main = paste("Soil density vs.", limb_labels[trait]),
    bty = "l")
  
  
  # two-dimensional density for each focal group (groups need at least five species)
  density_list <- list()
  for (grp in names(box_cols)) {
    idx <- which(
      matched_groups == grp &
        is.finite(X_matched[, 1]) &
        is.finite(X_matched[, 2]) )
    if (
      length(idx) >= 5 &&
      length(unique(X_matched[idx, 1])) >= 2 &&
      length(unique(X_matched[idx, 2])) >= 2 ) {
      density_list[[grp]] <- MASS::kde2d(
        X_matched[idx, 1],
        X_matched[idx, 2],
        n = 100,
        lims = c(xlim, ylim)
      )
    }
  }
  
  # each grid cell to the group with the highest relative density (prevents two groups from shading the same grid cell)
  if (length(density_list) > 0) {
    # scale each group's density by its own maximum
    density_array <- simplify2array(
      lapply(density_list, function(d) d$z / max(d$z)))
    # dimensions correspond to the x-grid, y-grid/ the number of focal groups
    density_array <- array(
      density_array,
      dim = c(
        length(density_list[[1]]$x),
        length(density_list[[1]]$y),
        length(density_list)) )
    
    # group with the highest relative density at each grid cell
    winner <- apply(density_array, c(1, 2), which.max)
    # shade only cells where the winning group's relative density is at least 20% of that group's maximum
    threshold <- 0.20
    for (j in seq_along(density_list)) {
      d <- density_list[[j]]
      region <- winner == j &
      density_array[, , j] >= threshold
      # calculate grid-cell dimensions
      dx <- diff(d$x)[1]
      dy <- diff(d$y)[1]
      # draw the cells belonging to this group's region
      cell_indices <- which(region, arr.ind = TRUE)
      if (nrow(cell_indices) > 0) {
        for (k in seq_len(nrow(cell_indices))) {
          ix <- cell_indices[k, 1]
          iy <- cell_indices[k, 2]
          rect(
            xleft = d$x[ix] - dx / 2,
            ybottom = d$y[iy] - dy / 2,
            xright = d$x[ix] + dx / 2,
            ytop = d$y[iy] + dy / 2,
            col = adjustcolor(
              box_cols[names(density_list)[j]],
              alpha.f = 0.18
            ),
            border = NA
          )
        }
      }
    }
  }
  
  
  # phylogenetic branches over the density regions
  phytools::phylomorphospace(
    tree = td$phy,
    X = X_matched,
    label = "off",
    xlab = "Soil bulk density",
    ylab = limb_labels[trait],
    node.size = c(0, 0),
    pch = NA,
    col = "grey40",
    cex = 0,
    add = TRUE)
  
  
  # terminal species points in grey
  points(
    X_matched[, 1],
    X_matched[, 2],
    pch = 21,
    bg = "grey30",
    col = "black",
    cex = 1.1)
}


# standard plotting layout and add one shared legend
par(mfrow = c(1, 1))
par(xpd = NA)

legend(
  "bottom",
  inset = c(0, -0.25),
  legend = names(box_cols),
  pt.bg = box_cols,
  pch = 22,
  col = "black",
  horiz = TRUE,
  bty = "n",
  cex = 0.9,
  title = "Focal group density"
)

#  normal clipping setting
par(xpd = FALSE)



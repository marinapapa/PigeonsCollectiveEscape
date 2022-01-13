## Figure 2. Tracks of real and simulated flock, along with distribution of individual turning in empirical data

# #Uncomment to use font as in paper
# extrafont::font_import()
# extrafont::loadfonts(device = "win")

pal <- wesanderson::wes_palette("Zissou1", 20, type = "continuous")

################################################################
## Column A - Empirical track

emp_flock_track <- read.csv('../Data/empirical/flock_10_track.csv')
emp_split_track <- read.csv('../Data/empirical/flock_10_pigeon65_split.csv')


lpl <- ggplot2::ggplot(emp_flock_track)+
  ggplot2::geom_point(data = emp_split_track,
                      ggplot2::aes(lon, lat), 
                      color = 'grey40', 
                      size = 4, 
                      inherit.aes = FALSE)+
  ggplot2::geom_segment(ggplot2::aes(x = -0.598, xend = -0.597, y = 51.376,  yend = 51.376, linetype = 'solid'),
                        inherit.aes = FALSE) + 
  ggplot2::geom_segment(ggplot2::aes(x =  -0.598, xend =  -0.598, y = 51.3759,  yend = 51.3761, linetype = 'solid'),
                        inherit.aes = FALSE) + 
  ggplot2::geom_segment(ggplot2::aes(x = -0.597, xend = -0.597, y = 51.3759,  yend = 51.3761, linetype = 'solid'),
                        inherit.aes = FALSE) + 
  ggplot2::geom_text(ggplot2::aes(x =  -0.5975, y = 51.376, label = '50 m'), 
                     family = 'Palatino Linotype', 
                     vjust = -0.5, 
                     size = 5) +
  ggplot2::geom_point(ggplot2::aes(flock_lon, flock_lat, color = ang_vel, alpha = as.factor(turnornot)),
                      size = 6) +
  ggplot2::scale_colour_gradientn(colours = c("dodgerblue3","dodgerblue1", "grey40","firebrick2", "darkred"),
                                  space = "Lab",
                                  na.value = "white",
                                  guide = "colourbar",
                                  aesthetics = "colour",
                                  name = "Angular velocity of turn" )+
  ggplot2::scale_alpha_manual(values = c(0.1, 1), 
                              labels = c('Straight\n flight', ''), 
                              name = 'Motion') +
  ggplot2::guides(linetype = FALSE,
                  alpha = FALSE, 
                  colour = ggplot2::guide_colourbar(title.position = "top", ticks.colour = 'black', label.hjust = -0.01)
                  ) +
  ggplot2::labs(x = 'Longitude', y = 'Latitude', title = 'Track of a real flock of pigeons') +
  ggplot2::theme_bw()+
  ggplot2::geom_curve(data = data.frame(y = 51.3758),
                      ggplot2::aes(x = -0.595, y = 51.3764, xend = -0.594, yend = 51.3758),
                      arrow = ggplot2::arrow(length = ggplot2::unit(4.2, "mm")),
                      lwd = 2,
                      curvature = .3,
                      color="black") +
  ggplot2::geom_text( x = -0.595, 
                      y = 51.3765, 
                      label = "Collective turn", 
                      hjust = "middle", 
                      family = 'Palatino Linotype', 
                      size = 7) +
  ggplot2::geom_curve(data = data.frame(y = 51.3751),
                      ggplot2::aes(x = -0.5945, y = 51.3745, xend = -0.595, yend = 51.3751),
                      arrow = ggplot2::arrow(length = ggplot2::unit(4.2, "mm")), lwd = 2, curvature = -.3,
                      color = "black") +
  ggplot2::geom_text(x = -0.59445, 
                     y = 51.3745, 
                     label = "Straight\n  flight", 
                     hjust = "left",
                     family = 'Palatino Linotype', 
                     size = 7) +
  ggplot2::geom_curve(data = data.frame(y = 51.3751),
                      ggplot2::aes(x = -0.5955, y = 51.3735, xend = -0.5961, yend = 51.3739),
                      arrow = ggplot2::arrow(length = ggplot2::unit(4.2, "mm")), 
                      lwd = 2,
                      curvature = -.3,
                      color = "black") +
  ggplot2::geom_text(x = -0.59545,
                     y = 51.3735, 
                     label = "Merge", 
                     hjust = "left", 
                     family = 'Palatino Linotype', 
                     size = 7) +
  ggplot2::geom_curve(data = data.frame(y = 51.3751),
                      ggplot2::aes(x = -0.5983, y = 51.3743, xend = -0.5985, yend = 51.37345),
                      arrow = ggplot2::arrow(length = ggplot2::unit(4.2, "mm")), 
                      lwd = 2, 
                      curvature = .3,
                      color = "black") +
  ggplot2::geom_text( x = -0.59825,
                      y = 51.37432,
                      label = "Split",
                      hjust = "left",
                      family = 'Palatino Linotype', 
                      size = 7) +
  ggplot2::geom_text( x = -0.5984,
                      y = 51.37287,
                      label = "Start", 
                      hjust = "left", 
                      family = 'Palatino Linotype', 
                      size = 6) +
  ggplot2::geom_text( x = -0.5944,
                      y = 51.37715, 
                      label = "End",
                      hjust = "right",
                      family = 'Palatino Linotype', 
                      size = 6) +
  ggplot2::geom_point(x = emp_flock_track$flock_lon[1],
                      y = emp_flock_track$flock_lat[1],
                      size = 6, 
                      color = 'black') +
  ggplot2::geom_point(x = data.table::last(emp_flock_track$flock_lon),
                      y = data.table::last(emp_flock_track$flock_lat), 
                      size = 6, 
                      color = 'black') +
  ggplot2::theme(legend.title = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 legend.text = ggplot2::element_text(size = 15, color = 'black'),
                 legend.position = c(0.28, 0.908),
                 legend.key.size = ggplot2::unit(0.75, 'cm'),
                 legend.key.width = ggplot2::unit(1.3, 'cm'),
                 axis.text = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(size = 18),
                 plot.title = ggplot2::element_text(hjust = 0.5, size = 20, face = "bold"),
                 legend.box = "vertical",
                 legend.title.align = 0.5,
                 legend.background = ggplot2::element_rect(fill = "grey100",
                                                           size = 0.5, 
                                                           linetype = "solid",
                                                           colour = "grey20"),
                 legend.direction = "horizontal",
  ) 

#lpl

################################################################
## Column B - Histograms

pred_turns <- read.csv('../Data/empirical/ind_turns_pred.csv')

# helper plotting functions
fun.avvel <- function(x) 10 * x

get_density <- function(x, y, ...) {
  dens <- MASS::kde2d(x, y, ...)
  ix <- findInterval(x, dens$x)
  iy <- findInterval(y, dens$y)
  ii <- cbind(ix, iy)
  return(dens$z[ii])
}

buildPoly <- function(xr, yr, slope = 1, intercept = 0, above = TRUE){
  
  #Assumes ggplot default of expand = c(0.05,0)
  xrTru <- xr + 0.05 * diff(xr) * c(-1, 1)
  yrTru <- yr + 0.05 * diff(yr) * c(-1, 1)
  
  #Find where the line crosses the plot edges
  yCross <- (yrTru - intercept) / slope
  xCross <- (slope * xrTru) + intercept
  
  #Build polygon by cases
  if (above & (slope >= 0)){
    rs <- data.frame(x = -Inf, y = Inf)
    if (xCross[1] < yrTru[1]){
      rs <- rbind(rs, c(-Inf, -Inf), c(yCross[1], -Inf))
    }
    else{
      rs <- rbind(rs, c(-Inf, xCross[1]))
    }
    if (xCross[2] < yrTru[2]){
      rs <- rbind(rs, c(Inf, xCross[2]), c(Inf, Inf))
    }
    else{
      rs <- rbind(rs, c(yCross[2], Inf))
    }
  }
  if (!above & (slope >= 0)){
    rs <- data.frame(x = Inf, y = -Inf)
    if (xCross[1] > yrTru[1]){
      rs <- rbind(rs, c(-Inf, -Inf), c(-Inf, xCross[1]))
    }
    else{
      rs <- rbind(rs, c(yCross[1], -Inf))
    }
    if (xCross[2] > yrTru[2]){
      rs <- rbind(rs, c(yCross[2], Inf), c(Inf, Inf))
    }
    else{
      rs <- rbind(rs, c(Inf, xCross[2]))
    }
  }
  if (above & (slope < 0)){
    rs <- data.frame(x = Inf, y = Inf)
    if (xCross[1] < yrTru[2]){
      rs <- rbind(rs, c(-Inf, Inf), c(-Inf, xCross[1]))
    }
    else{
      rs <- rbind(rs, c(yCross[2], Inf))
    }
    if (xCross[2] < yrTru[1]){
      rs <- rbind(rs, c(yCross[1], -Inf), c(Inf, -Inf))
    }
    else{
      rs <- rbind(rs, c(Inf, xCross[2]))
    }
  }
  if (!above & (slope < 0)){
    rs <- data.frame(x = -Inf, y = -Inf)
    if (xCross[1] > yrTru[2]){
      rs <- rbind(rs, c(-Inf, Inf), c(yCross[2], Inf))
    }
    else{
      rs <- rbind(rs, c(-Inf, xCross[1]))
    }
    if (xCross[2] > yrTru[1]){
      rs <- rbind(rs, c(Inf, xCross[2]), c(Inf, -Inf))
    }
    else{
      rs <- rbind(rs, c(yCross[1], -Inf))
    }
  }
  
  return(rs)
}

pred_turns$density <- get_density(pred_turns$dur, abs(pred_turns$angle), n = 100)
datPoly <- buildPoly(range(pred_turns$dur, na.rm = TRUE), 
                     range(abs(pred_turns$angle), na.rm = TRUE),
                     slope = 10,
                     intercept = 0,
                     above = FALSE)

angvel <- ggplot2::ggplot(pred_turns, 
                          ggplot2::aes(x = dur, y = abs(angle), color = density))+
  ggplot2::scale_color_gradient2(low = "yellow",
                                 mid = "dodgerblue3",
                                 high = "red",
                                 midpoint = 0,
                                 na.value = "black",
                                 guide = "colourbar" ) +
  ggplot2::geom_point() +
  ggplot2::geom_polygon(data = datPoly,
                        ggplot2::aes(x = x, y = y), 
                        alpha = 0.2, 
                        fill = "grey20",
                        inherit.aes = FALSE)+
  ggplot2::stat_function(fun = fun.avvel, 
                         color = 'black', 
                         size = 1.3) +   
  ggplot2::geom_text( x = 0.5, 
                      y = 350, 
                      label = "Turn", 
                      hjust = "left",
                      family = 'Palatino Linotype', 
                      size = 6, 
                      color = 'black') +
  # ggplot2::geom_text( x = 9.0, y = 10, 
  #                     label = "", 
  #                     hjust = "center",family = 'Palatino Linotype', 
  #                     size = 6, color = 'black') +
  ggplot2::ylab("Turning angle (deg)") +
  ggplot2::xlab("Turn duration (s)") +
  ggplot2::theme_bw()+
  ggplot2::theme(text = ggplot2::element_text(family = 'Palatino Linotype'),
                 legend.position = 'none',
                 axis.text.y = ggplot2::element_text(size = 16,  margin = ggplot2::margin(l = 10, r = 2)),
                 axis.text.x = ggplot2::element_text(size = 16, margin = ggplot2::margin(b = 5, t = 2)),
                 axis.title = ggplot2::element_text(size = 18))


ang <- ggplot2::ggplot(pred_turns)+ 
  ggplot2::geom_histogram(ggplot2::aes(x = abs(angle)),
                          alpha = 0.8,
                          bins = 50, 
                          color = 'black', 
                          fill = 'dodgerblue3') +
  ggplot2::geom_vline(xintercept = median(abs(pred_turns$angle)),
                      size = 1.5) +
  ggplot2::theme_bw() +
  ggplot2::labs(x = 'Turning angle (deg)',
                y = 'Frequency', 
                title = 'Empirical data') +
  ggplot2::theme(legend.title = ggplot2::element_text(size = 16, face = "bold"),
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text.y = ggplot2::element_text(size = 16,  margin = ggplot2::margin(l = 10, r = 2)),
                 axis.text.x = ggplot2::element_text(size = 16 ,margin = ggplot2::margin(b = 5, t = 2)),
                 axis.title = ggplot2::element_text(size = 18, margin = ggplot2::margin(t = 500, b = 500)),
                 plot.title = ggplot2::element_text(size = 20, face = "bold", hjust = 0.5))

dur <- ggplot2::ggplot(pred_turns)+
  ggplot2::geom_histogram(ggplot2::aes(x = dur),
                          alpha = 0.8, 
                          bins = 50,
                          color = 'black', 
                          fill = 'dodgerblue3') +
  ggplot2::theme_bw() +
  ggplot2::geom_vline(xintercept = median(abs(pred_turns$dur)),
                      size = 1.5) +
  ggplot2::labs(x = 'Turn duration (s)',
                y = 'Frequency') +
  ggplot2::theme(text = ggplot2::element_text(family = 'Palatino Linotype'),
                 legend.position = 'none',
                 axis.text.y = ggplot2::element_text(size = 16,  margin = ggplot2::margin(l = 10, r = 2)),
                 axis.text.x = ggplot2::element_text(size = 16, margin = ggplot2::margin(b = 5, t = 2)),
                 axis.title = ggplot2::element_text(size = 18),
                 plot.title = ggplot2::element_text(size = 20, face = "bold")) 

hists <- cowplot::plot_grid(ang, dur, angvel, 
                            nrow = 3,
                            ncol = 1, 
                            labels = c("B1", "B2", "B3"),
                            label_size = 16, 
                            label_x = c(-0.02, -0.02, -0.02))


################################################################
## Column C - Simulated track

sim_ind <- read.csv('../Data/simulated/flock9_pigeon3_i1815.csv')
sim_fl <- read.csv('../Data/simulated/flock9_track_i1815.csv')


fl_tracks <- ggplot2::ggplot(sim_fl)+
  ggplot2::geom_point(ggplot2::aes(x = sim_ind$posx, y = sim_ind$posy),
                      color = 'grey40', 
                      size = 3,
                      inherit.aes = FALSE) +
  ggplot2::geom_point(ggplot2::aes(fcX_real, fcY_real, color = tcolor),
                      size = 6) +
  ggplot2::scale_color_manual(breaks = c( "nt", "r", "l"),
                              labels = c( "Straight", 'Right turn', "Left turn"),
                              values = c("grey85", "darkred", "dodgerblue3"), name = 'Motion')+
  ggplot2::geom_segment(ggplot2::aes(x = 250, xend = 300, y = 350,  yend = 350, linetype = 'solid'),
                        inherit.aes = FALSE) + 
  ggplot2::geom_segment(ggplot2::aes(x = 250, xend = 250, y = 340,  yend = 360, linetype = 'solid'),
                        inherit.aes = FALSE) + 
  ggplot2::geom_segment(ggplot2::aes(x = 300, xend = 300, y = 340,  yend = 360, linetype = 'solid'),
                        inherit.aes = FALSE) + 
  ggplot2::geom_text(ggplot2::aes(x =  275, y = 350, label = '50 m'), 
                     vjust = -0.5, 
                     size = 5,
                     family = 'Palatino Linotype') +
  ggplot2::labs(x = 'X',
                y = 'Y',
                title = 'Simulated track in HoPE') +
  ggplot2::theme_bw()+
  ggplot2::geom_curve(data = data.frame(y = 51.3758),
                      ggplot2::aes(x = 245, y = 150, xend = 165, yend = 140),
                      arrow = ggplot2::arrow(length = ggplot2::unit(4.2, "mm")), 
                      lwd = 2,
                      curvature = -.3,
                      color = "black") +
  ggplot2::geom_text( x = 250, 
                      y = 150, 
                      label = "Collective turn",
                      hjust = "left",
                      family = 'Palatino Linotype',
                      size = 6) +
  ggplot2::xlim(c(100,350)) +
  ggplot2::ylim(c(50,450)) +
  ggplot2::guides(linetype = FALSE) +
  ggplot2::geom_curve(data = data.frame(y = 51.3751),
                      ggplot2::aes(x = 150, y = 225, xend = 200, yend = 200),
                      arrow = ggplot2::arrow(length = ggplot2::unit(4.2, "mm")),
                      lwd = 2, 
                      curvature = .3,
                      color = "black") +
  ggplot2::geom_text(x = 150,
                     y = 240, 
                     label = "Initiator\nsplitting", 
                     hjust = "middle", 
                     family = 'Palatino Linotype',
                     size = 6) +
  ggplot2::geom_text(x = 326, 
                     y = 320, 
                     label = "Start", 
                     hjust = "center",
                     family = 'Palatino Linotype',
                     size = 6) +
  ggplot2::geom_text(x = 302,
                     y = 113,
                     label = "End",
                     hjust = "center",
                     family = 'Palatino Linotype', 
                     size = 6) +
  
  ggplot2::geom_point(x = sim_fl$fcX_real[1],
                      y = sim_fl$fcY_real[1],
                      size = 6, 
                      color = 'black') +
  ggplot2::geom_point(x = data.table::last(sim_fl$fcX_real), 
                      y = data.table::last(sim_fl$fcY_real),
                      size = 6, 
                      color = 'black') +
  ggplot2::theme(legend.title = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 legend.text = ggplot2::element_text(size = 14, color = 'black'),
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 legend.position = c(0.85, 0.9),
                 axis.text = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(size = 16),
                 plot.title = ggplot2::element_text(hjust = 0.5, size = 20, face = "bold"),
                 legend.box = "vertical",
                 legend.title.align = 0.5,
                 legend.background = ggplot2::element_rect(fill = "grey100",
                                                           size = 0.5, 
                                                           linetype = "solid",
                                                           colour = "grey20"),
                 legend.direction= "vertical"
  )

#fl_tracks

################################################################
## Combine to final plot
comb_tracks <- cowplot::plot_grid(lpl, hists, fl_tracks, 
                                  nrow = 1,
                                  ncol = 3, 
                                  labels = c("A", " ", "C"),
                                  label_size = 16,
                                  rel_widths = c(0.4, 0.25, 0.4))

# comb_tracks

# # Uncomment to save plot
# plot_path <- '../Results/Figure2.png' # change path
# ggplot2::ggsave(
#   plot = comb_tracks,
#   filename = plot_path,
#   width = 15,
#   height = 10,
#   dpi = 400
# )


## Figure 2. Horizontal stackplot: effect of maneuver characteristics on relative frequency of collective turns and splits

sim_df<- read.csv('../Data/simulated/escape_outcomes.csv')

##################################################################
# Stats:

# Angular velocity
spl_angv <- sim_df[sim_df$outcome == 'split', 'ang_vel']
turn_angv <- sim_df[sim_df$outcome == 'turn', 'ang_vel']
ks.test(spl_angv, turn_angv)

# Centrality
spl_centr <- sim_df[sim_df$outcome == 'split', 'centr']
turn_centr <- sim_df[sim_df$outcome == 'turn', 'centr']
ks.test(spl_centr, turn_centr)

# Escape direction
chisq.test(y = sim_df$outcome, x = sim_df$conflict)


##################################################################
# Plot:
turns_sum <- read.csv('../Data/simulated/turn_chars_summary.csv')

# plots stats (as categorical)
angvel_groups <- c('low', 'high');
dg_breaks <- c(0, median(abs(sim_df$ang_vel)), max(abs(sim_df$ang_vel)));
sim_df$group_angv <- cut(abs(sim_df$ang_vel), breaks = dg_breaks, labels = angvel_groups) 
print('Angular velocity low vs high:')
chisq.test(y = sim_df$outcome, x = sim_df$group_angv)


groups <- c('center', 'edge');
dg_breaks <- c(0, median(sim_df$centr, na.rm = TRUE), max(sim_df$centr, na.rm = TRUE));
sim_df$group_centr <- cut(sim_df$centr, breaks = dg_breaks, labels = groups) ;
print('Position in the flock center vs edge:')
chisq.test(y = sim_df$outcome, x = sim_df$group_centr)

print('Escape direction inwards vs outwards:')
chisq.test(y = sim_df$outcome, x = sim_df$conflict)

# horizontal stackplot

# #Uncomment to use font as in paper
# extrafont::font_import()
# extrafont::loadfonts(device = "win")

sing_lab <- data.frame(var = c('ang_vel','centrality', 'esc_dir'), l = c("***", "***", "ns"), stringsAsFactors = F)
var.labs <-  c("ang_vel" = "Angular \nvelocity", "centrality" = "Centrality", "esc_dir" = "Escape \ndirection")

stack_plot <- ggplot2::ggplot(data = turns_sum, ggplot2::aes(x = group, y = perc, linetype = outcome, fill = outcome)) +
  ggplot2::geom_bar(color = 'black',alpha = 0.2, stat="identity", size = 1.5, width = 0.9) +
  ggplot2::theme_bw()   +
  ggplot2::geom_label(ggplot2::aes( label = paste0(round(perc, 1), '%')),
                      fill = 'white', size = 5, 
                      show.legend = FALSE,  family = 'Palatino Linotype',
                      position = ggplot2::position_stack(vjust = 0.5)) +
  ggplot2::labs(x = '', y = '', linetype = 'Collective pattern:',fill = 'Collective pattern:',
                title = "" )+
  ggplot2::geom_text(data = sing_lab, ggplot2::aes(label = l), family = 'Palatino Linotype', x = 1.5, y = -2.8, inherit.aes = FALSE, size = 5)+
  ggplot2::scale_x_discrete(
    labels=c("in" = "Inwards", "out" = "Outwards",
             "edge" = "Edge", "center" = "Center",
             "high" = "High", "low"= "Low"), position = 'bottom')+
  ggplot2::coord_flip() +
  ggplot2::facet_grid(var ~ . ,scales = "free",
                      labeller = ggplot2::labeller(
                        var = var.labs), switch = 'y') +
  ggplot2::theme(
    text = ggplot2::element_text(family = 'Palatino Linotype'),
    legend.title = ggplot2::element_text(size = 14),
    legend.position = 'bottom',
    legend.text = ggplot2::element_text(size = 16),
    axis.text = ggplot2::element_text(size = 14),
    axis.title = ggplot2::element_blank(),
    axis.text.x =  ggplot2::element_blank(),
    plot.title = ggplot2::element_text(size = 14, face = "bold"),
    plot.subtitle  = ggplot2::element_text(size = 14, face = "italic"),
    strip.text.y = ggplot2::element_text(size = 14, face = "bold"),
    strip.placement = "outside",
    strip.background = ggplot2::element_rect(fill = 'white'),
    plot.tag.position = c(.1, .82),
    plot.tag = ggplot2::element_text(size = 14, face = "bold"),
    panel.grid.major = ggplot2::element_blank(), 
    panel.grid.minor = ggplot2::element_blank())+
  ggplot2::scale_linetype_discrete(breaks = c('turn', 'split'),
                                   labels = c('Collective turn', 'Split'))+
  ggplot2::scale_fill_manual(breaks = c('turn', 'split'),
                             labels = c('Collective turn', 'Split'),
                             values = c('dodgerblue3', 'darkred'))

stack_plot

#######################################
# # Uncomment to save plot
# plot_path <- 'Figure2.png' # change path
# ggplot2::ggsave(
#   plot = stack_plot, 
#   filename = plot_path,
#   width = 11,
#   height = 5,
#   dpi = 600
# )

## Supplmentary Figure. Escape outcome in simulations across all combinations
## of initiators characteristics

sim_data <- read.csv("../Data/simulated/escape_outcomes.csv" )

###############################
## Prepare data

angvel_groups <- c('low', 'high');
dg_breaks <- c(0, median(abs(sim_data$ang_vel)), max(abs(sim_data$ang_vel)));
sim_data$group_angvel <- cut(abs(sim_data$ang_vel), breaks = dg_breaks, labels = angvel_groups) 

groups <- c('center', 'edge');
dg_breaks <- c(0, median(sim_data$centr, na.rm = TRUE), max(sim_data$centr, na.rm = TRUE));

sim_data$group_cent <- cut(sim_data$centr, breaks = dg_breaks, labels = groups) ;

toplot <- plyr::count(sim_data, c('outcome', 'group_cent', 'group_angvel', 'conflict'));
totcount <- plyr::count(sim_data, c('group_cent', 'group_angvel', 'conflict'));

for (i in 1:length(toplot$outcome))
{
  toplot$perc[i] <- (100 * toplot$freq[i] / totcount[
    totcount$group_cent == toplot$group_cent[i] &
      totcount$group_angvel == toplot$group_angvel[i] &
      totcount$conflict == toplot$conflict[i] , 'freq']);
}

toplot$group <- paste(toplot$group_cent, toplot$group_angvel, toplot$conflict, sep = '_')


###############################
## Prepare data

sing_lab <- data.frame(var = c('names'), l = c(""), stringsAsFactors = F)
var.labs <-  c("names" = "Centrality - Angular velocity - Escape direction")

ggplot2::ggplot(data = toplot, 
                ggplot2::aes(x = group, y = perc, linetype = outcome, fill = outcome)) +
  ggplot2::geom_bar(color = 'black',
                    alpha = 0.2, 
                    stat = "identity", 
                    size = 1.5, 
                    width = 0.9) +
  ggplot2::theme_bw()   +
  ggplot2::geom_label(ggplot2::aes( label = paste0(round(perc, 1), '%')),
                      fill = 'white',
                      size = 5, 
                      show.legend = FALSE, 
                      family = 'Palatino Linotype',
                      position = ggplot2::position_stack(vjust = 0.5)) +
  ggplot2::labs(x = '',
                y = '', 
                linetype = 'Collective pattern:',
                fill = 'Collective pattern:',
                title = "" )+
  ggplot2::geom_text(data = sing_lab, 
                     ggplot2::aes(label = l), 
                     family = 'Palatino Linotype', 
                     x = 1.5, 
                     y = -2.8, 
                     inherit.aes = FALSE,
                     size = 5)+
  ggplot2::scale_x_discrete(
    labels = c(
      "edge_low_1" = "Edge - Low - Outwards", "edge_low_0" = "Edge - Low - Inwards",
      "center_low_0" = "Center - Low - Inwards", "center_low_1" = "Center - Low - Inwards" ,
      "edge_high_0" = "Edge - High - Inwards",      "edge_high_1" = "Edge - High - Outwards",
      "center_high_0"= "Center - High - Inwards",       "center_high_1"= "Center - High - Outwards"),
    position = 'bottom')+
  ggplot2::coord_flip() +
  ggplot2::facet_wrap(var ~ ., 
                      scales = "free",
                      labeller = ggplot2::labeller(var = var.labs), switch = 'y') +
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
    panel.grid.minor = ggplot2::element_blank()
  )+
  ggplot2::scale_linetype_discrete(breaks = c('turn', 'split'),
                                   labels = c('Collective turn', 'Split'))+
  ggplot2::scale_fill_manual(breaks = c('turn', 'split'),
                             labels = c('Collective turn', 'Split'),
                             values = c('dodgerblue3', 'darkred'))



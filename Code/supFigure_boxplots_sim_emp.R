## Figure 3. Boxplots comparing angular velocity distributions of splits and collective turns in simulated and empirical data

###############################################################
## Boxplots
###############################################################

# #Uncomment to use font as in paper
# extrafont::font_import()
# extrafont::loadfonts(device = "win")

emp_data <- read.csv("../Data/empirical/ind_turns_outcome.csv" )
sim_data <- read.csv('../Data/simulated/escape_outcomes.csv')

# Standanrdize centrality
# Empirical data
emp_data$centr <- emp_data$dist2cent
emp_data$centr <- emp_data$dist2cent
big_mean <- mean(emp_data[emp_data$small.big == 'b', 'dist2cent'])
small_mean <- mean(emp_data[emp_data$small.big == 's', 'dist2cent'])

emp_data[emp_data$small.big == 'b', 'centr'] <- emp_data[emp_data$small.big == 'b', 'dist2cent']/big_mean
emp_data[emp_data$small.big == 's', 'centr'] <- emp_data[emp_data$small.big == 's', 'dist2cent']/small_mean

# Simulated data
sim_data$centr_fs <- sim_data$centr
big_mean <- mean(sim_data[sim_data$fl_size == 'b', 'centr'])
small_mean <- mean(sim_data[sim_data$fl_size == 's', 'centr'])

sim_data[sim_data$fl_size == 's', 'centr_fs'] <- sim_data[sim_data$fl_size == 's','centr']/small_mean
sim_data[sim_data$fl_size == 'b', 'centr_fs'] <-  sim_data[sim_data$fl_size == 'b','centr']/big_mean

###############################################################
## Empirical data

angv <- subset(emp_data, 
               ang_vel < quantile(emp_data$ang_vel, 0.9) # exclude top 5% for better visual
)

angvel <- ggplot2::ggplot(angv,
                          ggplot2::aes(x = factor(init,
                                                  levels = c('turn','split'),
                                                  ordered = TRUE), 
                                       y = pracma::rad2deg(ang_vel),
                                       fill = init))+ 
  ggplot2::geom_boxplot(size = 1, 
                        alpha = 0.1,
                        width = 0.8) +
  ggplot2::theme_bw() +
  ggplot2::scale_fill_manual(breaks = c('split', 'turn'),
                             labels = c('Split', 'Collective turn'),
                             values = c('darkred', 'dodgerblue3')) +
  ggplot2::labs(x = '',
                y = 'Angular velocity (deg/s)\n', 
                title = 'Empirical data') +
  ggplot2::theme(legend.position = 'none',
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title.y = ggplot2::element_text(size = 18, face = "bold"),
                 axis.title.x = ggplot2::element_blank(),
                 plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold")) +
  ggplot2::scale_x_discrete(labels = c("split" = "", 
                                       "turn" = "")) 

#angvel

dcent <- subset(emp_data, 
                dist2cent < quantile(emp_data$dist2cent, 0.9)
)

centr <- ggplot2::ggplot(dcent, 
                         ggplot2::aes(x = factor(init,
                                                 levels = c('turn','split'),
                                                 ordered = TRUE),
                                      y = centr,
                                      fill = init)) + 
  ggplot2::geom_boxplot(size = 1,
                        alpha = 0.1,
                        width = 0.8) +
  ggplot2::theme_bw() +
  #ggsignif::geom_signif(comparisons = list(c("split", "turn")), map_signif_level=TRUE) +
  ggplot2::scale_fill_manual(breaks = c('turn', 'split'),
                             labels = c('Collective turn', 'Split'),
                             values = c('dodgerblue3', 'darkred')) +
  ggplot2::labs(x = '', 
                y = 'Centrality \n', 
                title = '') +
  ggplot2::theme(legend.position = 'none',
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title = ggplot2::element_text(size = 18, face = "bold"),
                 plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold")) +
  ggplot2::scale_x_discrete(labels = c("turn" = "Collective \nturn", 
                                       "split" = "Splitting \nturn")) 


###############################################################
## Simulated data


centr_sim <- subset(sim_data, 
                    centr_fs < quantile(sim_data$centr_fs, 0.9))

sim_centr <- ggplot2::ggplot(centr_sim, 
                ggplot2::aes(x = factor(outcome,
                                        levels = c('turn','split'),
                                        ordered = TRUE),
                             
                             y = centr_fs, fill = outcome )) +
  ggplot2::geom_boxplot(size = 1, alpha = 0.1, width = 0.8) +
  ggplot2::labs(x = '', y = 'Centrality', title = '', fill = NA) +
  ggplot2::scale_x_discrete(labels= c("split" = "Split", "turn" = "Collective \nturn"))+
  ggplot2::scale_fill_manual(breaks = c('turn', 'split'),
                             labels = c('Collective turn', 'Split'),
                             values = c('dodgerblue3', 'darkred')) +
  
  ggplot2::theme_bw()+
  ggplot2::theme(legend.title = ggplot2::element_blank(),
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 legend.position = 'none',
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title.x = ggplot2::element_text(size = 16, face = "bold"),
                 axis.title.y = ggplot2::element_blank(),
                 plot.title = ggplot2::element_text(hjust = 0.5, size = 18, face = "bold"))


ang_sim <- subset(sim_data, abs(ang_vel) < quantile(abs(sim_data$ang_vel), 0.9))# quantile(centr, 0.9)

sim_angvel <- ggplot2::ggplot(ang_sim, ggplot2::aes(x = factor(outcome,
                                                             levels = c('turn','split'),
                                                             ordered = TRUE),
                                                  y = abs(ang_vel), 
                                                  fill = outcome )) +
  
  ggplot2::geom_boxplot(size = 1, alpha = 0.1, width = 0.8) +
  ggplot2::labs(x = '', y = 'Angular velocity\nof initiator (deg/s)', title = 'Simulated data', 
                fill = NA) +
  ggplot2::scale_x_discrete(labels= c("split" = "", "turn" = ""))+
  ggplot2::scale_fill_manual(breaks = c('turn', 'split'),
                             labels = c('Collective turn', 'Split'),
                             values = c('dodgerblue3', 'darkred')) +
  
  ggplot2::theme_bw()+
  ggplot2::theme(legend.title = ggplot2::element_blank(),
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 legend.position = 'none',
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title = ggplot2::element_blank(),
                 plot.title = ggplot2::element_text(hjust = 0.5, size = 18, face = "bold"))


all_boxes <- cowplot::plot_grid(angvel,  sim_angvel, centr, sim_centr,
                               nrow = 2,
                               ncol = 2, 
                               labels = c("A", "B"), 
                               label_size = 18)
# all_boxes

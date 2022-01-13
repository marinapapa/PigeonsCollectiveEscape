## Supplmentary Figure. Density of splits and collective turns across
## angular velocity and centrality in empirical and simulated data

## 1. Empirical

emp_data <- read.csv("../Data/empirical/ind_turns_outcome.csv" )

# Standanrdize centrality
# Empirical data
emp_data$centr <- emp_data$dist2cent
emp_data$centr <- emp_data$dist2cent
big_mean <- mean(emp_data[emp_data$small.big == 'b', 'dist2cent'])
small_mean <- mean(emp_data[emp_data$small.big == 's', 'dist2cent'])

emp_data[emp_data$small.big == 'b', 'centr'] <- emp_data[emp_data$small.big == 'b', 'dist2cent']/big_mean
emp_data[emp_data$small.big == 's', 'centr'] <- emp_data[emp_data$small.big == 's', 'dist2cent']/small_mean

# Plot
data_clean <- subset(emp_data, 
                     centr < quantile(emp_data$centr, 0.9) &
                     ang_vel < quantile(emp_data$ang_vel, 0.9)
)

splits <- data_clean[data_clean$init == 'split',]
turns <- data_clean[data_clean$init == 'turn',]

p_se <- ggplot2::ggplot(splits,
                        ggplot2::aes(x = pracma::rad2deg(ang_vel), y = centr)) +
  ggplot2::stat_density_2d(ggplot2::aes(fill = ..density..), 
                           geom = "raster",
                           contour = FALSE) +
  ggplot2::stat_density2d(color = 'black') +
  ggplot2::scale_fill_distiller(palette = "Spectral",
                                direction = 1) +
  ggplot2::labs(y = 'Centrality\n', 
                x = 'Angular velocity (deg/s)',
                title = 'Empirical - Splits') +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = 'none',
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title = ggplot2::element_text(size = 16, face = "bold"),
                 plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold"))

p_te <- ggplot2::ggplot(turns, 
                        ggplot2::aes(x = pracma::rad2deg(ang_vel), y = centr)) +
  ggplot2::stat_density_2d(ggplot2::aes(fill = ..density..),
                           geom = "raster",
                           contour = FALSE) +
  ggplot2::stat_density2d(color = 'black') +
  ggplot2::scale_fill_distiller(palette = "Spectral",
                                direction = 1) +
  ggplot2::labs(y = 'Centrality\n',
                x = 'Angular velocity (deg/s)',
                title = 'Empirical - Collective turns') +
  ggplot2::theme_bw() +
  ggplot2::theme(
    legend.position = 'none',
    text = ggplot2::element_text(family = 'Palatino Linotype'),
    axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
    axis.title.x = ggplot2::element_text(size = 16, face = "bold"),
    axis.title.y = ggplot2::element_blank(),
    plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold"))

#cowplot::plot_grid(p_s, p_t)

## 2. Simulated
sim_data <- read.csv("../Data/simulated/escape_outcomes.csv" )

# standardize centrality
sim_data$centr_fs <- sim_data$centr
big_mean <- mean(sim_data[sim_data$fl_size == 'b', 'centr'])
small_mean <- mean(sim_data[sim_data$fl_size == 's', 'centr'])

sim_data[sim_data$fl_size == 's', 'centr_fs'] <- sim_data[sim_data$fl_size == 's','centr']/small_mean
sim_data[sim_data$fl_size == 'b', 'centr_fs'] <-  sim_data[sim_data$fl_size == 'b','centr']/big_mean

# Plot
sim_clean <- subset(sim_data, 
                    centr_fs < quantile(sim_data$centr_fs, 0.9) &
                      abs(ang_vel) < quantile(abs(sim_data$ang_vel), 0.9)
)

split_sim <- sim_clean[sim_clean$outcome == 'split', ]
turns_sim <- sim_clean[sim_clean$outcome == 'turn', ]

p_s <- ggplot2::ggplot(split_sim, ggplot2::aes(x = abs(ang_vel), y = centr_fs)) +
  ggplot2::stat_density_2d(ggplot2::aes(fill = ..density..), 
                           geom = "raster",
                           contour = FALSE) +
  ggplot2::stat_density2d(color = 'black') +
  ggplot2::scale_fill_distiller(palette = "Spectral", 
                                direction  =1) +
  ggplot2::labs(y = 'Centrality\n',
                x = 'Angular velocity (deg/s)', 
                title = 'Simulated - Splits') +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = 'none',
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title.y = ggplot2::element_text(size = 16, face = "bold"),
                 axis.title.x = ggplot2::element_blank(),
                 plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold"))
#p_s
p_t <- ggplot2::ggplot(turns_sim, ggplot2::aes(x = abs(ang_vel), y = centr_fs)) +
  ggplot2::stat_density_2d(ggplot2::aes(fill = ..density..), 
                           geom = "raster",
                           contour = FALSE) +
  ggplot2::stat_density2d(color = 'black') +
  ggplot2::scale_fill_distiller(palette = "Spectral", direction = 1) +
  ggplot2::labs(y = 'Centrality\n', 
                x = 'Angular velocity (deg/s)',
                title = 'Simulated - Collective turns') +
  ggplot2::theme_bw()+
  ggplot2::theme(legend.position = 'none',
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 #axis.title.y = ggplot2::element_text(size = 16, face = "bold"),
                 axis.title = ggplot2::element_blank(),             
                 plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold"))
#p_t

for_leg <- cowplot::get_legend(ggplot2::ggplot(turns, 
                                   ggplot2::aes(x = pracma::rad2deg(ang_vel), y = centr)) +
  ggplot2::stat_density_2d(ggplot2::aes(fill = ..density..),
                           geom = "raster",
                           contour = FALSE) +
  ggplot2::scale_fill_distiller(palette = "Spectral",
                                direction = 1) +
  ggplot2::labs(fill = 'Density of turns types') +
  ggplot2::theme(
    legend.position = 'top',
    text = ggplot2::element_text(family = 'Palatino Linotype'),
    legend.text = ggplot2::element_text(size = 12),
    legend.title = ggplot2::element_text(size = 16, face = "bold"),
    legend.key.width = ggplot2::unit(1.5, 'cm')
))
  
cowplot::plot_grid(for_leg, cowplot::plot_grid(p_s, p_t), cowplot::plot_grid(p_se, p_te), 
                   nrow = 3,
                   rel_heights = c(0.2, 1.1, 1.1))


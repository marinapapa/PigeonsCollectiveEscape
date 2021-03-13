## Figure 3. Boxplots comparing angular velocity distributions of splits and collective turns in simulated and empirical data

ang_v_df_sim <- read.csv('../Data/simulated/ang_vel_turns_sim.csv')
ang_v_df_emp <- read.csv('../Data/empirical/ang_vel_turns_emp.csv')

#######################################
## Boxplots

# #Uncomment to use font as in paper
# extrafont::font_import()
# extrafont::loadfonts(device = "win")

angvel_sim <- ggplot2::ggplot(ang_v_df_sim, ggplot2::aes(x = factor(outcome,
                                                                levels = c('turn','split'),ordered = TRUE), y = abs(ang_vel), fill = outcome ))+#, color = outcome))+

  ggplot2::geom_boxplot(size = 1, alpha = 0.1, width = 0.8) +
  ggplot2::labs(x = '', y = 'Angular velocity\nof initiator (deg/s)', title = 'Simulated data', fill = NA) +
  ggsignif::geom_signif(comparisons = list(c("turn", "split")), map_signif_level = TRUE) +
  ggplot2::scale_x_discrete(labels= c("split" = "Split", "turn" = "Collective \nturn"))+
  ggplot2::scale_fill_manual(breaks = c('turn', 'split'),
                             labels = c('Collective turn', 'Split'),
                             values = c('dodgerblue3', 'darkred')) +

  ggplot2::theme_bw()+
  ggplot2::theme(legend.title = ggplot2::element_blank(),
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 legend.position = 'none',
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title = ggplot2::element_text(size = 16, face = "bold"),
                 plot.title = ggplot2::element_text(hjust = 0.5, size = 18, face = "bold"))


angvel_emp_init <- ggplot2::ggplot(ang_v_df_emp, ggplot2::aes(x = split_val, y = ang_vel, fill = split_val))+ # pracma::rad2deg(abs(ang_vel)))) +
  ggplot2::geom_boxplot(size = 1, alpha = 0.1, width = 0.8) +
  ggplot2::theme_bw() +
  ggsignif::geom_signif(comparisons = list(c("TRUE", "FALSE")), map_signif_level=TRUE) +
  ggplot2::scale_fill_manual(breaks = c('TRUE', 'FALSE'),
                             labels = c('Split', 'Collective turn'),
                             values = c('darkred', 'dodgerblue3')) +
  ggplot2::labs(x = '', y = 'Angular velocity\nof flock members (deg/s)', title = 'Empirical data') +
  ggplot2::theme(
    legend.position = 'none',
    text = ggplot2::element_text(family = 'Palatino Linotype'),
    axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
    axis.title = ggplot2::element_text(size = 18, face = "bold"),
    plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold")) +
  ggplot2::scale_x_discrete(labels=c("TRUE" = "Split", "FALSE" = "Collective \nturn")) 


ang_vels <- cowplot::plot_grid(angvel_sim, angvel_emp_init, nrow = 1, ncol = 2, labels = c("A", "B"), label_size = 20)

ang_vels

# # Uncomment to save plot
# plot_path <- 'Figure3.png' # change path
# ggplot2::ggsave(
#   plot = ang_vels, 
#   filename = plot_path,
#   width = 8.9,
#   height = 9,
#   dpi = 600
# )

#######################################
## Stats

colts <- ang_v_df_emp[ang_v_df_emp$split_val == FALSE, 'ang_vel']
splts <- ang_v_df_emp[ang_v_df_emp$split_val == TRUE, 'ang_vel']
ks.test(colts, splts)

colts <- ang_v_df_sim[ang_v_df_sim$outcome == 'turn', 'ang_vel']
splts <- ang_v_df_sim[ang_v_df_sim$outcome == 'split', 'ang_vel']
ks.test(colts, splts)



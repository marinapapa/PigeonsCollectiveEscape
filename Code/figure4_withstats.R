## Figure 4. Boxplots comparing angular velocity and centrality distributions 
###  of splits and collective turns in empirical data
## Statistics: GLMMs for the effect of angular velocity and 
###  centrality on turning type (split or collective turn)

emp_data <- read.csv("../Data/empirical/ind_turns_outcome.csv" )

emp_data$centr <- emp_data$dist2cent
emp_data$centr <- emp_data$dist2cent
big_mean <- mean(emp_data[emp_data$small.big == 'b', 'dist2cent'])
small_mean <- mean(emp_data[emp_data$small.big == 's', 'dist2cent'])

emp_data[emp_data$small.big == 'b', 'centr'] <- emp_data[emp_data$small.big == 'b', 'dist2cent']/big_mean
emp_data[emp_data$small.big == 's', 'centr'] <- emp_data[emp_data$small.big == 's', 'dist2cent']/small_mean


##############################################################################
## Boxplots
##############################################################################

# #Uncomment to use font as in paper
# extrafont::font_import()
# extrafont::loadfonts(device = "win")

angv <- subset(emp_data, 
               ang_vel < quantile(emp_data$ang_vel, 0.95) # exclude top 5% for better visual
               )

angvel <- ggplot2::ggplot(angv, ggplot2::aes(x = factor(init,
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
                title = 'Angular velocity') +
  ggplot2::ylim(c(0,quantile(pracma::rad2deg(emp_data$ang_vel), 0.95)))+
  ggplot2::theme(legend.position = 'none',
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title = ggplot2::element_text(size = 18, face = "bold"),
                 plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold")) +
  ggplot2::scale_x_discrete(labels = c("split" = "Splitting \nturn", 
                                       "turn" = "Collective \nturn")) 

#angvel

dcent <- subset(emp_data, 
                dist2cent < quantile(emp_data$dist2cent, 0.90)
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
  ggplot2::scale_fill_manual(breaks = c('turn', 'split'),
                             labels = c('Collective turn', 'Split'),
                             values = c('dodgerblue3', 'darkred')) +
  ggplot2::labs(x = '', 
                y = 'Centrality \n', 
                title = 'Centrality') +
  ggplot2::theme(legend.position = 'none',
                 text = ggplot2::element_text(family = 'Palatino Linotype'),
                 axis.text = ggplot2::element_text(size = 16, face = "bold", color = 'black'),
                 axis.title = ggplot2::element_text(size = 18, face = "bold"),
                 plot.title = ggplot2::element_text(size = 18, hjust = 0.5, face = "bold")) +
  ggplot2::scale_x_discrete(labels = c("turn" = "Collective \nturn", 
                                       "split" = "Splitting \nturn")) 

#centr

# ang_vels <- cowplot::plot_grid(angvel, centr, 
#                                nrow = 1,
#                                ncol = 2, 
#                                labels = c("A", "B"), 
#                                label_size = 20)

#ang_vels

# # Uncomment to save plot
# plot_path <- 'Figure4.png' # change path
# ggplot2::ggsave(
#   plot = ang_vels,
#   filename = plot_path,
#   width = 8.9,
#   height = 9,
#   dpi = 600
# )


##############################################################################
## Stats - GLMMs
##############################################################################

## 1. Main model
mod_main <- lme4::glmer(init ~  ang_vel 
                        + centr
                        + (1|study.flight) 
                        + (1|pigeon) 
                        , data = emp_data, 
                        family = binomial)

summary(mod_main)
simout_main <- DHARMa::simulateResiduals(fittedModel = mod_main, plot = T)
DHARMa::testDispersion(simout_main, type = 'PearsonChisq', alternative = 'greater', plot = F) 
DHARMa::testZeroInflation(simout_main)
DHARMa::plotResiduals(simout_main, form = emp_data$ang_vel)

# Check for multicollinearity
performance::check_collinearity(mod_main)

## 2. Excluding outliers of centrality
data_out <- subset(emp_data, 
                   dist2cent < quantile(emp_data$dist2cent, 0.9)
)

mod_out <- lme4::glmer(init ~ ang_vel 
                       + centr
                       + (1|study.flight) 
                       + (1|pigeon) 
                       , data = data_out, 
                       family = binomial)

summary(mod_out)
simout_noout <- DHARMa::simulateResiduals(fittedModel = mod_out, plot = T)
DHARMa::testDispersion(simout_noout, type = 'PearsonChisq', alternative = 'greater', plot = F) 
DHARMa::plotResiduals(simout_noout, form = data_out$ang_vel)
DHARMa::plotResiduals(simout_noout, form = data_out$dist2cent)


## 3. Close to predator

data_close <- subset(data_out, 
                     dist2pred < 100
)

mod_close <- lme4::glmer(init ~  ang_vel 
                         + centr # * small.big
                         + (1|study.flight) 
                         + (1|pigeon) 
                         , data = data_close,
                         family = binomial)

summary(mod_close)
simout_noout_close <- DHARMa::simulateResiduals(fittedModel = mod_close, plot = T)
DHARMa::testDispersion(simout_noout_close, type = 'PearsonChisq', alternative = 'greater', plot = F) 
DHARMa::plotResiduals(simout_noout_close, form = data_close$ang_vel)
DHARMa::plotResiduals(simout_noout_close, form = data_close$dist2cent)


######################################################
## Splitting rate
split_freqs <- read.csv('../Data/empirical/split_freqs.csv')

freqs_p <- split_freqs[split_freqs$condition == 'p', 'spltfreq']
print('N with predator: '); sum(split_freqs[split_freqs$condition == 'p', 'tot_split'])
summary(freqs_p)
freqs_c <- split_freqs[split_freqs$condition == 'c', 'spltfreq']
print('N without predator: ');sum(split_freqs[split_freqs$condition == 'c', 'tot_split'])
summary(freqs_c)

ks.test(freqs_p, freqs_c)

######################################################
## Collective turns

# predator vs control
turns_pred <- read.csv('../Data/empirical/col_turns_pred.csv')
turns_ctrl <- read.csv('../Data/empirical/col_turns_control.csv') #'data/empirical/turns_control.csv')
turns_ctrl <- turns_ctrl[complete.cases(turns_ctrl$ang_vel),]
turns_pred <- turns_pred[complete.cases(turns_pred$ang_vel),]

# apply threshold for real turns
durt_l <- 0.2
angv_l <- 10
angv_h <- quantile(abs(turns_pred$ang_vel), 0.99, na.rm = TRUE)

turns_pc <- FlockAnalyzeR::clean_turns(turns_pred, dur_thresh_l = durt_l, ang_vel_t_l = angv_l, ang_vel_t_h = angv_h)
tn <- length(turns_pc[,1])/length(turns_pred[,1])
print(paste0(round(tn,2) * 100, '% of predator turns are above 10 deg/s'))

angv_h <- quantile(abs(turns_ctrl$ang_vel), 0.99, na.rm = TRUE)
turns_cc <- FlockAnalyzeR::clean_turns(turns_ctrl, dur_thresh_l = durt_l, ang_vel_t_l =  angv_l, ang_vel_t_h =  angv_h)
tn <- length(turns_cc[,1])/length(turns_ctrl[,1])
print(paste0(round(tn,2) * 100, '% of control turns are above 10 deg/s'))


print('N with predator: '); nrow(turns_pc)
print('N without predator: ');nrow(turns_cc)

## Stats ###################
## Flight-time spent turning 

pc_tf <- c()
for (i in unique(turns_pred$flight))
{
  pc_tf <- c(pc_tf, sum(turns_pc[turns_pc$flight==i, 'dur']) / sum(turns_pred[turns_pred$flight==i, 'dur']))
}
cc_tf <- c()
for (i in unique(turns_ctrl$flight))
{
  cc_tf <- c(cc_tf, sum(turns_cc[turns_cc$flight==i, 'dur']) / sum(turns_ctrl[turns_ctrl$flight==i, 'dur']))
}
print('Flight-time spent while turning:')
ks.test(pc_tf, cc_tf)
summary(pc_tf)*100
summary(cc_tf)*100

#  Angle per second of flight
pc_tf <- c()
for (i in unique(turns_pred$flight))
{
  pc_tf <- c(pc_tf, sum(abs(turns_pc[turns_pc$flight==i, 'angle'])) / sum(turns_pred[turns_pred$flight==i, 'dur']))
}
cc_tf <- c()
for (i in unique(turns_ctrl$flight))
{
  cc_tf <- c(cc_tf, sum(abs(turns_cc[turns_cc$flight==i, 'angle'])) / sum(turns_ctrl[turns_ctrl$flight==i, 'dur']))
}

print('Angle turned per second of flight:')
ks.test(pc_tf, cc_tf)
summary(pc_tf)
summary(cc_tf)


#  Turning rate
pc_tf <- c()
for (i in unique(turns_pred$flight))
{
  pc_tf <- c(pc_tf, length(turns_pc[turns_pc$flight==i, 'dur']) / sum(turns_pred[turns_pred$flight==i, 'dur']))
}
cc_tf <- c()
for (i in unique(turns_ctrl$flight))
{
  cc_tf <- c(cc_tf, length(turns_cc[turns_cc$flight==i, 'dur']) / sum(turns_ctrl[turns_ctrl$flight==i, 'dur']))
}

print('Turning rate:')
ks.test(pc_tf, cc_tf)
summary(pc_tf)
summary(cc_tf)

# Collective Escape of Pigeons

This repository contains code and data used in the project on patterns of collective escape in flocks of pigeons:

*Papadopoulou M, Hildenbrandt H, Sankey DWE, Portugal SJ, and Hemelrijk CK. "Emergence of splits and collective turns in pigeon flocks under predation". Submitted.*

The code provided is open source, but we ask you to cite the above paper if you make use of it. 

## Code
All analysis is performed in _R_, version 3.6 or later. See DESCRIPTION for details on depedencies. 

- figure1.R: reproduces Figure 1.
- figure2_withstats.R: reproduces Figure 2 with the statistical analysis related to it.
- figure3_withstats.R: reproduces Figure 3 with the statistical analysis related to it.
- table1.R: statistical analysis presented in Table 1. 
- supFigure_*: files to reproduce supplementary figures

## Data

**Empirical data** are collected and preprocessed by Daniel W. E. Sankey, first published in:

*Sankey DWE, Storms RF, Musters RJ, Russell WT, Hemelrijk CK, Portugal SJ. (2021). "Absence of “selfish herd” dynamics in bird flocks under threat". Current Biology. https://doi.org/10.1016/j.cub.2021.05.009.*

The data comprise analysed GPS tragectories of flocks of homing pigeons. Files:
- _flock_10_track.csv_: track of one flock, used in Figure 1. 
- _flock_10_pigeon65_split.csv_: track of one pigeon while being split from the flock, used in Figure 1.
- _ind_turns_pred.csv_: results of analysis on individual turning under predation, used in Figure 1.
- _ind_turns_outcome.csv_: angular velocity and distance to the flock center of individuals at the beginning of their turn, used in Figure 3 and to fit GLMMs.
- _split_freqs.csv_: results of our analysis on frequency of splitting events per flight, used in Table 1.
- _col_turns_pred.csv_: results of our analysis on collective turns of flocks under predation, used in Table 1.
- _col_turns_control.csv_: results of our analysis on collective turns of flocks in control flights, used in Table 1.

**Simulated data** are extracted by the extended version of the computational model [*HoPE*](https://github.com/marinapapa/HoPE-model) (Homing Pigeons Escape), an agent-based model adjusted to the collective escape of homing pigeons, developed by Marina Papadopoulou and Dr. Hanno Hildenbrandt for a project on [self-organized collective escape of pigeons](https://github.com/marinapapa/SelfOrg-ColEsc-Pigeons) and extended for this project. Files:

- _flock9_track_i1815.csv_: part of a track of one flock during a simulation run, used in Figure 1.
- _flock9_pigeon3_i1815.csv_: part of the track of one pigeon-agent while being split from the flock, used in Figure 1.
- _escape_outcomes.csv_: results of analysis on the outcome of an escape maneuver across our simulations, used in Figure 2 and supplementary.
- _turn_chars_summary.csv_: summary frequencies of escape outcome per initator characteristic, used in Figure 2.

## Contact
* For any further information, email **Marina Papadopoulou** at: <m.papadopoulou.rug@gmail.com>

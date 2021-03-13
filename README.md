# Collective Escape of Pigeons

This repository contains code and data used in the project on patterns of collective escape in flocks of pigeons, currently submitted to _Proceeding of the Royal Society B_:

*Papadopoulou M, Hildenbrandt H, Sankey DWE, Portugal SJ, and Hemelrijk CK. "Collective escape of pigeons: splits and collective turns emerge from a single escape maneuver". Manuscript submitted for publication.*

The code provided is open source, but we ask you to cite the above paper if you make use of it. 

## Code
All analysis is performed in _R_, version 3.6 or later. See DESCRIPTION for details on depedencies. 

- figure1.R: reproduces Figure 1.
- figure2_withstats.R: reproduces Figure 2 with the statistical analysis related to it.
- figure3_withstats.R: reproduces Figure 3 with the statistical analysis related to it.
- table1.R: statistical analysis presented in Table 1. 

## Data

**Empirical data** are collected and preprocessed by Daniel W. E. Sankey for the project:

*Sankey DWE, Storms RF, Musters RJ, Russell WT, Hemelrijk CK, Portugal SJ. Cooperation and defection in bird flocks under threat. Manuscript submitted for publication.*

currently under review. Data comprise analysed GPS tragectories of flocks of homing pigeons. Files:
- _flock_10_track.csv_: track of one flock, used in Figure 1. 
- flock_10_pigeon65_split.csv: track of one pigeon while being split from the flock, used in Figure 1.
- ind_turns_pred.csv: results of analysis on individual turning under predation, used in Figure 1.
- ang_vel_turns_emp.csv: angular velocity of individuals at the beginning of their turn, used in Figure 3.
- split_freqs.csv: results of our analysis on frequency of splitting events per flight, used in Table 1.
- col_turns_pred.csv: results of our analysis on collective turns of flocks under predation, used in Table 1.
- col_turns_control.csv.csv: results of our analysis on collective turns of flocks in control flights, used in Table 1.

**Simulated data** are extracted by the computational model *HoPE* (Homing Pigeons Escape), an agent-based model adjusted to the collective escape of homing pigeons, developped by Marina Papadopoulou and Dr. Hanno Hildenbrandt for this project. Files:

- flock9_track_i1815.csv: part of a track of one flock during a simulation run, used in Figure 1.
- flock9_pigeon3_i1815.csv: part of the track of one pigeon-agent while being split from the flock, used in Figure 1.
- escape_outcomes.csv: results of analysis on the outcome of an escape maneuver across our simulations, used in Figure 2.
- turn_chars_summary.csv: summary frequencies of escape outcome per initator characteristic, used in Figure 2.
- ang_vel_turns_sim.csv: angular velocity of the initiators' maneuver, used in Figure 3.

## Contact
* For any further information, email **Marina Papadopoulou** at: <m.papadopoulou.rug@gmail.com>

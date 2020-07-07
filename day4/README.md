MATLAB code accompanying Day 4 of the KCNI school
===============

Getting Started
---------------
1.  Please clone this repo (type on Linux, Mac):
```
git clone --recursive git@github.com:krembilneuroinformatics/kcni-school-lessons.git MyFolderKCNISchool
```
2. Set your environment using `'kcni_setup_paths'`


EEG Analysis
------------
1. Download the open source data file 'subject1.bdf' at `https://www.fil.ion.ucl.ac.uk/spm/data/eeg_mmn/`and place in a new folder */day4/eeg/data/
2. Set your environment using `'kcni_setup_paths'`
3. Main script is `'mmn_master_script'`

Assignments
------------
1. Use the HGF tutorial code to generate a specific subtype of MDD reflecting `anhedonia` in terms of reduced reward expectations.
	a. Which parameters did you change in order to achieve these belief trajectories?
	b. Could you obtain similar belief trajectories using a different set of parameters?

2. Use the EEG tutorial code to compare the top 30% of prediction error (PE) signals, generating pseudo-conditions and ERPs of the top 30% and bottom 30% of PE. 	
	a. Can you model these effects with DCM, and if yes, do you obtain the same connectivity parameter estimates?
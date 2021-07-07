MATLAB code accompanying Day 6 of the KCNI school
===============
This code runs on MATLAB R2020a, the license provided with this course. Please, contact the teacher or the TAs if you do not have access to this license.

Getting Started
---------------
1.  Please, clone this repository recursively. Otherwise, you will not have all the necessary toolboxes to run the code. You can do so using the following command:
```
git clone --recursive https://github.com/krembilneuroinformatics/kcni-school-lessons.git
```
2. Set your environment using `'kcni_setup_paths'`

Tutorial 1: Modeling Abnormal Beliefs
------------
1. Set your environment using `'kcni_setup_paths'`
2. Part 1: First steps with the HGF: Run `'HGF_tutorial_generate_task'` section by section (you can do so by clicking in the corresponding section of the script and clicking the 'Run and Advance' Button at the top of the Matlab window next to the green triangle labelled 'Run').
3. Part 2: Simulating prototypical patients: Run `'HGF_tutorial_generate_learners'` section by section

Tutorial 2: Modeling Neuroimaging Data
------------
1. Download the open source data file 'subject1.bdf' at `https://www.fil.ion.ucl.ac.uk/spm/data/eeg_mmn/`and place in a new folder */day4/eeg/data/
2. Set your environment using `'kcni_setup_paths'`
3. Main script is `'mmn_master_script'`

Assignments
------------
1. Use the HGF tutorial code to generate a specific subtype of a clinical condition that you would like to model (for example, MDD or Schizophrenia) reflecting.

	a. What clinical condition do you want to simulate?
	
	b. What parameters could you change to simulate belief trajectories corresponding to this condition?
	
	c. Could you obtain similar belief trajectories using a different set of parameters?

2. Use the Modeling Neuroimaging Data tutorial code to compare the top 30% of `prediction error (PE) signals` generating pseudo-conditions and ERPs of the top 30% and bottom 30% of PE. 	

	a. Can you model these effects with DCM, and if yes, do you obtain the same connectivity parameter estimates?

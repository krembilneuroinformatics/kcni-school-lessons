# kcni-school-lessons

**Under constuction**

**Note** - we are currently building the 2021 course content (set to start teaching on July 5th 2020)

There is still time to register for the 2021 school - register at https://www.camh.ca/en/education/continuing-education-programs-and-courses/continuing-education-directory/kcni-summer-school

## Are you looking for the 2020 content? 

The 2020 Summer School content is archive in the 2020 release https://github.com/krembilneuroinformatics/kcni-school-lessons/releases/tag/2020. 

## How to use git to clone this repo to your own computer
 
Note that some of the tutorial content and data is located within "submodules" - or pointers to other repo's. To get EVERYTHING use:

```sh
git clone --recurse-submodules https://github.com/krembilneuroinformatics/kcni-school-lessons.git
```

# The full schedule:

- [kcni-school-lessons](#kcni-school-lessons)
  - [Are you looking for the 2020 content?](#are-you-looking-for-the-2020-content)
  - [How to use git to clone this repo to your own computer](#how-to-use-git-to-clone-this-repo-to-your-own-computer)
- [The full schedule:](#the-full-schedule)
  - [Day 1: Welcome! Understanding clinical research questions and reproducible science (July 5, 2021)](#day1welcome-understanding-clinical-research-questions-and-reproducible-science-july-5-2021)
  - [Day 2: Applied ethics in machine learning and mental health (July 6, 2021)](#day2applied-ethics-in-machine-learning-and-mental-health-july-6-2021)
  - [Day 3: Fundamental methods for genomic and single-cell transcriptome analysis (July 7, 2021)](#day3fundamental-methods-for-genomic-and-single-cell-transcriptome-analysis-july-7-2021)
  - [Day 4: Brain Microcircuit Simulations of Depression (July 8, 2021)](#day4-brain-microcircuit-simulations-of-depression-july-8-2021)
  - [Day 5: Whole-Brain Modelling and Neuroimaging Connectomics (July 9, 2021)](#day5-whole-brain-modelling-and-neuroimaging-connectomics-july-9-2021)
  - [Day 6: Bayesian Models of Learning and Integration of Neuroimaging Data  (July 12, 2021)](#day6bayesian-models-of-learning-and-integration-of-neuroimaging-data--july-12-2021)
  - [Day 7: Digital Health and Population-Based Data Resources (July 13, 2021)](#day7digital-health-and-population-based-data-resources-july-13-2021)
  - [Day 8:  Integrative research methods and Final Panel Discussion (July 14, 2021)](#day8-integrative-research-methods-and-final-panel-discussion-july-14-2021)

## Day 1: Welcome! Understanding clinical research questions and reproducible science (July 5, 2021)

**Instructors:** Erin Dickie, Sean Hill, Dr Victor Tang, Dr Brett Jones

**TA's:** Sejal Patel, Kevin Kadak, Taha Morshedzadeh, Kevin Witczak

**Computing Environment**:
+ we will use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [click here for install instructions](https://github.com/krembilneuroinformatics/kcni-school-lessons/tree/master/envs#kcni-school-envs). 
+ Also grab Erin's reproducibiltiy slides from [here]( https://docs.google.com/presentation/d/1weWaancrZH39zGSc_5Ew2k6chshadA3QP-H2wRTSJyM/edit?usp=sharing)

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Welcome and Orientation | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/1) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Lecture 2:  Problems and opportunities in the diagnosis and treatment of major depression | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/2) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Workshop 1: Guiding principles for FAIR and open science | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/3) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Workshop 2: Tools for Reproducible Science | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/4) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|

## Day 2: Applied ethics in machine learning and mental health (July 6, 2021)

**Instructors:** Daniel Buchman, Marta Maslej & Laura Sikstrom

**Computing Environment**:
+ we will use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [click here for install instructions](https://github.com/krembilneuroinformatics/kcni-school-lessons/tree/master/envs#kcni-school-envs). 

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Introduction to AI Ethics | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/5) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Lecture 2:  Fairness and Health Equity | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/6) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Workshop 1: Research Design, Data Collection, Model Construction and Validation | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/7) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Workshop 2: Analysis, Interpretation and Knowledge Exchange and/or Translation | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/8) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|

## Day 3: Fundamental methods for genomic and single-cell transcriptome analysis (July 7, 2021)

**Instructors:** Dr. Shreejoy Tripathy & Dan Felsky 

**TA's:** Sonny Chen, Micaela Consens, Amin Kharaghani, Keon Arbabi

**Computing Environment**: we will continue to use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [click here for install instructions]

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Basics of Genotype, Central dogma, GWAS, and Polygenic Risk Scores | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/9) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Lecture 2:  Transcriptomics at the single-cell and bulk level level | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/10) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Workshop 1: Intro to transcriptomic data types, including single-cell and bulk RNAseq | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/11) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Workshop 2: Explore cellular changes in major depression using bulk and single-cell RNAseq data | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/12) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|


## Day 4: Brain Microcircuit Simulations of Depression (July 8, 2021)

**Instructors:** Etay Hay & Frank Mazza

**TA's** TBA

**Computing Environment**: we will use our custom python/neurophysiology docker, available at dockerhub `edickie/kcnischool-jupyter`. [go here for more info on setting up the environment](https://github.com/krembilneuroinformatics/kcni-school-lessons/blob/master/envs/README.md#running-the-jupyter-physiological-modeling-environment)


| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Modeling brain microcircuits activity in health and depression | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/13) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Lecture 2: Simulating EEG from brain microcircuits in health and depression | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/14) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Workshop 1: simulating neurons, microcircuits and EEG signals
 | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/15) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Workshop 2: exercises | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/16) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|


## Day 5: Whole-Brain Modelling and Neuroimaging Connectomics (July 9, 2021)

**Instructors:** Erin Dickie & John Griffiths

**TA's** Shreyas Harita, Jerrold Jeyachandra, Kevin Kadak

**Computing Environment**: we will use our custom python/neurophysiology docker, available at dockerhub `edickie/kcnischool-jupyter`. [go here for more info on setting up the environment](https://github.com/krembilneuroinformatics/kcni-school-lessons/blob/master/envs/README.md#running-the-jupyter-physiological-modeling-environment)


| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Introduction to neuroimaging connectomics | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/17) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Workshop 1: Calculating Neuroimaging Connectomes | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/18) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Lecture 2: Intro to whole-brain modelling (Lecture) | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/19) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Workshop 2:  simulating whole-brain activity, EEG, evoked responses, brain stimulation | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/20) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|

## Day 6: Bayesian Models of Learning and Integration of Neuroimaging Data  (July 12, 2021)

**Instructors:** Dr. Andreea Diaconescu

**TA's:** Colleen Charlton, Daniel Hauke, Peter Bedford, Povilas Karvelis

**Compute Environment**: MATLAB. 
- All students in the interactive stream should have been emailed a link to a temporary MATLAB license that can be used for this course. Contact KCNI.School@camh.ca with any questions.
- Additional setup instructions are available in the [day5 folder](https://github.com/krembilneuroinformatics/kcni-school-lessons/tree/master/day5#matlab-code-accompanying-day-4-of-the-kcni-school)

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Bayesian Models of Learning | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/21) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Tutorial 1:  Modelling Abnormal Beliefs (Delusions) | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/22) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Lecture 2: Integration of Neuroimaging and Electrophysiological Data | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/23) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Tutorial 2: Modelling Neuroimaging Data | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/24) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|


## Day 7: Digital Health and Population-Based Data Resources (July 13, 2021)

**Instructors:** Daniel Felsky, Abhi Pratap & Joanna Yu

**TA's**: Marta Maslej, Akshay Mohan, Grace Jacobs

**Computing Environment**: we will continue to use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [click here for install instructions]

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Digital Health for Mental health | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/25) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Lecture 2: Population-based resources and the BrainHealth Databank | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/26) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Workshop 1: accessing reproducible datasets from Synapse as part of integrated workflow | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/27) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Workshop 2: Introduction to interactive methods | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/28) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|

## Day 8:  Integrative research methods and Final Panel Discussion (July 14, 2021)

**Instructors:** Daniel Felsky & Abhi Pratap + All Instructor Panel

**TA's**: Mohamed Abdelhack, Marta Maslej

**Computing Environment**: we will continue to use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [click here for install instructions]

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Types of integrative research and Whole Person Modelling | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/29) |
| 10:30-10:45	| Morning Break |Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 10:45-12:15	| Workshop: SNF / Subtyping | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/30) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 1:00-2:30pm	 | Group Panel Discussion | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/31) |
| 2:30-2:45pm	 | Afternoon Break | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|
| 2:45-4:15pm	 | Final Social Hour? | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/32) |
| 4:30-5:00pm	|  Social Chat? / Q & A | Join us in [gather.town](https://gather.town/mshCrgMgr6v17lbm/kcni_school)|


# kcni-school-lessons

There is still time to register for the 2021 school (July 5-14, 2021) - register directly at the Chrowdcast event link https://www.crowdcast.io/e/kcni-summer-school-2021

## How to use git to clone this repo to your own computer
 
Note that some of the tutorial content and data is located within "submodules" - or pointers to other repo's. To get EVERYTHING use:

```sh
git clone --recurse-submodules https://github.com/krembilneuroinformatics/kcni-school-lessons.git
```

# The full schedule:

- [kcni-school-lessons](#kcni-school-lessons)
  - [How to use git to clone this repo to your own computer](#how-to-use-git-to-clone-this-repo-to-your-own-computer)
- [The full schedule:](#the-full-schedule)
  - [Day 1: Welcome! Understanding clinical research questions and reproducible science (July 5, 2021)](#day1welcome-understanding-clinical-research-questions-and-reproducible-science-july-5-2021)
  - [Day 2: Applied ethics in machine learning and mental health (July 6, 2021)](#day2applied-ethics-in-machine-learning-and-mental-health-july-6-2021)
  - [Day 3: Fundamental methods for genomic and single-cell transcriptome analysis (July 7, 2021)](#day3fundamental-methods-for-genomic-and-single-cell-transcriptome-analysis-july-7-2021)
  - [Day 4: Simulating Brain Microcircuit Activity and Signals in Mental Health (July 8, 2021)](#day4-simulating-brain-microcircuit-activity-and-signals-in-mental-health-july-8-2021)
  - [Day 5: Whole-Brain Modelling and Neuroimaging Connectomics (July 9, 2021)](#day5-whole-brain-modelling-and-neuroimaging-connectomics-july-9-2021)
  - [Day 6: Bayesian Models of Learning and Integration of Neuroimaging Data  (July 12, 2021)](#day6bayesian-models-of-learning-and-integration-of-neuroimaging-data--july-12-2021)
  - [Day 7: Digital Health and Population-Based Data Resources (July 13, 2021)](#day7digital-health-and-population-based-data-resources-july-13-2021)
  - [Day 8:  Integrative research methods and Final Panel Discussion (July 14, 2021)](#day8-integrative-research-methods-and-final-panel-discussion-july-14-2021)
- [Ways to connect with TA's instructors and classmates!](#ways-to-connect-with-tas-instructors-and-classmates)
- [Are you looking for the 2020 content?](#are-you-looking-for-the-2020-content)

## Day 1: Welcome! Understanding clinical research questions and reproducible science (July 5, 2021)

**Instructors:**  Sean Hill, Dr Victor Tang, Dr Brett Jones, Erin Dickie, & Sejal Patel

**TA's:** Kevin Kadak, Taha Morshedzadeh, Kevin Witczak

**Computing Environment**:
+ we will be introducing our rstudio and jupyter docker environments, available from dockerhub `edickie/kcnischool-rstudio:latest` & `edickie/kcnischool-jupyter:latest`[our docker setup instructions](./envs/README.md). 
+ Also grab Erin's reproducibiltiy slides from [here]( https://docs.google.com/presentation/d/1weWaancrZH39zGSc_5Ew2k6chshadA3QP-H2wRTSJyM/edit?usp=sharing)
+ launch rstudio binder example  [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day1rstudio] 
+ launch jupyter binder example  [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day1rstudio] 

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Welcome and Orientation + Neuroinformatics across scales - Sean Hill| Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/1) |
| 10:45-12:15	| Lecture 2:  Problems and opportunities in the diagnosis and treatment of major depression - Drs Victor Tang & Dr Brett Jones [download slides as pdf](day1/KCNISummerSchool-MDDClinicalTalk.pdf)| Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/2) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:30pm	 | Workshop 1: Guiding principles for FAIR and open science  - Erin Dickie & Sejal Patel| Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/3) |
| 2:45-4:15pm	 | Workshop 2: Tools for Reproducible Science - Erin Dickie & Sejal Patel rstudio example  [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day1rstudio]    jupyter example [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day1python] | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/4) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|

## Day 2: Applied ethics in machine learning and mental health (July 6, 2021)

**Instructors:** Daniel Buchman, Marta Maslej & Laura Sikstrom

**Computing Environment**:
+ setup instructions and code in [the day2 folder](day2/README.md)
+ we will use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [docker instructions](../kcni-school-lessons/envs/README.md)
+ open rstudio in binder [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day3rstudio]

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Introduction to AI Ethics | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/5) |
| 10:45-12:15	| Lecture 2:  Fairness and Health Equity | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/6) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:30pm	 | Workshop 1: Research Design, Data Collection, Model Construction and Validation | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/7)  [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day2rstudio]|
| 2:45-4:15pm	 | Workshop 2: Analysis, Interpretation and Knowledge Exchange and/or Translation | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/8) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|

## Day 3: Fundamental methods for genomic and single-cell transcriptome analysis (July 7, 2021)

**Instructors:** Dr. Shreejoy Tripathy & Dan Felsky 

**TA's:** Sonny Chen, Micaela Consens, Amin Kharaghani, Keon Arbabi

**Computing Environment**: we will continue to use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [docker instructions](../kcni-school-lessons/envs/README.md)

Run rstudio in binder [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day3rstudio] (Note: we are aware that binder does not have enough RAM for some bits)

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Basics of Genotype, Central dogma, GWAS, and Polygenic Risk Scores | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/9) |
| 10:45-12:15	| Lecture 2:  Transcriptomics at the single-cell and bulk level level | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/10) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:30pm	 | Workshop 1: Intro to transcriptomic data types, including single-cell and bulk RNAseq | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/11) [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day3rstudio] |
| 2:45-4:15pm	 | Workshop 2: Explore cellular changes in major depression using bulk and single-cell RNAseq data | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/12) [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day3rstudio] |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|


## Day 4: Simulating Brain Microcircuit Activity and Signals in Mental Health (July 8, 2021)

**Instructors:** Etay Hay & Frank Mazza

**Computing Environment**: we will use our custom python/neurophysiology docker, available at dockerhub `edickie/kcnischool-jupyter`. [go here for more info on setting up the environment](https://github.com/krembilneuroinformatics/kcni-school-lessons/blob/master/envs/README.md#running-the-jupyter-physiological-modeling-environment) You can also run the tutorial code intercatively in binder [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day45jupyter]

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Simulating brain microcircuit activity in mental health | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/13) |
| 10:45-12:15	| Lecture 2: Simulating EEG from brain microcircuits in mental health | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/14) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:15pm	 | Workshop 1: Simulating and analyzing spiking from neurons and microcircuits | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/15) [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day45jupyter] |
| 2:30-4:00pm	 | Workshop 2: Simulating and analyzing EEG signals from brain microcircuits | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/16) [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day45jupyter] |
| 4:00-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|



## Day 5: Whole-Brain Modelling and Neuroimaging Connectomics (July 9, 2021)

**Instructors:** Erin Dickie & John Griffiths

**TA's** Shreyas Harita, Jerrold Jeyachandra, Kevin Kadak

**Computing Environment**: we will use our custom python/neurophysiology docker, available at dockerhub `edickie/kcnischool-jupyter`. [go here for more info on setting up the environment](https://github.com/krembilneuroinformatics/kcni-school-lessons/blob/master/envs/README.md#running-the-jupyter-physiological-modeling-environment) This code can also be run in our school binder instance [![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day45jupyter]


| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Introduction to neuroimaging connectomics | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/17) |
| 10:45-12:15	| Workshop 1: Calculating Neuroimaging Connectomes | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/18) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:30pm	 | Lecture 2: Intro to whole-brain modelling (Lecture) | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/19) |
| 2:45-4:15pm	 | Workshop 2:  simulating whole-brain activity, EEG, evoked responses, brain stimulation | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/20) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|

## Day 6: Bayesian Models of Learning and Integration of Neuroimaging Data  (July 12, 2021)

**Instructors:** Dr. Andreea Diaconescu

**TA's:** Colleen Charlton, Daniel Hauke, Peter Bedford, Povilas Karvelis

**Compute Environment**: [MATLAB](https://www.mathworks.com/licensecenter/classroom/DC_3466915/). 
- All students in the interactive stream should have been emailed a link to a temporary MATLAB license that can be used for this course. Contact KCNI.School@camh.ca with any questions.

- Additional setup instructions are available in the [day6 folder](https://github.com/krembilneuroinformatics/kcni-school-lessons/tree/master/day6

| Time (EST) | Session | |
|---- |----|---|
| 10:45-12:15	| Tutorial 1:  Modelling Abnormal Beliefs (Delusions) | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/22) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:30pm	 | Lecture 2: Integration of Neuroimaging and Electrophysiological Data | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/23) |
| 2:45-4:15pm	 | Tutorial 2: Modelling Neuroimaging Data | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/24) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|


## Day 7: Digital Health and Population-Based Data Resources (July 13, 2021)

**Instructors:** Daniel Felsky, Abhi Pratap & Joanna Yu

**TA's**: Marta Maslej, Grace Jacobs, Mohamed Abdelhack, Amin Kharaghani, Milos Milic, Earvin Tio

**Computing Environment**: we will continue to use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [our docker setup instructions](../kcni-school-lessons/envs/README.md)

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Digital Health for Mental health | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/25) |
| 10:45-12:15	| Lecture 2: Population-based resources and the BrainHealth Databank | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/26) |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:30pm	 | Workshop 1: accessing reproducible datasets from Synapse as part of integrated workflow | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/27) |
| 2:45-4:15pm	 | Workshop 2: Introduction to interactive methods | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/28) |
| 4:30-5:00pm	| Daily Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|

## Day 8:  Integrative research methods and Final Panel Discussion (July 14, 2021)

**Instructors:** Daniel Felsky & Abhi Pratap + All Instructor Panel

**TA's**: Marta Maslej, Mohamed Abdelhack, Amin Kharaghani, Milos Milic, Earvin Tio

**Computing Environment**: we will continue to use our custom rstudio docker, available from dockerhub `edickie/kcnischool-rstudio:latest` [our docker setup instructions](../kcni-school-lessons/envs/README.md)

| Time (EST) | Session | |
|---- |----|---|
| 9:00-10:30	| Lecture 1: Types of integrative research and Whole Person Modelling | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/29) |
| 10:30-10:45	| Morning Break |Join us in [gather.town][link_gathertown]|
| 10:45-12:15	| Workshop: SNF / Subtyping | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/30)[![Binder](https://mybinder.org/badge_logo.svg)][link_binder_day78rstudio] |
| 12:15pm-1:00pm |	Lunch Break | Join us in [gather.town][link_gathertown]|
| 1:00-2:30pm	 | Group Discussion - Moderated by  | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/31) |
| 2:45-4:15pm	 | Final Social Hour? | Watch on [Crowdcast](https://www.crowdcast.io/e/kcni-summer-school-2021/32) |
| 4:30-5:00pm	|  Social Chat? / Q & A | Join us in [gather.town][link_gathertown]|

# Ways to connect with TA's instructors and classmates!

- join the conversation with school instructors on slack [slack invite link](https://join.slack.com/t/kcnisummerschool/shared_invite/zt-rnztc4vq-6Z5ACwR~W2OfYySNtzOJJA)
- come speak to us during the breaks in gather.town [gather.town link][link_gathertown]
- start a conversation about this content in our [github discussions board](https://github.com/krembilneuroinformatics/kcni-school-lessons/discussions) 
- Remember you can always re-watch content after the session ends on Chrowdcast [Chrowdcast Link](https://www.crowdcast.io/e/kcni-summer-school-2021)

# Are you looking for the 2020 content? 

The 2020 Summer School content is archive in the 2020 release https://github.com/krembilneuroinformatics/kcni-school-lessons/releases/tag/2020. 

[link_binder_day1rstudio]: http://mybinder.org/v2/gh/krembilneuroinformatics/example-r-repo/HEAD?urlpath=rstudio
[link_binder_day1python]: http://mybinder.org/v2/gh/krembilneuroinformatics/example-python-repo/HEAD
[link_binder_day2rstudio]: https://mybinder.org/v2/gh/mmaslej/Model-Evaluation-Activity.git/HEAD?urlpath=rstudio
[link_binder_day3rstudio]: https://mybinder.org/v2/gh/keon-arbabi/kcni-summer-school-day-3.git/HEAD?urlpath=rstudio
[link_binder_day45jupyter]: https://mybinder.org/v2/gh/krembilneuroinformatics/binder-jupyter-school/HEAD?urlpath=git-pull?repo=https://github.com/krembilneuroinformatics/kcni-school-lessons
[link_binder_day78rstudio]: http://mybinder.org/v2/gh/krembilneuroinformatics/kcni-school-lessons/HEAD?urlpath=rstudio
[link_gathertown]: https://gather.town/i/HmElpLkR


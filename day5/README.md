# KCNI School Day 5: Whole-Brain Modelling and Neuroimaging Connectomics

 [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/krembilneuroinformatics/kcni-school-lessons/)

Binder for other bits: [![Binder](https://mybinder.org/badge_logo.svg)](link_binder_day45jupyter)
Note: The binder link will not work for parts of some parts of notebook 3

Binder for Whole Brain Modelling [![Open in Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/JohnGriffiths/ScinetSS2020_BrainNetworkModelling/master)

## Part 1: Neuroimaging Connectomics

***Presented by*** *Dr. Erin Dickie and Dr. John Griffiths*

***Developed by*** *JG, ED, Neuro Carpentry, and many other good people*


## Part 2: Whole-Brain Modelling

***Presented by*** Dr. John Griffiths

***Developed by*** JG ( With essential contributions from: Julie Courtiol, Amanda Easson, Kelly Shen, Jerry Jeyachandra )



Ways to run these tutorials: 

1. In Google Colab (recommended)  
2. On a local Python installation  
3. In the Docker  
4. In the Binder  


---

## To run on Google Colab:

Click on the 'Open in Colab' link above

OR

Go to https://colab.research.google.com.

Click File --> Open --> Github

Copy and paste this URL: `https://github.com/krembilneuroinformatics/kcni-school-lessons`, then press Enter.

Choose the day5 notebook of interest 

Uncomment the contents of the cell with `!pip install` commands. 

## To run with Docker

The docker was recently (July 8) updated of these lessons - to work with docker - please pull the most recent version.

```sh
docker pull edickie/kcnischool-jupyter
```

The navigate to the folder and open:

```sh
# make sure you are in the kcni-school-lession folder
cd kcni-school-lessons

# start docker
docker compose up jupyter
```


#!/bin/bash


## either clone or pull the kcni-school-lessons 

LESSONS_DIR=$SCRATCH/kcni-school-data/kcni-school-lessons
if [ -d "$LESSONS_DIR" ]; then
  ### update lessons if they exist already ###
  echo "Updating the kcni-school-lessons repository"
  cd $SCRATCH/kcni-school-data/kcni-school-lessons
  git config --global user.name "KCNI student"
  git config --global user.email student@example.com
  git config --global core.editor "nano" #with this - at least vim will not open
  git commit -am  "staging all local modifications"
  git pull --recurse-submodules
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Cloning the kcni-school-lessons repository"
  mkdir $SCRATCH/kcni-school-data
  cd $SCRATCH/kcni-school-data
  git clone --recurse-submodules https://github.com/krembilneuroinformatics/kcni-school-lessons.git
fi

echo "Moving larger data into the repository"
scp /scinet/course/ss2020/5_neuroimaging/kcni_data/day1_workdir.zip $SCRATCH/kcni-school-data/kcni-school-lessons/day1/
scp -r /scinet/course/ss2020/5_neuroimaging/kcni_data/allen_brain $SCRATCH/kcni-school-data/kcni-school-lessons/day2/kcni_summer/

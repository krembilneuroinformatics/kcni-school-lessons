#!/bin/bash

+x

# a script to start-up the kcni rstudio environment on Scinet teach cluster..
rstudio_port=$1  ## first argument is the port number they will use
rstudio_psswd=$2 ## second argument is the password to feed to rstudio

echo "Starting the rstudio..now time to set up the tunnel"
echo "now time to set up the tunnel to $HOSTNAME"
echo "DO NOT CLOSE THIS TERMINAL - check intructions for the next step"
cd $SCRATCH
export RSTUDIO_PASSWORD=${rstudio_psswd}
singularity exec \
  --home $SCRATCH/kcni-school-data:/home/rstudio/kcni-school-data \
  --bind /scinet/course/ss2019/3/8_bayesianmri/rstudio_auth.sh:/usr/lib/rstudio-server/bin/rstudio_auth.sh \
  /scinet/course/ss2020/5_neuroimaging/containers/edickie_kcnischool-rstudio_latest-2020-06-26-a07309756986.sif \
  rserver \
  --auth-none 0 \
  --auth-pam-helper-path rstudio_auth.sh \
  --www-port ${rstudio_port}

#!/bin/bash

# a script to start-up the kcni rstudio environment on Scinet teach cluster..
my_port=$1  ## first argument is the port number they will use


echo "Starting the rstudio..now time to set up the tunnel"
echo "---------------------------------------------------"
echo "now time to set up the tunnel to $HOSTNAME"
echo "---------------------------------------------------"
echo "DO NOT CLOSE THIS TERMINAL - check intructions for the next step"

cd $SCRATCH
singularity exec \
  --home $SCRATCH/kcni-school-data:/home/rstudio/kcni-school-data \
  --bind /scinet/course/ss2020/5_neuroimaging/jupyter_call_helper.sh:/jupyter_call_helper.sh \
  /scinet/course/ss2020/5_neuroimaging/containers/edickie_kcnischool-jupyter_latest-2020-07-07.sif \
  /jupyter_call_helper.sh ${my_port}

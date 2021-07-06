#!/bin/bash

# a script to start-up the kcni rstudio environment on Scinet teach cluster..
export RSTUDIO_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')

echo "Starting the rstudio..now time to set up the tunnel"
echo "---------------------------------------------------"
echo "now time to set up the tunnel to $HOSTNAME"
echo "---------------------------------------------------"
echo "DO NOT CLOSE THIS TERMINAL - check intructions for the next step"
echo "" 
echo "The next step is to open a new terminal and type the next two lines" 
echo ""
echo "   ssh -L8787:localhost:${RSTUDIO_PORT} ${USER}@teach.scinet.utoronto.ca"
echo "   ssh -L${RSTUDIO_PORT}:localhost:${RSTUDIO_PORT} ${HOSTNAME}"
echo ""
echo ""
echo "The final step will be to open http://localhost:8787 in your browser"
echo ""
echo "DO NOT CLOSE THIS TERMINAL - check intructions above"

cd $SCRATCH
singularity exec \
  --home $SCRATCH/kcni-school-lessons \
  --bind /scinet/course/ss2020/5_neuroimaging/jupyter_call_helper.sh:/jupyter_call_helper.sh \
  /scinet/course/ss2020/5_neuroimaging/containers/edickie_kcnischool-jupyter_latest-2021-07-02.sif \
  /jupyter_call_helper.sh ${RSTUDIO_PORT}

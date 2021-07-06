#!/bin/bash

export sing_image=/scinet/course/ss2020/5_neuroimaging/containers/edickie_kcnischool-rstudio_latest-2021-07-03-20331903aa75.sif

## now picks a random port and password for you
export RSTUDIO_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
export PASSWORD=$(openssl rand -base64 8)

echo "Starting the rstudio..now time to set up the tunnel"
echo "now time to set up the tunnel to $HOSTNAME"
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
echo "Your username for rstudio will be:"
echo "  User: ${USER}"
echo "  passwort: ${PASSWORD}"
echo ""
echo "DO NOT CLOSE THIS TERMINAL - read the instructions printed above!"



export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

##NOTE##
# This is a local drive location I can write, you should be able
# to just set to a subfolder of your HPC home/scratch directory
export TMPDIR="${SCRATCH}/rstudio-tmp"

mkdir -p "$TMPDIR/tmp/rstudio-server"
uuidgen > "$TMPDIR/tmp/rstudio-server/secure-cookie-key"
chmod 0600 "$TMPDIR/tmp/rstudio-server/secure-cookie-key"

mkdir -p "$TMPDIR/var/lib"
mkdir -p "$TMPDIR/var/run"

# Also bind data directory on the host into the Singularity container.
# By default the only host file systems mounted within the container are $HOME, /tmp, /proc, /sys, and /dev.
##NOTE##
# You may need here just to replace the fourth bind option, or drop
cd $SCRATCH
singularity exec \
  --home $SCRATCH/kcni-school-lessons \
  --bind="$TMPDIR/var/lib:/var/lib/rstudio-server" \
  --bind="$TMPDIR/var/run:/var/run/rstudio-server" \
  --bind="$TMPDIR/tmp:/tmp" \
  ${sing_image} \
  rserver --www-port ${PASSWORD} --auth-none=0 --auth-pam-helper-path=pam-helper 



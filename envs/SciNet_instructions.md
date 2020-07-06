# working with tutorial code using SciNet

For those who can't get Docker installed on their personal machines. We have the option to use singularity on Compute Ontario resources instead! (Thank you Compute Ontario!)

To use this, please ask your TA, or email KCNI.school@camh.ca for at temporary username and password for the SciNet system.

Getting to these services looks complicated but all you should need one your local computer is a linux terminal or a linux terminal simulator. (I, for windows, use gitbash https://gitforwindows.org/, you could also use putty or mobaxterm.

# Part 1: For the rstudio-plink environment (Days 1, 2 and 5)

Note: this is not as fancy as what SciNet wants (with a debugjob). The without running a debugjob way...Ramses would not be impressed - but the queue isn't working..

To get access to the rstudio-plink environment - you need access to three things

- **SciNet Username**: contact the TA's or KCNI.school@camh.ca to get one!
    - referred to in code sections below as `<username>`
- **SciNet Passworkd**: should get this with your username
    - referred to in code sections below as `<password>`
- **Your very own port number**: pick a number between 2000-9999 and hold onto it!
    - referred to in code sections below as `<your-port>`

## Step 1.1 Connect to SciNet teach node

```sh
ssh <username>@teach.scinet.utoronto.ca
```

## Step 1.2 Set up the data

On the teach node we are going to clone and copy the relevant data into our personal scratch space.
We tried to simplify this step with the attached script.

```sh
source /scinet/course/ss2020/5_neuroimaging/setup_scinet_kcni_rstudio_env_part1.sh
```

## Step 1.3 start a debugjob

A debugjob will insure that we are not sitting on one of the most busy computers. It will timeout after 4 hours - but that is enough time for our tutorials!

```sh
debugjob -n 10 # debugjob is a custom script on SciNet that give you a debugjob
```

Take note of what "node" you are assigned. You will need this for later

## Step 1.4 start rstudio in singularity on SciNet

This part is kinda involved - but just copy and paste..
Note that you need to substitute `<your-password>` and `<your-port>` in the appropriate places

To do this - we have created a custom script to source.. it has two arguments ( and `<your-port>``<your-password>`).

```sh
source /scinet/course/ss2020/5_neuroimaging/setup_scinet_kcni_rstudio_env_part2.sh <your-port> <your-password>
```

For example: if your picked port 9798 and your password is "my_stupid_password"

```sh
source /scinet/course/ss2020/5_neuroimaging/setup_scinet_kcni_rstudio_env_part2.sh 9798 my_stupid_password
```

**DON'T CLOSE THIS TERMINAL!** open a new terminal for the next step

## Step 1.5 Set up a "tunnel" to connect your computer to the rstudio

Note: to do this step you need to pay attention to which "node" of Scinet you were assigned to when you typed `debugjob`.
This should again be echoed by the 1.3 script.

**OPEN ANOTHER TERMINAL, don't close the one from step 1.3** and type:

```sh
ssh -L8787:localhost:<my_port> <my_username>@teach.scinet.utoronto.ca
ssh -L<my_port>:localhost:<my_port> <my_debubjob_node>
```

For example:
In the situation where
+ <my_port> is 9798
+ <my_debugjob_node> is teach36
+ <my username> is scinetguest230@teach.scinet.utoronto.ca

```sh
ssh -L8787:localhost:9798 scinetguest230@teach.scinet.utoronto.ca
ssh -L9798:localhost:9798 teach36
```

Attaching the tunnel all the way out

## Step 1.6 open the browser on you local machine.


It will prompt for a username and password. This will be `<your-username>` and `<your-password>`



Open your browser (i.e. google-chrome, safari or firefox) and point your browser at localhost:8787 and you should see rstudio!!

# Part 2. Cloning the KCNI lesson Material

(Update: this will have been done during Step 1.3)

Inside the rstudio instance - you can clone the kcni school code into you home!

```sh
cd kcni-school-data
git clone --recurse-submodules https://github.com/krembilneuroinformatics/kcni-school-lessons.git
```

# Part 3: Getting the jupyter envs (for day 3)

```sh
singularity run \
  --home $SCRATCH/kcni_school_data:/home/neuro/ \
  /scinet/course/ss2020/5_neuroimaging/containers/edickie_kcnischool-jupyter_latest-2020-06-30-80999c06ecbb.sif
```

```sh
ssh -L8888:localhost:8888 <username>@teach.scinet.utoronto.ca
```

Then we can copy and paste the address that appears after own singularity run in our browser

For example I saw this message with the address to copy and paste..
```
Or copy and paste one of these URLs:
        http://teach01.scinet.local:8888/?token=0c4f675b02b88455630c12bd2cf9e41a64c4afa2e0861b6a
     or http://127.0.0.1:8888/?token=0c4f675b02b88455630c12bd2cf9e41a64c4afa2e0861b6a
```


The without running a debugjob way...Ramses would not be impressed


## appendix: how this was built by the instructors

We converted the docker containers to singularity containers so that they could be run on the SciNet HCP.

```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -v C:\Users\erin_dickie\data:/output --privileged -t --rm quay.io/singularity/docker2singularity edickie/kcnischool-rstudio:latest
```

```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -v C:\Users\erin_dickie\data:/output --privileged -t --rm quay.io/singularity/docker2singularity edickie/kcnischool-jupyter:latest
```

# working with tutorial code using SciNet

For those who can't get Docker installed on their personal machines. We have the option to use singularity on Compute Ontario resources instead! (Thank you Compute Ontario!)

To use this, please ask your TA, or email KCNI.school@camh.ca for at temporary username and password for the SciNet system.

Getting to these services looks complicated but all you should need one your local computer is a linux terminal or a linux terminal simulator. (I, for windows, use gitbash https://gitforwindows.org/, you could also use putty. *Some of our testers have found that this will not work with Mobaexterm*

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

## Step 3.1 Connect to SciNet teach node

*Just as in step 1.1 for rstudio*

```sh
ssh <username>@teach.scinet.utoronto.ca
```

## Step 3.2 Update the code and data

We can use the same script as we use previously to update the code and data. (Some last minute changes were added during the course)

```sh
source /scinet/course/ss2020/5_neuroimaging/setup_scinet_kcni_rstudio_env_part1.sh
```

It's possible that you have trouble pulling the data because of "merge conflicts". The easiest thing to do is actually to rename the repo you were working with yesterday and run the script again..

```sh
mv $SCRATCH/kcni-school-data $SCRATCH/kcni-school-data1
source /scinet/course/ss2020/5_neuroimaging/setup_scinet_kcni_rstudio_env_part1.sh
```


## Step 3.3 start a debugjob

*This step is also identical to what was done for rstudio (Step 1.3).*
A debugjob will ensure that we are not sitting on one of the most busy computers. It will timeout after 4 hours - but that is enough time for our tutorials!

```sh
debugjob -n 10 # debugjob is a custom script on SciNet that give you a debugjob
```

Take note of what "node" you are assigned. You will need this for later

## Step 3.4 start jupyter in singularity on SciNet

This part is kinda involved - but just copy and paste..
Note that you need to substitute `<your-port>` in the appropriate place

To do this - we have created a custom script to source.. it has one argument (`<your-port>`).
When this script runs, you will be prompted to input a password of your choice into the terminal. This will be your jupyter password.

```sh
source /scinet/course/ss2020/5_neuroimaging/setup_scinet_kcni_jupyter_env_part2.sh <your-port>
```

For example: if your picked port 9798

```sh
source /scinet/course/ss2020/5_neuroimaging/setup_scinet_kcni_jupyter_env_part2.sh 9798
```
When this script runs, you will be prompted to input a password of your choice into the terminal. This will be your jupyter password.
**DON'T CLOSE THIS TERMINAL!** open a new terminal for the next step

## Step 3.5 Set up a "tunnel" to connect your computer to the jupyter

*This is also exactly the same and we did for rstudio in step 1.5*

Note: to do this step you need to pay attention to which "node" of Scinet you were assigned to when you typed `debugjob`.
This should again be echoed by the 3.3 script.

**OPEN ANOTHER TERMINAL, don't close the one from step 3.3** and type:

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

## Step 3.6 open the browser on you local machine.

Open your browser (i.e. google-chrome, safari or firefox) and point your browser at [localhost:8787](localhost:8787) and you should see a jupyter prompt! It will ask you for a password. This is the password that you typed twice into the terminal during step 1.5.


## appendix: how this was built by the instructors

Under the hood. We are running singularity containers (not Docker containers) on SciNet. To get singularity images from our Docker images, we actually used two methods. (Both work)

The rstudio image was converted from Docker on Erin's local laptop using docker2singularity.

```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -v C:\Users\erin_dickie\data:/output --privileged -t --rm quay.io/singularity/docker2singularity edickie/kcnischool-rstudio:latest
```

The jupyter singularity image was built directly on SciNet using the following command

```sh
singularity build edickie_kcnischool-jupyter_latest-2021-07-02.sif docker://edickie/kcnischool-jupyter:latest
```

```sh
singularity build edickie_kcnischool-rstudio_latest-2021-07-02.sif docker://edickie/kcnischool-rstudio:latest
```

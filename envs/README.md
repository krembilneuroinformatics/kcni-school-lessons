# kcni-school-envs

A collection of docker environments for the KCNI Summer School

These dockers are posted to dockerhub so that they should be able to be "pulled" and run on any machine.

## How to run from the dockers

### Step 1. Install docker on your computer.

To install Docker follow the instructions at: https://www.docker.com/products/docker-desktop.

**If you have the "admin rights" (or the right to install software on the computer you are using)** This _should_ be relatively straight forward. Installing docker on some platforms (like Window's) usually means that you need to "allow virtualization" which is something that some workplace provided computers disable. If the installing docker is not possible at this time. See the next section (TBA) about accessing the environments via the Compute Canada Teach Cluster.

[**If you fail to install Docker, click here for instuctions to use SciNet resources**](https://github.com/krembilneuroinformatics/kcni-school-lessons/blob/master/envs/SciNet_instructions.md#working-with-tutorial-code-using-scinet)

You may need to configure file sharing with Docker using Docker Desktop. More on this below.

### Running the R and genomics environment

To start the R and genomics environment. Open up a terminal (in Windows this is PowerShell). And type:

** Note that this command has one "mount" or "bind" argument to allow you to attach one folder (or directory) from you computer to the container. This gives you one folder where you can read and write files from both you local computer programs, and from inside the container.

To download and install the software. When you run this - you should see a lot of things happening. Because Docker will first download the docker image or the software you need (~3G) then start up the environment. The "docker image" or the software will be saved to your computer, so this only needs to be run once..

```sh
## this installs the software
docker pull edickie/kcnischool-rstudio:latest
```

To run the system  - Remember to replace `<path/to/you/data>` with a location on your computer where you will be storing you KCNI school data)

```sh
## this runs the container
docker run --rm \
 -p 127.0.0.1:8787:8787 \
 -e DISABLE_AUTH=true \
 -v <path/to/your/data>:/home/rstudio/kcni-school-data \
 edickie/kcnischool-rstudio:latest
```

The first time you run this - you should see a lot of things happening. Because Docker will first download the docker image or the software you need (~3G) then start up the environment. The "docker image" or the software will be saved to your computer, so the next time you run this it will be faster.

Note: on window's powershell the `\` character doesn't work - so the link above needs to be all on one line..

```sh
docker run --rm -p 127.0.0.1:8787:8787 -e DISABLE_AUTH=true -v C:\Users\erin_dickie\data\kcni-school-data\:/home/rstudio/kcni-school-data edickie/kcnischool-rstudio:latest
```

When things calm down - you should see a message that "server" has start. It should end with `[services.d] done.`

I see:
```
[s6-init] making user provided files available at /var/run/s6/etc...exited 0.
[s6-init] ensuring user provided files have correct perms...exited 0.
[fix-attrs.d] applying ownership & permissions fixes...
[fix-attrs.d] done.
[cont-init.d] executing container initialization scripts...
[cont-init.d] add: executing...
Nothing additional to add
[cont-init.d] add: exited 0.
[cont-init.d] userconf: executing...
Skipping authentication as requested
[cont-init.d] userconf: exited 0.
[cont-init.d] done.
[services.d] starting services
[services.d] done.
```
That means it worked! Then open your browser and navigate to: http://localhost:8787/ and you should see your rstudio terminal!

#### If you get an error about space access..

Sometimes when you try to run the docker you will get a super long error about not having permissions. To fix this, you need to make sure that docker has permission to read and write to the drive on your computer. Usually this means opening the "Docker Desktop" application to change the settings.

In Docker Desktop click on Settings->Resources->File Sharing to open the file sharing menu. In this menu, click on the plus sign to add a drive or folder you would like docker to be able to read and write from.

Now you should be good to go!


#### Killing a running container (in order to switch your environment)

**Known Issue** when you come back to the school the next day. You may find that you get the error "port is already allocated". Because the software container from the day before is still running and attached to the port.

To fix the issue. We need to learn two more docker commands `docker container ls` and `docker container kill`. If you don't want to learn the next bit - you could also just restart your computer?

##### docker container ls

If you type `docker container ls`, you should see everything that docker is running on your computer at this time. In the example below I see that docker is running a container with rstudio in it that is connected to a port.

```
> docker container ls
CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS                      NAMES
393c478405d3        rstudio-plink:latest   "/init"             15 hours ago        Up 15 hours         127.0.0.1:8787->8787/tcp   priceless_turing
```

This container can be refered to in later commands in two ways.
1. `CONTAINER ID`, which is a random string associated with this container
    + in this example the `CONTAINER ID` is `393c478405d3`
2. `NAMES`, which is a random name that has been given to this container.
    + in this example, the `NAME` is `priceless_turing`

##### docker container kill

To make this container stop broadcasting to the port, we want need to kill it! We can kill a container by referring to it by either it's `CONTAINER ID` or it's `NAME`

```
docker container kill <container_id>
```

In the above example:

```
docker container kill priceless_turing
```

If we now run `docker container ls` we should see that `priceless_turing` is no longer there!

Now we can move on and run a new container! Like the one for our python environment!

### Running the Jyputer Physiological Modeling Environment

We created a second environment that contains python and a jupyter notebook environment for Physiological Modeling.
This one is build (or installed) with a very similar command.

Building the env.
```sh
docker pull edickie/kcnischool-jupyter:latest
```

To run the system  - Remember to replace `<path/to/you/data>` with a location on your computer where you will be storing you KCNI school data)

```sh
docker run --rm \
  -p 8888:8888 \
  -v <path/to/your/data>:/home/neuro/kcni-school-data \
  edickie/kcnischool-jupyter:latest
```


For Erin (on Windows) the command looks like this.

```sh
docker run --rm -p 8888:8888 -v C:\Users\erin_dickie\data\kcni-school-data\:/home/neuro/kcni-school-data edickie/kcnischool-jupyter:latest
```

When this runs - you should see a web address starting with is printed to terminal. Copy and Paste this address into your browser and you should see the a jupyter notebook home!


---

## how to edit and rebuild these dockers from the github repo

If you don't see any DockerFiles or subfolders in this repo. That is because the Dockerfiles are in a linked "submodule". To populate te submoddule and view the DockerFiles type.

```sh
git update submodule
```

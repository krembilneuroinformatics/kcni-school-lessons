Rstudio [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/keon-arbabi/kcni-summer-school-day-3.git/HEAD?urlpath=rstudio)

## KCNI School day 3 code

Click on the images above or the link below to run in a binder instance: 
https://mybinder.org/v2/gh/keon-arbabi/kcni-summer-school-day-3.git/HEAD?urlpath=rstudio

or navigate to this code within the `kcni-school-lessons` repo

```sh
## assuming you aleady cloned the repo using the command
## git clone --recurse-submodules https://github.com/krembilneuroinformatics/kcni-school-lessons.git

# make sure you are in the kcni-school-lession folder
cd kcni-school-lessons

# start docker
docker compose up rstudio
```

Then point your browser to http://localhost:8787/ and you should see your rstudio terminal!

More docker help is available in [envs/README.md](../envs/README.md)

## if you don't see anything inside the kcni-summer-school-day-3 folder

You might need to re-init the submodule

In a terminal type

```
git submodule init
git submodule update kcni-summer-school-day-3
```
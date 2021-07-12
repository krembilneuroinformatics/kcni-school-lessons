Rstudio [![Binder](https://mybinder.org/badge_logo.svg)](http://mybinder.org/v2/gh/krembilneuroinformatics/kcni-school-lessons/HEAD?urlpath=rstudio)

# KCNI Summer School Day 8 code

Click on the images above or the link below to run in a binder instance: 
http://mybinder.org/v2/gh/krembilneuroinformatics/kcni-school-lessons/HEAD?urlpath=rstudio

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
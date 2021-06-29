# day 1 reproducible code environments walk through

This folder contains to submodules to demo some ways to set up repos for binder

- `example-r-repo`: shows an example of an R environment where rstudio would open in binder
  - this is actually a link to https://github.com/krembilneuroinformatics/example-r-repo
- `example-python-repo`: shows and example for a python environment
  - this is actually a link to https://github.com/krembilneuroinformatics/example-python-repo

## opening google colab instead?

Go to https://colab.research.google.com.

Click File --> Open --> Github

Copy and paste this URL: `https://github.com/krembilneuroinformatics/example-python-repo`, then press Enter.

Choose the `example_python.ipynb` notebook

### Some important differences with colab

- *minus* colab uses it's own scienfic python install that is different from the kcni-school-env
  - you always start with their env and installation of new packages needs to happen inside the notebook
    - add install command block start with  `! pip install`
- *plus* colab is faster to boot up and doesn't automatically time out
- you can mount your google drive to the notebook for more space

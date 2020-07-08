my_port=$1

jupyter notebook password
jupyter notebook --port=${rstudio_port} --no-browser --ip=0.0.0.0

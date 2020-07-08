my_port=$1

jupyter notebook password
jupyter notebook --port=${my_port} --no-browser --ip=0.0.0.0

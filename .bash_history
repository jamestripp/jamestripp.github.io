ulimit -s 16384 
R --slave -e 'Cstack_info()["size"]'
ulimit -s 116384 
sudo ulimit -s 116384 
ulimit -s 16384 

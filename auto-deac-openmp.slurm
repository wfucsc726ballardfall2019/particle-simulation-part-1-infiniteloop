#!/bin/bash -l
#SBATCH -p small          
#SBATCH -N 1              # you'll never need more than 1 node for the serial code
#SBATCH --mem=32GB
#SBATCH -t 00:20:00       # adjust the amount of time as necessary
#SBATCH -J auto-serial
#SBATCH -o auto-serial.%j.stdout
#SBATCH -e auto-serial.%j.error
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mannlg15@wfu.edu,parssy18@wfu.edu

cd /deac/classes/csc726/$USER/particle-simulation-part-1-infiniteloop

make || exit 1

filename="parallel-${SLURM_JOB_ID}.txt"

./serial -n 500 -no -s $filename
./openmp -p 1 -n 500 -no -s $filename
./openmp -p 2 -n 500 -no -s $filename
./openmp -p 4 -n 500 -no -s $filename
./openmp -p 6 -n 500 -no -s $filename
./openmp -p 8 -n 500 -no -s $filename
./openmp -p 11 -n 500 -no -s $filename
./openmp -p 22 -n 500 -no -s $filename
./openmp -p 33 -n 500 -no -s $filename
./openmp -p 44 -n 500 -no -s $filename
./openmp -p 2 -n 1000 -no -s $filename
./openmp -p 4 -n 2000 -no -s $filename
./openmp -p 6 -n 3000 -no -s $filename
./openmp -p 8 -n 4000 -no -s $filename
./openmp -p 16 -n 8000 -no -s $filename
./openmp -p 32 -n 16000 -no -s $filename
./openmp -p 44 -n 22000 -no -s $filename
./autograder -v openmp -s $filename >> $filename

#!/bin/bash -l
#SBATCH -p small          
#SBATCH -N 1              # you'll never need more than 1 node for the serial code
#SBATCH --mem=32GB
#SBATCH --ntasks=44
#SBATCH -t 00:40:00       # adjust the amount of time as necessary
#SBATCH -J auto-parallel
#SBATCH -o output/auto-serial.%j.stdout
#SBATCH -e output/auto-serial.%j.error
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mannlg15@wfu.edu,parssy18@wfu.edu

cd /deac/classes/csc726/mannlg15/particle-simulation-part-1-infiniteloop

make || exit 1

filename="parallel-${SLURM_JOB_ID}.txt"

./serial -n 1000 -no -s $filename
./openmp -p 1 -n 1000 -no -s $filename
./openmp -p 2 -n 1000 -no -s $filename
./openmp -p 4 -n 1000 -no -s $filename
./openmp -p 6 -n 1000 -no -s $filename
./openmp -p 8 -n 1000 -no -s $filename
./openmp -p 11 -n 1000 -no -s $filename
./openmp -p 22 -n 1000 -no -s $filename
./openmp -p 33 -n 1000 -no -s $filename
./openmp -p 44 -n 1000 -no -s $filename
./openmp -p 2 -n 2000 -no -s $filename
./openmp -p 4 -n 4000 -no -s $filename
./openmp -p 6 -n 6000 -no -s $filename
./openmp -p 8 -n 8000 -no -s $filename
./openmp -p 16 -n 16000 -no -s $filename
./openmp -p 32 -n 34000 -no -s $filename
./openmp -p 44 -n 48000 -no -s $filename
./autograder -v openmp -s $filename >> $filename

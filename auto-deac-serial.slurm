#!/bin/bash -l
#SBATCH -p small          
#SBATCH -N 1              # you'll never need more than 1 node for the serial code
#SBATCH --mem=32GB
#SBATCH --tasks=44
#SBATCH -t 00:20:00       # adjust the amount of time as necessary
#SBATCH -J auto-serial
#SBATCH -o output/auto-serial.%j.stdout
#SBATCH -e output/auto-serial.%j.error
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mannlg15@wfu.edu,parssy18@wfu.edu

cd /deac/classes/csc726/$USER/particle-simulation-part-1-infiniteloop

make || exit 1

filename="serial-${SLURM_JOB_ID}.txt"

./serial -n 500 -no -s $filename
./serial -n 1000 -no -s $filename
./serial -n 2000 -no -s $filename
./serial -n 4000 -no -s $filename
./serial -n 8000 -no -s $filename
./autograder -v serial -s $filename >> $filename

#!/bin/bash -l
#SBATCH -N 6
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=8
#SBATCH --time=2-00:00:00
#SBATCH -p batch
#SBATCH -J lpscl
module load toolchain/intel
#module load module load devel/CMake/3.15.3-GCCcore-8.3.0
#module load chem/ASE/3.19.0-intel-2019b-Python-3.7.4
#setx PATH "%PATH%;C:"
PATH="/mnt/irisgpfs/users/sbanerjee/MBD-test/venv/bin:${PATH}"
export PATH
#source /home/users/sbanerjee/MBD-test/venv/bin/activate
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC="FALSE"

ulimit -s unlimited

#/mnt/irisgpfs/users/sbanerjee/MBD-test/venv/bin/python3
### For running FHI-aims through ASE
aims=/mnt/irisgpfs/projects/tcp/software/bin/aims.211010.scalapack.mpi.x
#aims=/mnt/irisgpfs/projects/tcp/software/bin/aims.x

srun -n $SLURM_NTASKS $aims > aims.out



#!/bin/bash -l
#SBATCH -N 6
#SBATCH --ntasks-per-node=28
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=48:00:00
#SBATCH -p batch
#SBATCH -J test

module load toolchain/intel
#module load module load devel/CMake/3.15.3-GCCcore-8.3.0
#module load chem/ASE/3.19.0-intel-2019b-Python-3.7.4
#setx PATH "%PATH%;C:"
PATH="/mnt/irisgpfs/users/sbanerjee/phonon_calc/py38/bin:${PATH}"
export PATH
#source /home/users/sbanerjee/MBD-test/venv/bin/activate
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC="FALSE"

ulimit -s unlimited

vibes run phonopy | tee log.phonopy
vibes output phonopy phonopy/trajectory.son --full

#aims=/mnt/irisgpfs/projects/tcp/software/bin/aims.211010.scalapack.mpi.x
#aims=/mnt/irisgpfs/projects/tcp/software/bin/aims.x
#vibes run phonopy | tee log.phonopy
#srun -n $SLURM_NTASKS $aims > aims_output.out
#/mnt/irisgpfs/users/sbanerjee/MBD-test/venv/bin/python3
### For running FHI-aims through ASE

#/mnt/irisgpfs/users/sbanerjee/MBD-test/venv/bin/python3 run_elasticity.py geometry.in



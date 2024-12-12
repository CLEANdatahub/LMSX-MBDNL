import sys
from ase.io import read, write
from ase.calculators.aims import Aims
from ase.calculators.calculator import kptdensity2monkhorstpack as k2m

Filename= sys.argv[1]

## Read geometry file
#Mol = read(Filename="geometry.in", format='aims', index=':') #aims format file used  as input but any other format can be used as well (e.g., xyx)
Mol = read("geometry.in")
rel = (("atomic_zora", "scalar"))
k_grid = list(k2m(Mol, 3.5, even=False))
cell = (("bfgs", "1e-2"))
hse = (("hse06", "0.11"))
grid = "light"
trajectory_name = "relax.traj"

def set_Calc(outfile): #This function returns the calculator to run FHI-aims

    aims_cmd = 'srun -n $SLURM_NTASKS /mnt/irisgpfs/projects/tcp/software/bin/aims.211010.scalapack.mpi.x > '+outfile
    species = "/work/projects/tcp/software/aims/aimsfiles/species_defaults" #If "tight" settings are required, change "light" by "tight"

    calc_aims = Aims(aims_command = aims_cmd,
                species_dir = species + "/" + grid,
                xc = hse,
                hse_unit =  "B",
                hybrid_xc_coeff = 0.25,
                many_body_dispersion_nl = 'beta=0.8',
                relativistic = rel,
                elpa_settings = 'two_step_solver',
                load_balancing = True,
                override_illconditioning = True,
                compute_forces = True,
                basis_threshold = 1.e-4,
                sc_accuracy_forces = 1e-3,
                energy_tolerance = 0.005,
                sc_accuracy_rho = 1e-5,
                sc_accuracy_eev = 1e-4,
                sc_accuracy_etot = 1E-6,
                #sc_accuracy_forces = 1E-4, #I changed from 1E-5
                sc_iter_limit = 100,
		#k_grid = list(5 5 3),
                k_grid = k_grid,
		relax_unit_cell = 'full',
 	        relax_geometry = cell,
           )

    return calc_aims


## Set ASE's calculator
calc = set_Calc('aims.out')
Mol.set_calculator(calc)

## Do calculation (i.e., run FHI-aims)
e = Mol.get_potential_energy()


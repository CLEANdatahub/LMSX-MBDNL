from ase.io import read, write
from ase.calculators.aims import Aims
from clusterx.super_cell import SuperCell
from clusterx.parent_lattice import ParentLattice
path = "./"
f = path+"geometry.in"
g = read(f)
platt1 = ParentLattice(g)
scell2 = SuperCell(platt1,[2,2,2])
scell2.write(filename = path+"2_2_2_geometry.in", format="aims")
#g.write(filename = path+"/geometry.in", format="aims")

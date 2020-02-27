import mdtraj
import numpy
import sys

def calc_pcoord(fname):
    traj = mdtraj.load(fname, top='system.top')
    dist = mdtraj.compute_distances(traj, [[0,1]], periodic=True)
    d_arr = numpy.asarray(dist)
    d_arr = d_arr*10
    return d_arr

input_file = sys.argv[1]
pcoord = calc_pcoord(input_file)
print(pcoord)

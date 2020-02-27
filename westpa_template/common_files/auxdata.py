import mdtraj
import numpy
import sys

def distance():
    traj = mdtraj.load("seg.nc", top='system.top')
    dist = mdtraj.compute_distances(traj, [[0,1]], periodic=True)
    d_arr = numpy.asarray(dist)
    d_arr = d_arr*10
    print(d_arr)

func = sys.argv[1]
func()

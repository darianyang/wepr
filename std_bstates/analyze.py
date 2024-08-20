import mdtraj as md
import numpy as np
import sys

traj_in = sys.argv[1]
data_out = sys.argv[2]

# load in the trajectory
traj = md.load(traj_in, top="1lst.prmtop")

all_molecules = traj.topology.find_molecules()
all_molecules.sort(key=lambda x: -len(x))
anchors2 = all_molecules[:2]
traj.image_molecules(anchor_molecules=anchors2)

# calc RMSD

# define cu location
cu1_idx = traj.topology.select("resid 238 and name Cu1")
cu2_idx = traj.topology.select("resid 239 and name Cu1")

copper_idx = np.array([cu1_idx, cu2_idx])

distance = md.compute_distances(traj, copper_idx.reshape(1,2))*10

# define all center of mass points that will be used for the planes
# define the bottom lobe
com_a1 = md.compute_center_of_mass(traj, select="resid 9 10 11 12 13 14 16 17 18 29 49 50 51 52 54 55 66 67 68 69 70 71 72 73 76 82 87 88 193 194 195 and name CA")

# define the top lobe
com_a2 = md.compute_center_of_mass(traj, select="resid 115 116 117 118 119 120 121 122 123 140 141 142 143 145 158 159 160 161 162 163 189 190 and name CA")

# define the two loops
com_a3 = md.compute_center_of_mass(traj, select="resid 89 191 and name CA")
com_a3_1 = md.compute_center_of_mass(traj, select="resid 89 and name CA")
com_a3_2 = md.compute_center_of_mass(traj, select="resid 191 and name CA")


# Two vectors, the first is the bottom lobe to the loop, the second is the top lobe to the loop
va1 = com_a1 - com_a3
va2 = com_a2 - com_a3

nframes = com_a1.shape[0]
data = np.zeros((nframes,3))

for idx in range(nframes):
    # Plane definition of bottom lobe to the two points of the loop
    pa1 = com_a3_1[idx]-com_a1[idx]
    pa2 = com_a3_2[idx]-com_a1[idx]
    na = np.cross(pa2, pa1)
    
    # Calculate the openning
    dot1 = np.dot(np.squeeze(va2[idx]), np.squeeze(na))
    mag_va2 = np.linalg.norm(va2[idx])
    mag_na = np.linalg.norm(na)
    ang1_value = dot1/(mag_va2*mag_na)
    if ang1_value < -1 or ang1_value > 1:
       ang1_value = np.round(ang1_value, decimals=1)
    ang1 = np.arccos(ang1_value)
    ang1_deg = 90-np.degrees(ang1)
    data[idx,1] = ang1_deg

for idx in range(nframes):
    # Plane definition of bottom lobe to the two points of the loop
    pa1 = com_a3_1[idx]-com_a1[idx]
    pa2 = com_a3_2[idx]-com_a1[idx]
    na = np.cross(pa2, pa1)
    # Calculate the twisting
    mag_b = np.linalg.norm(na)
    a = np.squeeze(va2[idx])
    b = np.squeeze(na)
    p = a - ((np.dot(a,b))/mag_b)*(b/mag_b)
    dot2 = np.dot(np.squeeze(p), np.squeeze(va1[idx]))
    mag_p = np.linalg.norm(p)
    mag_va1 = np.linalg.norm(va1[idx])
    ang2_value = dot2/(mag_p*mag_va1)
    if ang2_value < -1 or ang2_value > 1:
       ang2_value = np.round(ang2_value, decimals=1)
    ang2 = np.arccos(ang2_value)
    ang2_deg = np.degrees(ang2)
    if p[1] < (va1[idx,1]/va1[idx,0]*p[0]):
       ang2_deg = -ang2_deg
    data[idx,2] = ang2_deg

data[:,0] = distance.reshape(nframes,)

np.savetxt(data_out,data)

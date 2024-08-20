"""
Time course of 200ns, 200-400ns, 400-600ns
"""

import numpy as np
import matplotlib.pyplot as plt
plt.style.use('fig.mplstyle')

# load data
dir_names = np.loadtxt("weights.txt", usecols=0, dtype=str)
weights = np.loadtxt("weights.txt", usecols=1)

def build_pdist(dirs, weights=None, pc_name="pc_200ns.dat", data_len=20000):
    """
    Build pdist for a whole set of data files
    """
    # empty array to store data
    data = np.zeros((data_len * dirs.shape[0], 3))
    # load data
    for i, d in enumerate(dirs):
        print(d, data_len*i, data_len*(i+1))
        data[data_len*i:data_len*(i+1), :] = np.loadtxt(f"{d}/{pc_name}")

    if weights is not None:
        # create and fill weight array 
        weight_set = np.zeros((data_len * dirs.shape[0]))
        for i, w in enumerate(weights):
            weight_set[data_len*i:data_len*(i+1)] = w
        # generate 2D histogram
        hist, x_edges, y_edges = np.histogram2d(data[:,1], data[:,0], bins=100, density=True, weights=weight_set)
        #hist, x_edges, y_edges = np.histogram2d(data[:,1], data[:,0], bins=100)
        #hist = np.multiply(hist, )

    else:
        # generate 2D histogram
        hist, x_edges, y_edges = np.histogram2d(data[:,1], data[:,0], bins=100)
    
    # convert histogram counts to pdist (-ln(P(x)))
    hist = -np.log(hist / np.max(hist))
    # convert inf to max
    #hist[hist == np.inf] = np.nanmax(hist[hist != np.inf])
    
    # get bin midpoints
    midpoints_x = (x_edges[:-1] + x_edges[1:]) / 2
    midpoints_y = (y_edges[:-1] + y_edges[1:]) / 2

    return midpoints_x, midpoints_y, hist.T

# build a 3 panel pdist plot
data_files = ["pc_200ns.dat", "pc_400ns.dat", "pc_600ns.dat"]
# make plot objects
fig, axes = plt.subplots(ncols=4, figsize=(10,4), width_ratios=[1,1,1,0.1])

for ax, df in zip(axes, data_files):
    #X, Y, Z = build_pdist(dir_names, weights=None, pc_name=df)
    X, Y, Z = build_pdist(dir_names, weights, pc_name=df)

    # make plot and tranpose the histogram
    #plot = ax.pcolormesh(X, Y, Z, vmax=6)
    plot = ax.pcolormesh(X, Y, Z, vmax=15)

    # formatting
    ax.set(ylim=(25,55), xlim=(30,90), xticks=[40, 60, 80], yticks=[30, 35, 40, 45, 50], yticklabels=[])
    ax.grid()

#axes[0].set_yticks([30,35,40,45,50])
axes[0].set_yticklabels([30,35,40,45,50])

# labels
axes[0].set_ylabel("Cu(II)-Cu(II) Distance ($\AA$)")
axes[1].set_xlabel("Opening Angle ($\degree$)")
axes[0].set_title("200ns")
axes[1].set_title("400ns")
axes[2].set_title("600ns")


# make cbar
cbar = fig.colorbar(plot, cax=axes[3])
cbar.set_label("-ln P(x)")

#plt.show()
plt.tight_layout()
plt.savefig("std_md_conv.png", dpi=1200, transparent=True)


import numpy as np
import matplotlib.pyplot as plt

f1 = np.loadtxt("dmat_f1.out")
f1000 = np.loadtxt("dmat_f1000.out")

dmat_diff = np.subtract(f1, f1000)

plt.pcolormesh(dmat_diff)
plt.colorbar()

plt.savefig("test.pdf")

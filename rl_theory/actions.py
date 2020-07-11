import numpy as np
import sys

out = ""

filename = sys.argv[1]
print(filename)
actions = np.loadtxt(filename, dtype=int)
for row in range(actions.shape[0]):
    for col in range(actions.shape[1]):
        idx = (row * 3) + col + 1
        out += "\\defl{{action{}}}{{{}}}\n".format(idx, actions[row][col])

with open("temp_actions.tex", "w") as file:
    file.write(out)

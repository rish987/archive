import numpy as np

out = ""

rewards = np.loadtxt("rewards.dat", dtype=int)
for row in range(rewards.shape[0]):
    for col in range(rewards.shape[1]):
        idx = (row * 3) + col + 1
        out += "\\defl{{reward{}}}{{{}}}\n".format(idx, rewards[row][col])
with open("temp_rewards.tex", "w") as file:
    file.write(out)

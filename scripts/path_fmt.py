import sys

path = sys.argv[1]
path = path.replace("proof", "\\proofd") 
path = path.replace("note", "\\noted") 
#.replace("rl_theory/","")
path = path.replace("_", "\\_")
path = "{{\\tt {}}}".format(path)
print(path)

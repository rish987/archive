import sys
import os.path

path = os.path.relpath(sys.argv[2], sys.argv[1])
print(path)

import sys

path = sys.argv[1]
path_split_fmt = []
path_split = path.split("/")

links = []
for dir_i, dir in enumerate(path_split):
    if dir == "proof":
        path_split_fmt.append("\\proofd")
    elif dir == "note":
        path_split_fmt.append("\\noted")
    else:
        link = dir.replace("_", "\\_")
        if sys.argv[2] == "F":
            if dir_i < len(path_split) - 1:
                link_path = "/".join(path_split[0:dir_i + 3]) + "_"
            else:
                link_path = "/".join(path_split[0:dir_i + 1])
            link = "\\lnraw{{{}}}{{{}}}".format(link_path, link)

        path_split_fmt.append(link)

path = "{{\\tt{{}}{}}}".format("/".join(path_split_fmt))
print(path)

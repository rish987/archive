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
    elif dir == "topic":
        path_split_fmt.append("\\topicd")
    elif dir == "definition":
        path_split_fmt.append("\\definitiond")
    else:
        link = ""
        if dir == "archives":
            link = "/"
        else:
            link = dir.replace("_", "\\_")
        if sys.argv[2] == "F":
            if dir_i < len(path_split) - 1:
                link_path = "/".join(path_split[0:dir_i + 3]) + "_"
            else:
                link_path = "/".join(path_split[0:dir_i + 1])
            link = "\\ln{{{}}}{{{}}}".format(link_path, link)

        path_split_fmt.append(link)

path = "{{\\tt{{}}{}}}".format(path_split_fmt[0] + "/".join(path_split_fmt[1:]))
print(path)

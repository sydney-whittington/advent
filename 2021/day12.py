from collections import defaultdict

connections = defaultdict(list)
valid_paths =set() 

with open("day12_input.txt") as f:
    for line in f.readlines():
        one, two = line.strip().split("-")
        connections[one].append(two)
        connections[two].append(one)

# part 1
def explore(node, visited):
    for edge in node:
        if edge in visited and edge.islower():
            pass
        elif edge == "end":
            valid_paths.add((*visited, edge))
        else:
            explore(connections[edge], [*visited, edge])


# part 2
def explore_deeper(node, visited, double_checked):
    for edge in node:
        if edge in visited and edge.islower():
            if edge == "start" or edge == "end":
                pass
            elif double_checked is False:
                explore_deeper(connections[edge], [*visited, edge], True)
            else:
                pass
        elif edge == "end":
            valid_paths.add((*visited, edge))
        else:
            explore_deeper(connections[edge], [*visited, edge], double_checked)

# explore(connections["start"], ["start"])
explore_deeper(connections["start"], ["start"], False)

print (f"{len(valid_paths)} paths found")
# string_paths = [",".join(path) for path in valid_paths]
# for path in sorted(string_paths):
#     print(path)


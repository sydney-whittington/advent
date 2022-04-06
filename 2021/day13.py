import numpy as np
import parse

size_x = 0
size_y = 0
# get max x and y because i'm lazy
for line in open("day13_input.txt"):
    if line[0].isnumeric():
        y, x = map(int, line.strip().split(","))
        size_x = max(size_x, x)
        size_y = max(size_y, y)

grid = np.zeros((size_x+1, size_y+1))
steps = []

for line in open("day13_input.txt"):
    if line[0].isnumeric():
        y, x = map(int, line.strip().split(","))
        grid[x, y] = 1
    elif line[0].isalpha():
        steps.append(line)

# print(grid)

p = parse.compile("fold along {axis}={number:d}\n")
for step in steps:
    result = p.parse(step)

    if result["axis"] == "y":
        grids = np.vsplit(grid, (result["number"],))
        # slice off the fold line
        grid = grids[0] + np.flip(grids[1][1:,:], axis=0)

    elif result["axis"] == "x":
        grids = np.hsplit(grid, (result["number"],))
        grid = grids[0] + np.flip(grids[1][:,1:], axis=1)

# print(np.count_nonzero(grid))

for row in grid:
    print("".join(map(lambda x: "#" if x>0 else " ", row)))

    
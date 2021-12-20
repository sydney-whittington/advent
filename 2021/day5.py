import re
import itertools
from pprint import pprint

with open("day5_input.txt", "r") as f:
    lines = (line for line in f.readlines())

p = re.compile(r"(\d+),(\d+) -> (\d+),(\d+)")

grid = [[0]*1000 for i in range(1000)]

part_2 = True

for line in lines:
    x1, y1, x2, y2 = map(int, p.match(line).groups())
    # print(f"{x1=}, {y1=}, {x2=}, {y2=}")

    if not(x1 == x2) and not(y1 == y2):
        if part_2:
            if y1 < y2:
                y_range = range(y1, y2+1)
                if x1 < x2:
                    x_range = range(x1, x2+1)
                else:
                    x_range = range(x1, x2-1, -1)
            else:
                y_range = range(y1, y2-1, -1)
                if x1 < x2:
                    x_range = range(x1, x2+1)
                else:
                    x_range = range(x1, x2-1, -1)

            for x_i, y_i in zip(x_range, y_range):
                grid[y_i][x_i] += 1

        else:
            # print("Diagonal. Ignoring.")
            continue
    elif (x1 == x2) and not(y1 == y2):
        if y1 < y2:
            for i in range(y1, y2+1):
                grid[i][x1] += 1
        else:
            for i in range(y2, y1+1):
                grid[i][x1] += 1
    elif not(x1 == x2) and (y1 == y2):
        if x1 < x2:
            for i in range(x1, x2+1):
                grid[y1][i] += 1
        else:
            for i in range(x2, x1+1):
                grid[y1][i] += 1
    else:
        print("that is a point.")


# pprint(grid)

danger = len(list(filter(lambda x: x > 1, itertools.chain.from_iterable(grid))))
print(f"{danger=}")

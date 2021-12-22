from operator import mul
from functools import reduce

heightmap = []

with open("day9_input.txt", "r") as f:
    for line in f.readlines():
        heightmap.append([int(digit) for digit in line.strip()])

def is_low_point(x, y):
    point = heightmap[x][y]

    neighbors = [(x-1, y), (x+1, y), (x, y-1), (x, y+1)]
    low = True
    
    for x_n, y_n in neighbors:
        try:
            # negative indices don't break things in python
            if x_n > -1 and y_n > -1:
                low &= point < heightmap[x_n][y_n]
        except IndexError:
            pass

    return low

# day9
def risk_level(x, y):
    return heightmap[x][y]+1 if is_low_point(x, y) else 0

x_range = len(heightmap) 
y_range = len(heightmap[0])
print(sum((risk_level(x, y) for x in range(x_range) for y in range(y_range))))


# day9_2
usedmap = [[False]*y_range for row in heightmap]

def basin_size(x, y):
    usedmap[x][y] = True
    size = 1

    neighbors = [(x-1, y), (x+1, y), (x, y-1), (x, y+1)]

    for x_n, y_n in neighbors:
        try:
            if x_n > -1 and y_n > -1:
                neighbor_point = heightmap[x_n][y_n] 
                if neighbor_point < 9 and usedmap[x_n][y_n] is False:
                    size += basin_size(x_n, y_n)
        except IndexError:
            pass

    return size

def basin_rollup(x, y):
    return basin_size(x, y) if is_low_point(x, y) else 0

sizes = [basin_rollup(x, y) for x in range(x_range) for y in range(y_range)]
top_3 = sorted(sizes, reverse=True)[0:3]
print(reduce(mul, top_3, 1))

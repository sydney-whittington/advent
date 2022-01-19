from pprint import pprint
octopodes = []

with open("day11_input.txt", "r") as f:
    for line in f.readlines():
        octopodes.append([int(digit) for digit in line.strip()])

flashes = []
spent = []
def flash(x, y):
    neighbors = [(x-1, y), (x+1, y), (x, y-1), (x, y+1), (x-1, y-1), (x-1, y+1), (x+1, y-1), (x+1, y+1)]
    
    for x_n, y_n in neighbors:
        try:
            # negative indices don't break things in python
            if x_n > -1 and y_n > -1:
                octopodes[x_n][y_n] += 1
                if octopodes[x_n][y_n] == 10:
                    flashes.append((x_n, y_n))
        except IndexError:
            pass


# day 11
tally = 0
for timestep in range(1, 101):
    # remove this for part one
    break
    for x in range(len(octopodes)):
        for y in range(len(octopodes[0])):
            octopodes[x][y] += 1
            if octopodes[x][y] == 10:
                flashes.append((x, y))

    while len(flashes) > 0:
        x_f, y_f = flashes.pop(0)
        flash(x_f, y_f)
        spent.append((x_f, y_f))

    for x_s, y_s in spent:
        octopodes[x_s][y_s] = 0

    tally += len(spent)
    spent = []

print(f"Number of flashes: {tally}")

# day 11 part 2
total = len(octopodes) * len(octopodes[0])
for timestep in range(1, 10000):
    for x in range(len(octopodes)):
        for y in range(len(octopodes[0])):
            octopodes[x][y] += 1
            if octopodes[x][y] == 10:
                flashes.append((x, y))

    while len(flashes) > 0:
        x_f, y_f = flashes.pop(0)
        flash(x_f, y_f)
        spent.append((x_f, y_f))

    for x_s, y_s in spent:
        octopodes[x_s][y_s] = 0

    if len(spent) == total:
        print(f"Timestep synced: {timestep}")
        break

    spent = []
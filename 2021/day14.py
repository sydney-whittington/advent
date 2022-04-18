from collections import Counter
from tokenize import String

import parse

rules = {}


with open("day14_input.txt") as f:
    start = f.readline().strip()

    # skip the blank line
    f.readline()

    p = parse.compile("{:l}{:l} -> {:l}\n")
    for line in f.readlines():
        result = p.parse(line)
        rules[(result[0], result[1])] = result[2]
        

# part 1
polymer = start

def step(polymer: String):
    output = ""

    for pair in ((x, y) for x, y in zip(polymer, polymer[1:])):
        output += pair[0] + rules[pair]

    output += polymer[-1]
    return output

# for i in range(0,10):
#     polymer = step(polymer)

# c = Counter(polymer)

# part 2
totals = Counter()
for pair in ((x, y) for x, y in zip(polymer, polymer[1:])):
    totals[pair] += 1

# the last never changes so just save it off
last = polymer[-1]

def efficient_step(totals: Counter):
    new_totals = Counter()
    for key, value in totals.items():
        result = rules[key]
        new_totals[(key[0], result)] += value
        new_totals[(result, key[1])] += value 

    return new_totals

for i in range(0,40):
    totals = efficient_step(totals)

c = Counter()
for key, value in totals.items():
    # only include the first of each pair so we don't double count
    c[key[0]] += value

c[last] += 1

most = c.most_common()[0]
least = c.most_common()[-1]

print(most[1]-least[1])

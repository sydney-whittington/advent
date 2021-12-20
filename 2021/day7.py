# crabs = [16,1,2,0,4,2,7,1,2,14]
from functools import cache

with open("day7_input.txt") as f:
    crabs = list(map(int, f.readline().split(",")))

def align(crabs, position):
    return sum((abs(crab-position) for crab in crabs))


# this gets called a bajillion times and making lists is expensive
@cache
def helper_cost(distance):
    return sum(range(distance))

def align_2(crabs, position):
    return sum(helper_cost(abs(crab-position)+1) for crab in crabs)
    

print(min((align(crabs, i) for i in range(max(crabs)))))

print(min((align_2(crabs, i) for i in range(max(crabs)))))

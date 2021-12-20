import itertools
import re

from collections import Counter

extract = re.compile(r"([^\|]+) \| (.+)")

displays = []

with open("day8_input.txt") as f:
    for line in f.readlines():
        halves = extract.match(line)

        displays.append((halves.group(1).split(" "), halves.group(2).split(" ")))


def day8():
    count = 0
    # number of segments lit
    unique_segments = set((2, 3, 4, 7))

    for display in displays:
        count += sum((1 for digit in display[1] if len(digit) in unique_segments))

    print(f"{count=}")

def day8_2():
    # combinations of counts that make up each number, from
    # https://www.reddit.com/r/adventofcode/comments/rbj87a/2021_day_8_solutions/hnpad75/
    numbers = {'467889': 0, '89': 1, '47788': 2, '77889': 3, '6789': 4, '67789': 5, '467789': 6, '889': 7, '4677889': 8, '677889': 9}

    total = 0    
    for display in displays:
        counts = Counter()
        counts.update(itertools.chain.from_iterable(display[0]))

        value = 0
        for digit in display[1]:
            segments = [str(counts[c]) for c in digit]
            number = numbers[''.join(sorted(segments))]
            value = value * 10 + number

        total += value

    print(total)


day8_2()

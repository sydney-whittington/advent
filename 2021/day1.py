with open("day1_input.txt", "r") as f:
    depths = [int(line) for line in f.readlines()]

# depths = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

def day1():
    previous = depths[0]
    increased = 0
    for depth in depths[1:]:
        if depth > previous:
            increased += 1
        previous = depth

    print(f"{increased=}")

def day1_2():
    from collections import deque

    window = deque(maxlen=3)
    window.extend(depths[0:3])

    previous = sum(window)
    increased = 0

    for depth in depths[3:]:
        window.append(depth)
        sum_depth = sum(window)
        if sum_depth > previous:
            increased += 1
        previous = sum_depth

    print(f"{increased=}")

day1_2()
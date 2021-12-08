with open("day2_input.txt", "r") as f:
    commands = [line.split(' ') for line in f.readlines()]

def day2():
    depth = 0
    distance = 0
    for command in commands:
        direction, number = command
        number = int(number)

        if direction == "forward":
            distance += number
        elif direction == "down":
            depth += number
        elif direction == "up":
            depth -= number

    print(f"{depth=}, {distance=}, product={depth*distance}") 

def day2_2():
    depth = 0
    distance = 0
    aim = 0
    for command in commands:
        direction, number = command
        number = int(number)

        if direction == "forward":
            distance += number
            depth += number * aim
        elif direction == "down":
            aim += number
        elif direction == "up":
            aim -= number

    print(f"{depth=}, {distance=}, product={depth*distance}") 

day2_2()
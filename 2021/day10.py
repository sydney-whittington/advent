with open("day10_input_short.txt") as f:
    lines = f.readlines()


matches = {
    "(": ")",
    ")": "(",
    "<": ">",
    ">": "<",
    "{": "}",
    "}": "{",
    "[": "]",
    "]": "["}

corrupt_points = {
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137
}
autocomplete_points = {
    ")": 1,
    "]": 2,
    "}": 3,
    ">": 4
}


corrupt_score = 0
incomplete_score = 0
for line in lines:
    stack = []
    incomplete = True
    for char in line.strip():
        match char:
            case "(" | "<" | "{" | "[":
                stack.append(char)
            case _:
                previous = stack.pop()
                if matches[char] != previous:
                    # print(f"Expected {matches[previous]}, but found {char} instead.")
                    corrupt_score += corrupt_points[char]
                    incomplete = False
                    break

    if incomplete:
        print("Incomplete")
        line_score = 0
        for char in reversed(stack):
            # TODO: find match and add score
            print(char)



print(f"Corrupt score: {corrupt_score}")
print(f"Autocomplete score: {incomplete_score}")
                

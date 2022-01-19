with open("day10_input.txt") as f:
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
    "(": 1,
    "[": 2,
    "{": 3,
    "<": 4
}


corrupt_score = 0

incomplete_scores = []
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
            line_score *= 5
            line_score += autocomplete_points[char]

        incomplete_scores.append(line_score)



print(f"Corrupt score: {corrupt_score}")
# int will truncate off the remaining .5, 0 indexing means we get the middle value
print(f"Autocomplete score: {sorted(incomplete_scores)[int(len(incomplete_scores)/2)]}")
                

with open("day3_input.txt", "r") as f:
    numbers = [list(line.strip()) for line in f.readlines()]

def day3():
    digits = [0]*len(numbers[0])
    for number in numbers:
        for index, digit in enumerate(number):
            digits[index] += int(digit)

    digits = list(map(lambda x: x/len(numbers), digits))

    gamma = int(''.join(str(digit) for digit in map(lambda x: int(x>.5), digits)), base=2)
    print(f"gamma rate = {gamma}")
    epsilon = int(''.join(str(digit) for digit in map(lambda x: int(x<.5), digits)), base=2)
    print(f"epsilon rate = {epsilon}")

    print(f"product = {gamma*epsilon}")

def day3_2():
    from functools import reduce

    oxygen = numbers.copy()
    for index in range(len(numbers[0])):
        index_sum = reduce(lambda x, y: x + int(y[index]), oxygen, 0)
        average = index_sum/len(oxygen)
        common_digit = int(average>=.5)
        # need to make it a list to get its length
        oxygen = list(filter(lambda x: int(x[index])==common_digit, oxygen))
        if len(oxygen) == 1:
            break
        
    oxygen_number = int(''.join(str(digit) for digit in oxygen[0]), base=2)
    print(f"oxygen = {oxygen_number}")

    co2 = numbers.copy()
    for index in range(len(numbers[0])):
        index_sum = reduce(lambda x, y: x + int(y[index]), co2, 0)
        average = index_sum/len(co2)
        uncommon_digit = int(not average>=.5)

        co2 = list(filter(lambda x: int(x[index])==uncommon_digit, co2))
        if len(co2) == 1:
            break

    co2_number = int(''.join(str(digit) for digit in co2[0]), base=2)
    print(f"co2 = {co2_number}")

    print(f"product = {oxygen_number * co2_number}")



day3_2()